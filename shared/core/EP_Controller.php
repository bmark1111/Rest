<?php
(defined('BASEPATH')) OR exit('No direct script access allowed');

// todo: set up custom error pages for account not found, account disabled, account cancelled, and maintenance mode
// todo: create unit tests for the core controller
// todo: inactive accounts should be checked on the login instead of everywhere so that a SuperAdmin or Admin could still login

/**
 * EP_Controller
 *
 * @package Core
 * @author Joshwa Fugett
 * @version 0.17
 * @access public
 *
 * @description This class is the core controller that houses all of the functionality needed by every (most) controllers in all of our applications
 *      This controller may be extended further but in doing so you have to be careful that the extending class is included preferrably by adding it
 *      in through a library or similar method of loading that sticks to the standards instead of using hand built file paths. Please be aware of what
 *      this controller is doing fully before using as it is shared among all applications
 */
class EP_Controller extends MX_Controller
{
    private static $_instance = NULL; // instance to current EP_Controller

    private $sEnvironment = 'production'; // holds the environment variable, defaults to production in case we forget to set the variable
    private $bDbLoaded = FALSE; // this is used to determine if the dbutil class has been loaded which we must connect to ep_master first for this to be true
    private $aDbConfig = FALSE; // this holds the database config so that we can save some overhead when we need to switch databases
    public $nAccount = NULL; // this is the current account that the REST is being run for
    private $sClientDb = NULL; // this is the current (or previously) connected client database
	private $sPrefix = NULL; // used to store the database prefix if it exists
    private $currentModel = NULL;

    public  $nUserId = NULL; // used to store the session id for the user
    public  $sUserName = NULL; // used to store the username for the currently logged in user
    public  $sFullUserName = NULL; // used to store the username for the currently logged in user
	public  $nExpertId = NULL; // used to store the implementor associated with this account
	public  $nStimulusExpertId = NULL; // used to store the implementor associated with this account
    public $title = ''; // used to store the title for the header

    public $aDBs = array(); // used to store the various databases connections that we load up when old connections die out??
    public $current_migration_db = NULL; // this is used only for specific migration requirements don't try this at home unless you know what you're doing

    public static $isModuleExtendSession = FALSE;

	private static $environment_flag = false;

    /**
     * EP_Controller::__construct()
     *
     * @return - No Return Value
     */
    public function __construct()
    {
    	parent::__construct();

        // this is loaded at this point so we can use it to determine what REST we're accessing
        $this->load->helper('url');

		if(APPLICATION == 'REST' || APPLICATION == 'CLI')
        {
   	        // if the server environment variable has been set use it to override the environment
	        if (isset($_SERVER['ENVIRONMENT']))
	        {
	            $this->sEnvironment = $_SERVER['ENVIRONMENT'];
	        }

	        if (isset($_SERVER['PREFIX']))
	        {
	            $this->sPrefix = $_SERVER['PREFIX'] . '_';
	        }

			// build up the configuration information here
			//$this->load->database();		// commenting this out fixed the extra row at start in csv download files

			// switch to the configured DB
			$db = $this->config->item('database');
        	$this->switchDatabase($db['database']);
        }

        // set the current instance of the object to this if it's not already set
        if(!isset(self::$_instance))
        {
        	self::$_instance =& $this;
        }

		// set up any module and library path chaining for specific applications
		// We're doing this by adding the directories to the *end* of the list.
		// The $this->load->_add_module_path() function adds to the beginning of
		// the list and we want the current environment's directory to take precedence.
		switch (APPLICATION)
		{
		case 'CLI':
			$this->load->_ci_library_paths[] = SHAREPATH;
			break;
		case 'REST':
			break;
		}

		// load any remaining libraries that are necessary
        $this->loadLibraries();

		if (APPLICATION == 'REST')
		{
			$uri = explode('/', uri_string());
			if (!empty($uri[0]))
			{
				switch($uri[0])
				{
					case 'data':
						if($this->input->is_ajax_request())
						{
							if (!empty($_SERVER['PHP_AUTH_USER']) && !empty($_SERVER['PHP_AUTH_PW']) && !empty($_SERVER['HTTP_TOKENID']) && !empty($_SERVER['HTTP_REFERER']) && !empty($_SERVER['REMOTE_ADDR']))
							{	// query the database for the correct user & user session information
								$this->db->select('user.id, user_session.id as session_id, user_session.expire');
								$this->db->from('user_session');
								$this->db->join('user', 'user.id = user_session.user_id', 'left');
								$this->db->where('user_session.id', $_SERVER['HTTP_TOKENID']);
								$this->db->where('user_session.http_referrer', $_SERVER['HTTP_REFERER']);
								$this->db->where('user_session.ip_address', $_SERVER['REMOTE_ADDR']);
//								$this->db->where('user_session.expire > ', date('Y-m-d H:i:s'));
								$this->db->where('user.login', $_SERVER['PHP_AUTH_USER']);
								$this->db->where('user.pass', md5($_SERVER['PHP_AUTH_PW'] . $this->config->item('encryption_key')));
								$oQuery = $this->db->get();
								// make sure that only one result is found
								if ($oQuery->num_rows() != 1)
								{
									$this->ajax->set_header("You are not authorzed", '401');
									exit;
								}
								$uSession = $oQuery->row();

								// check if session has expired
								if (time() > strtotime($uSession->expire))
								{
									$this->ajax->set_header("EXPIRED", '401');
									exit;
								}

								// update the user_session 'expire' to 30 mins past now
								$data = array(
										'expire' => date('Y-m-d H:i:s', strtotime('+30 MINS'))
									);
								$this->db->where('id', $uSession->session_id);
								$this->db->update('user_session', $data); 

								// set the logged in user
								$this->nUserId = $uSession->id;
							}
						} else {
							$this->ajax->set_header("Not Found", '404');
							exit;
						}
//						if (empty($_SERVER['PHP_AUTH_USER']) || empty($_SERVER['PHP_AUTH_PW']) || $_SERVER['PHP_AUTH_USER'] != 'proovebio' || $_SERVER['PHP_AUTH_PW'] != 'Proove2014')
//						{
//							if($this->input->is_ajax_request())
//							{
//								$this->ajax->set_header("You are not authorzed", '401');
//								exit;
//							} else {
//								$this->ajax->set_header("Not Found", '404');
//								exit;
//							}
//						}
						break;
					case 'upload':
						break;
					case 'login':
					case 'logout':
						break;
					default:
						if($this->input->is_ajax_request())
						{
							$this->ajax->set_header("You are not authorzed", '401');
							exit;
						} else {
							$this->ajax->set_header("Not Found", '404');
							exit;
						}
						break;
				}
			} else {
				if($this->input->is_ajax_request())
				{
					$this->ajax->set_header("You are not authorzed", '401');
					exit;
				} else {
					$this->ajax->set_header("Not Found", '404');
					exit;
				}
			}
		}
		elseif(APPLICATION == 'XXXX')
		{
			$sUri = substr($_SERVER['REQUEST_URI'], 0, 35);

			if (!isset($_SESSION['id']) || (isset($_SESSION['id']) && $_SESSION['id'] == 0))
			{
				// allow ajax and hijack requests to go through, otherwise redirect to login
				if (substr($sUri, 0, 12) == '/user/hijack')
				{
					// do nothing
				} elseif(substr($sUri, 0, 6) != '/user/' || strpos($sUri,'heartbeat') !== FALSE) {
					if($this->input->is_ajax_request())
					{
						$this->ajax->setData('internals', array('logged_out' => 1));
						if ($this->uri->segment(2) != 'runAnalytics'){
							$this->ajax->output();
						}
					} else {
						// redirect to the login page
						redirect('/user/login');
					}
				}
			}

	        // set the public instance of the user id that is stored in the session
	        if(isset($_SESSION['id']))
	        {
				$this->nUserId = $_SESSION['id'];
			}

	        // set the public instance of the user name that is stored in the session
	        if(isset($_SESSION['uname']))
	        {
	            $this->sUserName = $_SESSION['uname'];
			}

	        if(isset($_SESSION['fullName']))
	        {
	            $this->sFullUserName = $_SESSION['fullName'];
			}

			// if it's an AJAX POST or an application page request, reset the session time
			if ((($this->input->is_ajax_request() && $_SERVER['REQUEST_METHOD'] == 'POST') ||
				!$this->input->is_ajax_request()) && !self::$isModuleExtendSession)
			{
				EP_Session::extendSession();
				self::$isModuleExtendSession = TRUE;
			}

			if (self::$environment_flag == false)
			{
				$this->js->addJsCode('var environment_flag = "'.ENVIRONMENT.'";');
				self::$environment_flag = true;
			}
			
/*			$this->db->from('setting');
			$this->db->where('name', 'timezoneselection');
			$query = $this->db->get();
			if ($query->num_rows() === 1 && !empty($query->row()->value)) 
			{
				$this->sTimeZone = $query->row()->value;
			} else {
				$this->sTimeZone = 'America/Los_Angeles';
			}
*/
			$this->db->from('user');
			$this->db->where('id', $this->nUserId);
			$query = $this->db->get();
			if ($query->num_rows() === 1 && !empty($query->row()->first_name))
			{
				$this->sFullUserName = $query->row()->first_name;
				if (!empty($query->row()->last_name))
				{
					$this->sFullUserName .= ' '.$query->row()->last_name;
				}
			}
		}
		elseif(APPLICATION == 'ADMIN')
		{
			// Used for the rss/atom newsfeed for Support News to bypass the ip whitelist:
			if ($this->uri->segment(1) == 'error' && $this->uri->segment(2) == 'newsfeed')
			{
				if(isset($this->session->userdata))
				{
					$this->nUserId = intval($this->session->userdata('user_id'));
				}
				return TRUE;
			}

			if(isset($this->session->userdata))
			{
				$this->nUserId = intval($this->session->userdata('user_id'));
			}
			$this->db->from('admin_user');
			$this->db->where('id', $this->nUserId);
			$query = $this->db->get();
			if ($query->num_rows() === 1 && !empty($query->row()->first_name))
			{
				$this->sUserName = $query->row()->username;
				$this->sFullUserName = $query->row()->first_name;
				if (!empty($query->row()->last_name))
				{
					$this->sFullUserName .= ' '.$query->row()->last_name;
				}
			}


			$ip_address = explode('.', $this->input->ip_address());

			$ip_whitelist = new ip_whitelist();
			$ip = '';
			for($i = 0; $i < count($ip_address); $i++)
			{
				if($i != 0)
				{
					$ip .= '.';
				}
				$ip .= $ip_address[$i];
				$ip_whitelist->orWhere('value', $ip);
			}
			$ip_whitelist->result();

			if($ip_whitelist->count() == 0)
			{
				log_message('error', 'User Failed IP Check with IP of ' . $this->input->ip_address());
				die('You don\'t have permission to access this application please contact the administrator.');
			}

	        if(isset($this->session->userdata))
	        {
	        	$this->nUserId = intval($this->session->userdata('user_id'));
			}
		}
    }

    /**
     * EP_Controller::switchDatabase()
     *
     * @description - allows us to switch databases or setup a new database connection from within our controllers
     * @param string $db - this is the name of the database to connect to
     * @param optional bool $return - this is whether you want the connection returned so you can have more than one connection open
     * @return - returns the database if $return was TRUE
     */
    public function switchDatabase($sDb, $oReturn = FALSE)
    {
        $this->sClientDb = $sDb;

		// see if the dbutil class is loaded, if so we can make sure a db exists prior to connecting
        if ($this->bDbLoaded && !$this->dbutil->database_exists($this->sPrefix . $sDb))
		{
            exit("<tt style=\"color: red; font-weight: bold\">The database couldn\'t be found.</tt>.");
        }

        // get the database configuration array
        if (!$this->aDbConfig)
        {
            $this->aDbConfig = $this->config->item('database');
       }

        // override which database we're connecting to
        $this->aDbConfig['database'] = $this->sPrefix . $sDb;

		if(in_array($sDb, $this->aDBs))
		{
			$oDb = $this->aDBs[$sDb];
		} else {
			$oDb = $this->load->database($this->aDbConfig, TRUE, TRUE);
	        $this->aDBs[$sDb] =& $oDb;
		}

        // if we're not returning set the CI db instance to the generated database
        if (!$oReturn)
        {
            CI::$APP->db = $oDb;
        }

        // if the database utility library hasn't been loaded before load it here since we now have a connection
        if(!$this->bDbLoaded)
        {
            $this->load->dbutil();
            $this->bDbLoaded = TRUE;
        }

        // return the requested db if needed
        if($oReturn)
        {
            return $oDb;
        }
    }

//    /**
//     * EP_Controller::switchDatabase()
//     *
//     * @description - allows us to switch back to the original client database
//     * @return - NULL
//     */
//     public function revertToClientDatabase()
//     {
//        $this->switchDatabase($this->sClientDb);
//     }
//
//	public function switchMigrationDatabase($sDb, $oReturn = FALSE)
//    {
//    	// get the database configuration array
//        if (!$this->aDbConfig)
//        {
//            $this->aDbConfig = $this->config->item('database');
//        }
//
//        $this->current_migration_db = $sDb;
//
//        // override which database we're connecting to
//        $this->aDbConfig['database'] = $sDb;
//
//		if(array_key_exists($sDb, $this->aDBs))
//		{
//			$oDb = $this->aDBs[$sDb];
//		} else {
//			$oDb = $this->load->database($this->aDbConfig, TRUE, TRUE);
//	        $this->aDBs[$sDb] =& $oDb;
//		}
//
//        // if we're not returning set the CI db instance to the generated database
//        if (!$oReturn)
//        {
//            CI::$APP->db = $oDb;
//        }
//
//        // if the database utility library hasn't been loaded before load it here since we now have a connection
//        if(!$this->bDbLoaded)
//        {
//            $this->load->dbutil();
//            $this->bDbLoaded = TRUE;
//        }
//
//        // return the requested db if needed
//        if($oReturn)
//        {
//            return $oDb;
//        }
//    }
//
//    public function unsetMigrationDB($sDb)
//    {
//    	if(array_key_exists($sDb, $this->aDBs))
//		{
//			$oDb = $this->aDBs[$sDb];
//			$oDb->close();
//			unset($this->aDBs[$sDb]);
//		}
//    }

    /**
     * EP_Controller::getEnvironment()
     *
     * @description - returns the given environment for the server
     * @return string
     */
    public function getEnvironment()
    {
        return $this->sEnvironment;
    }

    /**
     * EP_Controller::loadLibraries()
     *
     * @description - loads any needed libraries
     * @return - NULL
     */
    private function loadLibraries()
    {
		if(APPLICATION == 'REST')
        {
			$this->load->helper('usage');
		}
		$this->load->helper('inflector');
        //$this->load->helper('form', 'inflector');
        $this->load->library(array('dataFormat', 'session', 'ajax', 'nagilum', 'css', 'js'));
//        $this->load->library(array('form_validation', 'dataFormat', 'session', 'ajax', 'css', 'js', 'nagilum', 'permissions', 'feature'));
//        $this->load->library(array('form_validation', 'dataFormat', 'ajax', 'css', 'js', 'nagilum', 'permissions', 'feature'));
       // $this->load->driver('cache', array('adapter' => 'memcached', 'backup' => 'file'));

        $this->form_validation->CI =& $this; // set the CI instance with form validation to the current controller

        // if the environment is not production and it's not an ajax request enable the profiler
        if(ENVIRONMENT == 'production')
        {
        	$this->output->enable_profiler(FALSE);
        } else {
        	if(!$this->input->is_ajax_request())
            {
                $this->output->enable_profiler($this->config->item('enable_profiler'));
            } else {
                $this->output->enable_profiler(FALSE);
            }
        }

//		// do not initialize sessions when in command line mode or admin area
//		if(APPLICATION == 'XXXX')
//		{
//			// initialize session; informing Session class if it's an Ajax GET request to ignore resetting TTL
//			$fSetTTL = TRUE;
//			if (uri_string() == '/dashboard/updateBadge')
//			{
//				$fSetTTL = FALSE;
//			}
//
//			EP_Session::init($this->db, $fSetTTL);
//
////			$this->load->library('userLocation');
//		}
    }

	/**
     * EP_Controller::getInstance()
     *
     * @description - This is used to help setup the singleton design pattern
     * @return - NULL
     */
    public static function getInstance()
	{
		return (self::$_instance);
	}

	public static function isInstance($obj)
	{
		if($obj !== self::$_instance)
			return FALSE;
		return TRUE;
	}

	/**
     * EP_Controller::_output()
     *
     * @description - This does some automatic replacement on the output to include the js and css
     * @param - $output - the passed in output for the page
     * @return - NULL
     */
	public function _output($output, $printMode = FALSE)
	{
    	$this->css->printMode = $printMode;
    	$this->js->printMode = $printMode;

//		$output = str_replace('{*JS*}', $this->js->output(), $output);
//		$output = str_replace('{*CSS*}', $this->css->output(), $output);

	    if($printMode)
	    {
	    	return $output;
	    }

	    echo $output;
	}
}

//EOF
<?php
/*
 * REST controller
 */

class rest_controller Extends EP_Controller
{
	protected $debug = TRUE;
	protected $sessionId = FALSE;

	public function __construct()
	{
		parent::__construct();

// TEMP UNTIL LOGIN DONE //
//$this->nUserId = 2;
// TEMP UNTIL LOGIN DONE //

//		if (!empty($_SERVER['HTTP_SESSIONID']))
//		{
//			$this->sessionId = $_SERVER['HTTP_SESSIONID'];
//		}
//		elseif ($this->controller != 'download' && $this->controller != 'count')
//		{
//			throw new Exception('Invalid session id');
//		}
	}

}

// EOF
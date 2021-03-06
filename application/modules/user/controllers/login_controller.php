<?php

class login_controller extends EP_Controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (login/index)"));
			$this->ajax->output();
		}

		$username = $_SERVER['PHP_AUTH_USER'];
		$password = $_SERVER['PHP_AUTH_PW'];

		if ($username == 'sadmin' && strncmp($_SERVER['REMOTE_ADDR'], '67.203.162.', 11) != 0 && $_SERVER['REMOTE_ADDR'] != '127.0.0.1')
		{
			$this->ajax->addError(new AjaxError('Your login credentials are incorrect'));
			$this->ajax->output();			// only allow super admin login from known IP range
		}

		$user = new user();

		$data['error'] = '';
		if (!empty($username) && !empty($password) && $user->login($username, $password))
		{
//print_r($_SERVER);die;
			$user->last_login		= date('Y-m-d H:i:s');
			$user->last_session_id	= md5(uniqid(mt_rand(), TRUE));
			$user->save();
			$this->ajax->setData('user', $user);
//print $user;
			$user_session = new user_session();
			$user_session->ip_address		= $_SERVER['REMOTE_ADDR'];
			$user_session->http_referrer	= $_SERVER['HTTP_REFERER'];
			$user_session->request_time		= date('Y-m-d H:i:s', $_SERVER['REQUEST_TIME']);
			$user_session->id				= $user->last_session_id;
			$user_session->user_id			= $user->id;
			$user_session->expire			= date('Y-m-d H:i:s', strtotime('+30 MINS'));
//print $user_session;
//die;
			$user_session->save();
		} else {
			$this->ajax->addError(new AjaxError('Your login credentials are incorrect'));
		}
		$this->ajax->output();
	}

}

// EOF
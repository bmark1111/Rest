<?php

class logout_controller extends EP_Controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (logout/index)"));
			$this->ajax->output();
		}

		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		$user_session = new user_session();
		$user_session->where('user_id', $_POST['userId']);
		$user_session->where('id', $_POST['token_id']);
		$user_session->row();
		if ($user_session->numRows())
		{	// expire the session
			$sql = "UPDATE user_session set expire = '" . date('Y-m-d H:i:s') . "' WHERE id = '" . $_POST['token_id'] . "' AND user_id = " . $_POST['userId'];
			$user_session->queryAll($sql);
		} else {
			$this->ajax->addError(new AjaxError("Error logging out - session not found"));
		}

		$this->ajax->output();
	}

}

// EOF
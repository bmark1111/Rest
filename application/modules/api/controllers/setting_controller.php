<?php
/*
 * REST Setting controller
 */

require_once ('rest_controller.php');

class setting_controller Extends rest_controller
{
	protected $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (setting/index)"));
		$this->ajax->output();
	}
	
	public function load()
	{
//print_r($_SERVER);die;
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (setting/load)"));
			$this->ajax->output();
		}
		
		$type = $this->input->get('type');
//die('setting/load ' . $type);
		switch ($type)
		{
			case 'bank':
				break;
			case 'budget':
				break;
			default:
				$this->ajax->addError('Invalid setting type');
				break;
		}

		$this->ajax->output();
	}

}

// EOF
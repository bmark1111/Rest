<?php
/*
 * REST Bank controller
 */

require_once ('rest_controller.php');

class bank_controller Extends rest_controller
{
	protected $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (bank/index)"));
		$this->ajax->output();
	}

	public function accounts()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (bank/accounts)"));
			$this->ajax->output();
		}

		$bank_accounts = new bank_account();
		$bank_accounts->whereNotDeleted();
		$bank_accounts->orderBy('name');
		$bank_accounts->result();
		foreach ($bank_accounts as $bank_account)
		{
			isset($bank_account->bank);
		}

		$this->ajax->setData('bank_accounts', $bank_accounts);

		$this->ajax->output();
	}

}

// EOF
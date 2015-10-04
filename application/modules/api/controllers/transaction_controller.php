<?php
/*
 * REST Transaction controller
 */

require_once ('rest_controller.php');

class transaction_controller Extends rest_controller
{
	protected $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/index)"));
		$this->ajax->output();
	}

	public function loadAll()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/loadAll)"));
			$this->ajax->output();
		}

		$params = $this->input->get();

		$date				= (!empty($params['date'])) ? $params['date']: FALSE;
		$description		= (!empty($params['description'])) ? $params['description']: FALSE;
		$amount				= (!empty($params['amount'])) ? $params['amount']: FALSE;
		$pagination_amount	= (!empty($params['pagination_amount'])) ? $params['pagination_amount']: 20;
		$pagination_start	= (!empty($params['pagination_start'])) ? $params['pagination_start']: 0;
		$sort				= (!empty($params['sort'])) ? $params['sort']: 'transaction_date';
		$sort_dir			= (!empty($params['sort_dir']) && $params['sort_dir'] == 'DESC') ? 'DESC': 'ASC';

		$transactions = new transaction();
		if ($date)
		{
			$date = date('Y-m-d', strtotime($date));
			$transactions->where('transaction.transaction_date', $date);
		}
		if ($description)
		{
			$transactions->like('description', $description);
		}
		if ($amount)
		{
			$transactions->where('amount', $amount);
		}
		$transactions->select('SQL_CALC_FOUND_ROWS *', FALSE);
		$transactions->whereNotDeleted();
		$transactions->limit($pagination_amount, $pagination_start);
		$transactions->orderBy($sort, $sort_dir);
		$transactions->result();

		$this->ajax->setData('total_rows', $transactions->foundRows());

		if ($transactions->numRows())
		{
			foreach ($transactions as $transaction)
			{
				isset($transaction->category);
			}
			$this->ajax->setData('result', $transactions);
		} else {
			$this->ajax->addError(new AjaxError("No transactions found"));
		}
		$this->ajax->output();
	}

	public function edit()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/edit)"));
			$this->ajax->output();
		}

		$id = $this->input->get('id');
		if (!is_numeric($id) || $id <= 0)
		{
			$this->ajax->addError(new AjaxError("Invalid transaction id - " . $id . " (transaction/edit)"));
			$this->ajax->output();
		}

		$transaction = new transaction($id);
		isset($transaction->splits);
		
		$this->ajax->setData('result', $transaction);

		$this->ajax->output();
	}

	public function save()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST') {
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/save)"));
			$this->ajax->output();
		}

		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		// VALIDATION
		$this->form_validation->set_rules('bank_account_id', 'Bank Account', 'required');
		$this->form_validation->set_rules('transaction_date', 'Date', 'required');
		$this->form_validation->set_rules('description', 'Description', 'required|max_length[150]');
		$this->form_validation->set_rules('type', 'Type', 'required|alpha');
		$this->form_validation->set_rules('category_id', 'Category', 'callback_isValidCategory');
		$this->form_validation->set_rules('amount', 'Amount', 'callback_isValidAmount');

		// validate split data
		if (!empty($_POST['splits'])) {
			foreach ($_POST['splits'] as $idx => $split) {
				if (empty($split['is_deleted']) || $split['is_deleted'] != 1) {
					$this->form_validation->set_rules('splits[' . $idx . '][amount]', 'Split Amount', 'required');
					$this->form_validation->set_rules('splits[' . $idx . '][type]', 'Split Type', 'required|alpha');
					$this->form_validation->set_rules('splits[' . $idx . '][category_id]', 'Split Category', 'required|integer');
				}
			}
		}

		if ($this->form_validation->ajaxRun('') === FALSE) {
			$this->ajax->output();
		}

		$id = (!empty($_POST['id'])) ? $_POST['id']: FALSE;
		$transaction = new transaction($id);
		$bank_account_id	= (!empty($transaction->bank_account_id)) ? $transaction->bank_account_id: FALSE;
		$transaction_date	= (!empty($transaction->transaction_date)) ? $transaction->transaction_date: FALSE;
		$amount				= (!empty($transaction->amount)) ? $transaction->amount: FALSE;
		$type				= (!empty($transaction->type)) ? $transaction->type: FALSE;
		$transaction->transaction_date	= date('Y-m-d', strtotime($_POST['transaction_date']));
		$transaction->description		= $_POST['description'];
		$transaction->type				= $_POST['type'];
		$transaction->category_id		= (empty($_POST['splits'])) ? $_POST['category_id']: NULL; // ignore category if splits are present
		$transaction->check_num			= (!empty($_POST['check_num'])) ? $_POST['check_num']: NULL;
		$transaction->amount			= $_POST['amount'];
		$transaction->notes				= (!empty($_POST['notes'])) ? $_POST['notes']: '';
		$transaction->bank_account_id	= $_POST['bank_account_id'];
		$transaction->save();

		if (!empty($_POST['splits'])) {
			foreach ($_POST['splits'] as $split) {
				$transaction_split = new transaction_split($split['id']);
				if (empty($split['is_deleted']) || $split['is_deleted'] != 1) {
					$transaction_split->description		= $split['description'];
					$transaction_split->amount			= $split['amount'];
					$transaction_split->transaction_id	= $transaction->id;
					$transaction_split->type			= $split['type'];
					$transaction_split->category_id		= $split['category_id'];
					$transaction_split->notes			= $split['notes'];
					$transaction_split->save();
				} else {
					$transaction_split->delete();
				}
			}
		}

//		if ($id !== FALSE && $amount !== FALSE) {
//			// deduct amount from bank account balance
//echo "bank_account_id = $bank_account_id\n";
//echo "transaction_date = $transaction_date\n";
//echo "amount = $amount\n";
//echo "type = $type\n";
////die('222222');
//			$this->adjustBankBalances($bank_account_id, $transaction_date, -$amount, $type, TRUE);
//		}
//die('111111');
//		// add new amount to bank account balance
//		$this->adjustBankBalances($transaction->bank_account_id, $transaction->transaction_date, $transaction->amount, $transaction->type);
/*		// now update the bank_account balances
		$bank_account_balances = new bank_account_balance();
		$bank_account_balances->whereNotDeleted();
		$bank_account_balances->where('date >= ', $transaction->transaction_date);
		$bank_account_balances->where('bank_account_id', $transaction->bank_account_id);
		$bank_account_balances->orderBy('date', 'ASC');
		$bank_account_balances->result();
//echo $bank_account_balances->lastQuery()."\n";
//print $bank_account_balances;
//die;
		if ($bank_account_balances->numRows()) {
			// found balances so update them
			$foundThisDate = FALSE;		// flags if we have found a balance record for the exact transaction date
			$bank_account_balance = FALSE;
			foreach ($bank_account_balances as $balance) {
				if ($balance->date == $transaction->transaction_date) {
					$foundThisDate = TRUE;	// we found a balance record for this transaction date exactly and updated it
				} elseif ($balance->date > $transaction->transaction_date && !$foundThisDate && $bank_account_balance === FALSE) {
					$bank_account_balance = new bank_account_balance();
					$bank_account_balance->bank_account_id	= $transaction->bank_account_id;
					$bank_account_balance->date				= $transaction->transaction_date;
					$bank_account_balance->balance			= $balance->balance;
					$bank_account_balance->save();
				}
				// calculate the new balance
				switch($transaction->type) {
					case 'DEBIT':
					case 'CHECK':
						$balance->balance -= $transaction->amount;
						break;
					case 'CREDIT':
					case 'DSLIP':
						$balance->balance += $transaction->amount;
						break;
				}
				$balance->save();
			}
		} else {
			// no balance found for date so find closest
			$bank_account_balance = new bank_account_balance();
			$bank_account_balance->whereNotDeleted();
			$bank_account_balance->select('bank_account_balance.*,MAX(date)');
			$bank_account_balance->where('bank_account_id', $transaction->bank_account_id);
			$bank_account_balance->row();
			if ($bank_account_balance->numRows()) {
				// found a close balance so create new record for this transaction date
				unset($bank_account_balance->id);	// this will ensure a new row is created
				$bank_account_balance->date = $transaction->transaction_date;
				switch($transaction->type) {
					case 'DEBIT':
					case 'CHECK':
						$bank_account_balance->balance -= $transaction->amount;
						break;
					case 'CREDIT':
					case 'DSLIP':
						$bank_account_balance->balance += $transaction->amount;
						break;
				}
				$bank_account_balance->save();
			} else {
				// no balance record found so create a new record
				// get the opening account balance and create a new account balance amount
				$bank_account = new bank_account($transaction->bank_account_id);
				$amount = $bank_account->amount;
				switch($transaction->type) {
					case 'DEBIT':
					case 'CHECK':
						$amount -= $transaction->amount;
						break;
					case 'CREDIT':
					case 'DSLIP':
						$amount += $transaction->amount;
						break;
				}

				$bank_account_balance = new bank_account_balance();
				$bank_account_balance->bank_account_id	= $transaction->bank_account_id;
				$bank_account_balance->date				= $transaction->transaction_date;
				$bank_account_balance->balance			= $amount;
				$bank_account_balance->save();
			}
		}
*/
		$this->ajax->output();
	}

	/*
	 * Checks is splits are entered, if not main category is a required field
	 */
	public function isValidCategory()
	{
		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		// if no splits then category is required otherwise MUST be NULL (will be ignored in Save)
		if (empty($_POST['splits']) && empty($_POST['category_id']))
		{
			$this->form_validation->set_message('isValidCategory', 'The Category Field is Required');
			return FALSE;
		}
		return TRUE;
	}

	/*
	 * Checks if splits are entered, if not main amount is required
	 *								if it is then checks that split amounts equal transaction amount
	 */
	public function isValidAmount()
	{
		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		if (!empty($_POST['splits']))
		{
			$split_total = floatval($_POST['amount']);
			foreach ($_POST['splits'] as $split)
			{
				if (empty($split['is_deleted']) || $split['is_deleted'] != '1')
				{
					switch ($split['type'])
					{
						case 'DEBIT':
						case 'CHECK':
							if ($_POST['type'] == 'DEBIT' || $_POST['type'] == 'CHECK')
							{
								$split_total -= floatval($split['amount']);
							} else {
								$split_total += floatval($split['amount']);
							}
							break;
						case 'CREDIT':
						case 'DSLIP':
							if ($_POST['type'] == 'CREDIT' || $_POST['type'] == 'DSLIP')
							{
								$split_total -= floatval($split['amount']);
							} else {
								$split_total += floatval($split['amount']);
							}
							break;
					}
				}
			}
			if ($split_total != 0) {
				$this->form_validation->set_message('isValidAmount', 'The Split amounts do not match the transaction amount');
				return FALSE;
			}
		} elseif (empty($_POST['amount']) || $_POST['amount'] == 0) {
			$this->form_validation->set_message('isValidAmount', 'The Amount Field is Required');
			return FALSE;
		}
		return TRUE;
	}

	public function delete() {
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/delete)"));
			$this->ajax->output();
		}

		$id = $this->input->get('id');
		if (!is_numeric($id) || $id <= 0) {
			$this->ajax->addError(new AjaxError("Invalid transaction id - " . $id . " (transaction/delete)"));
			$this->ajax->output();
		}
		
		$transaction = new transaction($id);
		if ($transaction->numRows()) {
			if (!empty($transaction->splits)) {
				foreach ($transaction->splits as $split) {
					$split->delete();
				}
			}
//			$this->adjustBankBalances($transaction->bank_account_id, $transaction->transaction_date, -$transaction->amount, $transaction->type, TRUE);

			$transaction->delete();
		} else {
			$this->ajax->addError(new AjaxError("Invalid transaction - (transaction/delete)"));
		}
		$this->ajax->output();
	}

}

// EOF
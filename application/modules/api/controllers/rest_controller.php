<?php
/*
 * REST controller
 */

class rest_controller Extends EP_Controller {

	protected $debug = TRUE;

	public function __construct() {
		parent::__construct();
//$this->_balanceUpdate();				// resets all bank balances
//die('XXXXXXXXXXXXXXXXXXXXXXXXXXXXx');
		$class = get_class($this);
		if ($class !== 'upload_controller') {
			if ($resetBalances = $this->appdata->get('resetBalances')) {	// get resets
				foreach($resetBalances as $account_id => $date) {
					// for each reset adjust the account balance
					$this->_adjustAccountBalances($date, $account_id);
				}
				$this->appdata->remove('resetBalances');	// remove the reset balances from app data
			}
		}
	}

	private function _balanceUpdate() {
		$bank_account_balances = array();
		$bank_accounts = new bank_account();
		$bank_accounts->result();
		if ($bank_accounts->numRows()) {
			foreach ($bank_accounts as $bank_account) {
				$bank_account_balances[$bank_account->id] = 0;
			}
			$transactions = new transaction();
			$transactions->whereNotDeleted();
			$transactions->orderBy('transaction_date', 'ASC');
			$transactions->orderBy('id', 'ASC');
			$transactions->result();
			if ($transactions->numRows()) {
				foreach ($transactions as $transaction) {
					$amount = 0;
					switch ($transaction->type) {
						case 'DEBIT':
						case 'CHECK':
							$amount -= $transaction->amount;
							break;
						case 'CREDIT':
						case 'DSLIP':
							$amount += $transaction->amount;
							break;
					}
					$bank_account_balances[$transaction->bank_account_id] += $amount;
					$transaction->bank_account_balance = $bank_account_balances[$transaction->bank_account_id];
					$transaction->save();
				}
			}
		}
	}

	/**
	 * @name _checkIsAValidDate
	 * @name {function}
	 * @param {date} $myDateString
	 * @return {bool}
	 */
	private function _checkIsAValidDate($myDateString){
		return (bool)strtotime($myDateString);
	}

	/**
	 * 
	 * @name resetAccountBalances
	 * @type {function}
	 */
	public function resetAccountBalances() {
		if ($_SERVER['REQUEST_METHOD'] != 'POST') {
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (reset/resetAccountBalances)"));
			$this->ajax->output();
		}

		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		if (!empty($_POST['accountBalancesResetDate']) && is_array($_POST['accountBalancesResetDate'])) {
			foreach ($_POST['accountBalancesResetDate'] as $account_id => $reset_date) {
				if ($this->_checkIsAValidDate($reset_date)) {
					$this->adjustAccountBalances($reset_date, $account_id);
				}
			}
		} else {
			$this->ajax->addError(new AjaxError("Invalid account reset date (reset/resetAccountBalances)"));
		}
		$this->ajax->output();
	}

	protected function resetbalances($resets) {
		$update = FALSE;
		$resetBalances = $this->appdata->get('resetBalances');	// get existing resets
		foreach ($resets as $account_id => $date) {
			if (empty($resetBalances[$account_id]) || strtotime($date) < strtotime($resetBalances[$account_id]))
			{	// found a lower date to reset to
				$resetBalances[$account_id] = $date;
				$update = TRUE;
			}
		}
		if ($update) {
			$this->appdata->set('resetBalances', $resetBalances);
		}
	}

	/**
	 * @name resetAccountBalances
	 * @type {function}
	 * @param {date} $original_transaction_date - original transaction date if it exists
	 * @param {date} $new_transaction_date - new transaction date
	 * @return {undefined}
	 */
//	protected function adjustAccountBalances($transaction_date, $account_id, $original_transaction_date = FALSE) {
	private function _adjustAccountBalances($transaction_date, $account_id) {
		if ($this->_checkIsAValidDate($transaction_date)) {
			// get the date from which to reset the bank account balance
			$transaction = new transaction();
			$transaction->select('MAX(transaction_date) AS date');
			$transaction->whereNotDeleted();
//			if ($original_transaction_date && $this->_checkIsAValidDate($original_transaction_date)) {
//				$transaction->where("transaction_date < '" . $original_transaction_date . "'", NULL, FALSE);
//			}
			$transaction->where("transaction_date < '" . $transaction_date . "'", NULL, FALSE);
			$transaction->where("bank_account_id", $account_id);
			$transaction->limit(1);
			$transaction->row();
			if (!empty($transaction->date)) {
				// now get the transactions that need the balance to be reset
				$transactions = new transaction();
				$transactions->whereNotDeleted();
				$transactions->where("transaction_date >= '" . $transaction->date . "'", NULL, FALSE);
				$transactions->where("bank_account_id", $account_id);
				$transactions->orderBy('transaction_date', 'ASC');
				$transactions->orderBy('id', 'ASC');
				$transactions->result();
//echo $transactions->lastQuery();
//die;
				if ($transactions->numRows()) {
					$first = TRUE;
					$bank_account_balances = array();
					foreach ($transactions as $transaction) {
						if (!$first || empty($transaction->bank_account_balance)) {
							switch ($transaction->type) {
								case 'DEBIT':
								case 'CHECK':
									$bank_account_balances[$transaction->bank_account_id] -= $transaction->amount;
									break;
								case 'CREDIT':
								case 'DSLIP':
									$bank_account_balances[$transaction->bank_account_id] += $transaction->amount;
									break;
							}
							$transaction->bank_account_balance = $bank_account_balances[$transaction->bank_account_id];
							$transaction->save();
						} else {
							$bank_account_balances[$transaction->bank_account_id] = $transaction->bank_account_balance;
							$first = FALSE;
						}
					}
				}
			}
		}
	}

	/*
	 * sd = we need the first available balance before this date
	 * bank_account_id = bank account id
	 */
	protected function getBankAccountBalance($sd, $account_id) {
		$transaction = new transaction();
		$transaction->whereNotDeleted();
		$transaction->where("transaction_date < '" . $sd . "'", NULL, FALSE);
		$transaction->where('bank_account_id', $account_id);
		$transaction->orderBy('transaction_date', 'DESC');
		$transaction->limit(1);
		$transaction->row();
//echo $transaction->lastQuery()."\n";
//print $transaction;die;
		if ($transaction->numRows()) {
			return $transaction->bank_account_balance;
		} else {
			return 0;
		}
	}
}

// EOF
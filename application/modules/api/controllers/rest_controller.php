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

	/*
	 * adjustBankBalances
	 * $original_transaction_date:	original transaction date if it exists
	 * $new_transaction_date:		new transaction date
	 */
	protected function adjustBankBalances($new_transaction_date, $original_transaction_date = FALSE) {
		// get the date from which to reset the bank account balance
		$transaction = new transaction();
		$transaction->select('MAX(transaction_date) AS date');
		$transaction->whereNotDeleted();
		if ($original_transaction_date) {
			$transaction->where("transaction_date < '" . $original_transaction_date . "'", NULL, FALSE);
		}
		$transaction->where("transaction_date < '" . $new_transaction_date . "'", NULL, FALSE);
		$transaction->limit(1);
		$transaction->row();

		if ($transaction->date) {
			// now get the transactions that need the balance to be reset
			$transactions = new transaction();
			$transactions->whereNotDeleted();
			$transactions->where("transaction_date >= '" . $transaction->date . "'", NULL, FALSE);
			$transactions->orderBy('transaction_date', 'ASC');
			$transactions->orderBy('id', 'ASC');
			$transactions->result();
//echo $transactions->lastQuery()."\n";
//print $transactions;
			if ($transactions->numRows()) {
				$first = TRUE;
				foreach ($transactions as $transaction) {
					if (!$first || empty($transaction->bank_account_balance)) {
						$first = FALSE;
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
//print $transaction;
						$transaction->save();
					} else {
						$bank_account_balances[$transaction->bank_account_id] = $transaction->bank_account_balance;
					}
				}
			}
		}
	}

	/*
	 * sd = we need the first available balance before this date
	 * bank_account_id = bank account id
	 */
	protected function getBankAccountBalance($sd, $bank_account_id) {
		$transaction = new transaction();
		$transaction->whereNotDeleted();
		$transaction->where("transaction_date < '" . $sd . "'", NULL, FALSE);
		$transaction->where('bank_account_id', $bank_account_id);
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
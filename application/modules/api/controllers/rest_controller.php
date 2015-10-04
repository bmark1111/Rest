<?php
/*
 * REST controller
 */

class rest_controller Extends EP_Controller {

	protected $debug = TRUE;

	public function __construct() {
		parent::__construct();
	}

	/*
	 * adjustBankBalances
	 * $amount:	amount to adjust
	 * $date:	date of adjustment
	 * $bank_account_id:	id of bank balance to adjust
	 */
	protected function adjustBankBalances($bank_account_id, $date, $amount, $type, $delete = FALSE) {
		// now update the bank_account balances
		$bank_account_balances = new bank_account_balance();
		$bank_account_balances->whereNotDeleted();
		$bank_account_balances->where('date >= ', $date);
		$bank_account_balances->where('bank_account_id', $bank_account_id);
		$bank_account_balances->orderBy('date', 'ASC');
		$bank_account_balances->result();
		if ($bank_account_balances->numRows()) {
			// found balances so update them
			$foundThisDate = FALSE;		// flags if we have found a balance record for the exact date
			$bank_account_balance = FALSE;
			foreach ($bank_account_balances as $balance) {
				if ($balance->date == $date) {
					$foundThisDate = TRUE;	// we found a balance record for this date exactly and updated it
				} elseif ($balance->date > $date && !$foundThisDate && $bank_account_balance === FALSE) {
					$bank_account_balance = new bank_account_balance();
					$bank_account_balance->bank_account_id	= $bank_account_id;
					$bank_account_balance->date				= $date;
					$bank_account_balance->balance			= $balance->balance;
print $bank_account_balance;echo "\n------------------------\n";
//					$bank_account_balance->save();
				}
//				if ($delete === FALSE || $balance->date != $date) {
					// calculate the new balance
					switch($type) {
						case 'DEBIT':
						case 'CHECK':
							$balance->balance -= $amount;
							break;
						case 'CREDIT':
						case 'DSLIP':
							$balance->balance += $amount;
							break;
					}
print $balance;echo "\n++++++++++++++++++++++++\n";
//					$balance->save();
//				}
			}
die('111111');
		} else {
die('222222');
			// no balance found for date so find closest
			$bank_account_balance = new bank_account_balance();
			$bank_account_balance->whereNotDeleted();
			$bank_account_balance->select('bank_account_balance.*,MAX(date)');
			$bank_account_balance->where('bank_account_id', $bank_account_id);
			$bank_account_balance->row();
			if ($bank_account_balance->numRows()) {
				// found a close balance so create new record for this date
				unset($bank_account_balance->id);	// this will ensure a new row is created
				$bank_account_balance->date = $date;
				switch($type) {
					case 'DEBIT':
					case 'CHECK':
						$bank_account_balance->balance -= $amount;
						break;
					case 'CREDIT':
					case 'DSLIP':
						$bank_account_balance->balance += $amount;
						break;
				}
				$bank_account_balance->save();
			} else {
				// no balance record found so create a new record
				// get the opening account balance and create a new account balance amount
				$bank_account = new bank_account($bank_account_id);
				$amount = $bank_account->amount;
				switch($type) {
					case 'DEBIT':
					case 'CHECK':
						$balance -= $amount;
						break;
					case 'CREDIT':
					case 'DSLIP':
						$balance += $amount;
						break;
				}

				$bank_account_balance = new bank_account_balance();
				$bank_account_balance->bank_account_id	= $bank_account_id;
				$bank_account_balance->date				= $date;
				$bank_account_balance->balance			= $balance;
				$bank_account_balance->save();
			}
		}
	}

}

// EOF
<?php
/*
 * REST Dashboard controller
 */

require_once ('rest_controller.php');

class dashboard_controller Extends rest_controller
{
	protected $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/index)"));
		$this->ajax->output();
	}

	public function ytdTotals()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/ytdTotals)"));
			$this->ajax->output();
		}

		$categories = new category();
		$categories->whereNotDeleted();
		$categories->orderBy('order');
		$categories->result();

		$select = array();
//		$select[] = "T.transaction_date";
		foreach ($categories as $category)
		{
			$select[] = "SUM(CASE WHEN T.category_id = " . $category->id . " AND T.type = 'CREDIT' THEN T.amount ELSE 0 END)" .
						" + SUM(CASE WHEN T.category_id = " . $category->id . " AND T.type = 'DSLIP' THEN T.amount ELSE 0 END)" .
						" - SUM(CASE WHEN T.category_id = " . $category->id . " AND T.type = 'CHECK' THEN T.amount ELSE 0 END)" .
						" - SUM(CASE WHEN T.category_id = " . $category->id . " AND T.type = 'DEBIT' THEN T.amount ELSE 0 END) " .
						" + SUM(CASE WHEN TS.category_id = " . $category->id . " AND TS.type = 'CREDIT' THEN TS.amount ELSE 0 END)" .
						" + SUM(CASE WHEN TS.category_id = " . $category->id . " AND TS.type = 'DSLIP' THEN TS.amount ELSE 0 END)" .
						" - SUM(CASE WHEN TS.category_id = " . $category->id . " AND TS.type = 'CHECK' THEN TS.amount ELSE 0 END)" .
						" - SUM(CASE WHEN TS.category_id = " . $category->id . " AND TS.type = 'DEBIT' THEN TS.amount ELSE 0 END) " .
						"AS total_" . $category->id;
		}

		$sql = array();
		$sql[] = "SELECT";
		$sql[] = implode(',', $select);
		$sql[] = "FROM transaction T";
		$sql[] = "LEFT JOIN transaction_split TS ON TS.transaction_id = T.id AND TS.is_deleted = 0";
		$sql[] = "WHERE YEAR(transaction_date) = '" . date('Y') . "' AND T.is_deleted = 0";

		$transactions = new transaction();
		$transactions->query(implode(' ', $sql));

		$this->ajax->setData('result', $transactions);
		$this->ajax->setData('year', date('Y'));

		$this->ajax->output();
	}

	public function these()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("Error: 403 Forbidden - (dashboard/these)"));
			$this->ajax->output();
		}

		$year	= $this->input->get('year');
		if (!$year || !is_numeric($year))
		{
			$this->ajax->addError(new AjaxError("Error: Invalid year - (dashboard/these)"));
			$this->ajax->output();
		}

		$category_id	= $this->input->get('category_id');
		if ($category_id == 0 || !is_numeric($category_id))
		{
			$this->ajax->addError(new AjaxError("Error: Invalid category id - (dashboard/these)"));
			$this->ajax->output();
		}

		$transactions = new transaction();
		$sql = "(SELECT T.transaction_date, T.type, T.description, T.notes, T.amount
				FROM transaction T
				WHERE T.is_deleted = 0
					AND T.category_id = " . $category_id . " AND T.category_id IS NOT NULL
					AND YEAR(T.`transaction_date`) = " . $year . ")
			UNION
				(SELECT T.transaction_date, T.type, T.description, TS.notes, TS.amount
				FROM transaction T
				LEFT JOIN transaction_split TS ON T.id = TS.transaction_id
				WHERE T.is_deleted = 0
					AND TS.category_id = " . $category_id . " AND T.category_id IS NULL
					AND YEAR(T.`transaction_date`) = " . $year . ")
			ORDER BY transaction_date DESC";
		$transactions->queryAll($sql);
		if ($transactions->numRows())
		{
			foreach ($transactions as $transaction)
			{
				$transaction->amount = ($transaction->type == 'CHECK' || $transaction->type == 'DEBIT') ? -$transaction->amount: $transaction->amount;
			}
			$this->ajax->setData('result', $transactions);
		} else {
			$this->ajax->addError(new AjaxError("Error: No transactions found - (dashboard/these)"));
		}
		$this->ajax->output();
	}

/*
	// TODO: include forecast in the balance forward if necessary
	private function _getBalanceForward($sd)
	{
		// now calculate the balance brought forward
		$balance = new transaction();
		$balance->join('transaction_split', 'transaction_split.transaction_id = transaction.id AND transaction_split.is_deleted = 0', 'LEFT');
		$balance->select("SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id IS NOT NULL THEN transaction.amount ELSE 0 END) " .
							" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id IS NOT NULL THEN transaction.amount ELSE 0 END) " .
							" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id IS NOT NULL THEN transaction.amount ELSE 0 END) " .
							" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id IS NOT NULL THEN transaction.amount ELSE 0 END) " .
							" + SUM(CASE WHEN transaction_split.type = 'CREDIT' AND transaction.category_id IS NULL THEN transaction_split.amount ELSE 0 END) " .
							" + SUM(CASE WHEN transaction_split.type = 'DSLIP' AND transaction.category_id IS NULL THEN transaction_split.amount ELSE 0 END) " .
							" - SUM(CASE WHEN transaction_split.type = 'DEBIT' AND transaction.category_id IS NULL THEN transaction_split.amount ELSE 0 END) " .
							" - SUM(CASE WHEN transaction_split.type = 'CHECK' AND transaction.category_id IS NULL THEN transaction_split.amount ELSE 0 END) " .
							" AS balance_forward");
		$balance->where('transaction.is_deleted', 0);
		$balance->where("transaction.transaction_date < '" . $sd . "'");
		$balance->row();

		// get the starting bank balances
		$accounts = new bank_account();
		$accounts->select('SUM(balance) as balance');
		$accounts->whereNotDeleted();
		$accounts->row();

		return $balance->balance_forward + $accounts->balance;
	}

	private function _getNextDate($myDateTimeISO, $addThese, $unit)
	{
		$myDateTime = new DateTime($myDateTimeISO);
		$myDayOfMonth = date_format($myDateTime, 'j');
		date_modify($myDateTime, "+" . $addThese . " " . $unit);

		//Find out if the day-of-month has dropped
		$myNewDayOfMonth = date_format($myDateTime, 'j');
		if ($myDayOfMonth > 28 && $myNewDayOfMonth < 4)
		{
			//If so, fix by going back the number of days that have spilled over
			date_modify($myDateTime, "-" . $myNewDayOfMonth . " " . $unit);
		}
		return date_format($myDateTime, "Y-m-d");
	}

	public function these()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/these)"));
			$this->ajax->output();
		}

		$interval_beginning	= $this->input->get('interval_beginning');
		if (!$interval_beginning || !strtotime($interval_beginning))
		{
			$this->ajax->addError(new AjaxError("Invalid interval_beginning - dashboard/these"));
			$this->ajax->output();
		}
		$interval_beginning = explode('T', $interval_beginning);
		$sd = date('Y-m-d', strtotime($interval_beginning[0]));

		$interval_ending	= $this->input->get('interval_ending');
		if (!$interval_ending || !strtotime($interval_ending))
		{
			$this->ajax->addError(new AjaxError("Invalid interval ending - dashboard/these"));
			$this->ajax->output();
		}
		$interval_ending = explode('T', $interval_ending);
		$ed = date('Y-m-d', strtotime($interval_ending[0]));

		$category_id	= $this->input->get('category_id');
		if ($category_id == 0 || !is_numeric($category_id))
		{
			$this->ajax->addError(new AjaxError("Invalid category id - dashboard/these"));
			$this->ajax->output();
		}

		$transactions = new transaction();
		$sql = "(SELECT T.transaction_date, T.type, T.description, T.notes, T.amount
				FROM transaction T
				LEFT JOIN category C1 ON C1.id = T.category_id
				WHERE T.is_deleted = 0
						AND T.category_id = " . $category_id . " AND T.category_id IS NOT NULL
						AND T.`transaction_date` >=  '" . $sd . "'
						AND T.`transaction_date` <=  '" . $ed . "')
			UNION
				(SELECT T.transaction_date, T.type, T.description, TS.notes, TS.amount
				FROM transaction T
				LEFT JOIN transaction_split TS ON T.id = TS.transaction_id
				LEFT JOIN category C2 ON C2.id = TS.category_id
				WHERE T.is_deleted = 0
						AND TS.category_id = " . $category_id . " AND T.category_id IS NULL
						AND T.`transaction_date` >=  '" . $sd . "'
						AND T.`transaction_date` <=  '" . $ed . "')
				ORDER BY transaction_date DESC";
		$transactions->queryAll($sql);
		if ($transactions->numRows())
		{
			foreach ($transactions as $transaction)
			{
				$transaction->amount = ($transaction->type == 'CHECK' || $transaction->type == 'DEBIT') ? -$transaction->amount: $transaction->amount;
			}
			$this->ajax->setData('result', $transactions);
		} else {
			$this->ajax->addError(new AjaxError("Error - No transactions found"));
		}
		$this->ajax->output();
	}

	private function _getEndDay()
	{
		$xx =  time();
		$yy = intval(strtotime($this->budget_start_date));
		$xx = ($xx - $yy) / (24 * 60 * 60);
		$xx = ceil($xx / $this->budget_interval);
		return ($xx * $this->budget_interval);
	}

	public function _loadForecast($categories, $sd, $ed)
	{
		$output = array();

		$forecast = new forecast();
		$forecast->whereNotDeleted();
		$forecast->result();
		if ($forecast->numRows())
		{
			// set the next due date(s) for the forecasted expenses
			foreach ($forecast as $fc)
			{
				$next_due_dates = array();

				// initialize the offset
				$offset = 0;
				switch ($fc->every_unit)
				{
					case 'Days':
						$diff = $this->_datediffInWeeks($fc->first_due_date, $sd);
						$diff = intval(round($diff / $fc->every) * $fc->every);
						$fdd = date('Y-m-d', strtotime($fc->first_due_date . " +" . $diff . " " . $fc->every_unit));		// set first due date
						while (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) < strtotime($ed) && (!$fc->last_due_date || strtotime($fdd . " +" . $offset . " Days") <= strtotime($fc->last_due_date)))
						{
							if (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) >= strtotime($fc->first_due_date))
							{
								$next_due_dates[] = date('Y-m-d', strtotime($fdd . " +" . $offset . " " . $fc->every_unit));
							}
							$offset += $fc->every;
						}
						$fc->next_due_dates = $next_due_dates;
						break;
					case 'Weeks':
//if ($fc->id == 30)
//{
//	echo "sd = $sd\n";
//}
						$diff = $this->_datediffInWeeks($fc->first_due_date, $sd);
//if ($fc->id == 30)
//{
//	echo "diff = $diff\n";
//}
						$diff = intval(round($diff / $fc->every) * $fc->every);
//if ($fc->id == 30)
//{
//	echo "diff = $diff\n";
//}
						// TODO: need to fix this - calculate from sd if diff is calculated from sd - doesn't work in some circumstances ???????????????????/
						$fdd = date('Y-m-d', strtotime($fc->first_due_date . " +" . $diff . " " . $fc->every_unit));		// set first due date
//						$fdd = date('Y-m-d', strtotime($sd . " +" . $diff . " " . $fc->every_unit));		// set first due date
//if ($fc->id == 30)
//{
//	print $fc;
//	die($fdd);
//}
						while (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) < strtotime($ed) && (!$fc->last_due_date || strtotime($fdd . " +" . $offset . " " . $fc->every_unit) <= strtotime($fc->last_due_date)))
						{
							if (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) >= strtotime($fc->first_due_date))
							{
								$next_due_dates[] = date('Y-m-d', strtotime($fdd . " +" . $offset . " " . $fc->every_unit));
							}
							$offset += $fc->every;
						}
						$fc->next_due_dates = $next_due_dates;
						break;
					case 'Months':
						$dt = explode('-', $sd);
						$fdd = $dt[0] . '-' . $dt[1] . '-' . $fc->every_on;
						while (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) < strtotime($ed) && (!$fc->last_due_date || strtotime($fdd . " +" . $offset . " " . $fc->every_unit) <= strtotime($fc->last_due_date)))
						{
							if (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) >= strtotime($fc->first_due_date))
							{
								$next_due_dates[] = date('Y-m-d', strtotime($fdd . " +" . $offset . " " . $fc->every_unit));
							}
							$offset += $fc->every;
						}
						$fc->next_due_dates = $next_due_dates;
						break;
					case 'Years':
						$dt = explode('-', $sd);
						$fdd = $dt[0] . '-' . $fc->every_on;
						while (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) < strtotime($ed) && (!$fc->last_due_date || strtotime($fdd . " +" . $offset . " " . $fc->every_unit) <= strtotime($fc->last_due_date)))
						{
							if (strtotime($fdd . " +" . $offset . " " . $fc->every_unit) >= strtotime($fc->first_due_date))
							{
								$next_due_dates[] = date('Y-m-d', strtotime($fdd . " +" . $offset . " " . $fc->every_unit));
							}
							$offset += $fc->every;
						}
						$fc->next_due_dates = $next_due_dates;
						break;
				}
			}
//print $forecast;die;
			// now sum the expenses for the forecast intervals
			$xx = 0;
			$offset = 0;
			while (strtotime($sd . ' +' . $offset . ' ' . $this->budget_interval_unit) < strtotime($ed))
			{
				$interval_beginning = date('Y-m-d', strtotime($sd . ' +' . $offset . ' ' . $this->budget_interval_unit));
				$interval_ending = date('Y-m-d', strtotime($sd . ' +' . ($offset + $this->budget_interval - 1) . ' ' . $this->budget_interval_unit));

				$output[$xx]['totals'] = $this->_getForecastByCategory($categories, $forecast, $interval_beginning);
				$output[$xx]['interval_beginning'] = date('c', strtotime($interval_beginning));
				$output[$xx]['interval_ending']	= date('c', strtotime($interval_ending . ' 23:59:59'));
				$xx++;
				$offset += $this->budget_interval;
			}
		}
		return $output;
	}

	private function _datediffInWeeks($date1, $date2)
	{
		if($date1 > $date2)
		{
			return $this->_datediffInWeeks($date2, $date1);
		}
		$first = new DateTime($date1);
		$second = new DateTime($date2);
		return floor($first->diff($second)->days/7);
	}

	private function _getForecastByCategory($categories, $forecast, $start_date)
	{
		$sd = strtotime($start_date);																		// start date of forecast interval
		$ed = strtotime($start_date . " +" . $this->budget_interval . " " . $this->budget_interval_unit);	// end date of forecast interval
		$data = array();
		foreach ($categories as $x => $category)
		{
			$data[$category->id] = 0;
			foreach ($forecast as $fc)
			{
				if ($fc->category_id == $category->id)
				{
					if (!empty($fc->next_due_dates))
					{
						foreach ($fc->next_due_dates as $next_due_date)
						{
							$fd = strtotime($next_due_date);
							if ($fd >= $sd && $fd < $ed)// && $ed >= time())						// while next due date still inside forecast interval
							{
								switch ($fc->type)
								{
									case 'DSLIP':
									case 'CREDIT':
										$data[$category->id] += $fc->amount;
										break;
									case 'DEBIT':
									case 'CHECK':
										$data[$category->id] -= $fc->amount;
										break;
								}
							}
						}
					}
				}
			}
		}
		return $data;
	}
*/
}

// EOF
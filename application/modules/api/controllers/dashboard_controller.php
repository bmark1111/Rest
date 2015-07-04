<?php
/*
 * REST Dashboard controller
 */

require_once ('rest_controller.php');

class dashboard_controller Extends rest_controller
{
	protected $debug = TRUE;
	private $budget_mode = FALSE;
	private $budget_start_date = FALSE;
	private $budget_interval = FALSE;
	private $budget_interval_unit = FALSE;
	private $budget_views = 6;

	public function __construct()
	{
		parent::__construct();

		$config = new configuration();
		$config->getBy('name', 'budget_mode');
		$this->budget_mode  = $config->value;
		switch ($this->budget_mode)
		{
			case 'weekly':
				$this->budget_interval = 7;
				$this->budget_interval_unit = 'Days';
				break;
			case 'bi-weekly':
				$this->budget_interval = 14;
				$this->budget_interval_unit = 'Days';
				break;
			case 'semi-monthy':
				$this->budget_interval = 1;
				$this->budget_interval_unit = 'Months';
				break;
			case 'monthly':
				$this->budget_interval = 1;
				$this->budget_interval_unit = 'Months';
				break;
			default:
//				throw new Exception("Invalid budget_mode setting");
				$this->ajax->addError(new AjaxError("Invalid budget_mode setting (dashboard controller)"));
				$this->ajax->output();
		}

		$config->getBy('name', 'budget_start_date');
		$this->budget_start_date  = $config->value;
		$this->budget_views = 6;						// TODO: this should be passed in to accomodate more budget intervals
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/index)"));
		$this->ajax->output();
	}

	public function load()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/load)"));
			$this->ajax->output();
		}

		$categories = new category();
		$categories->whereNotDeleted();
		$categories->orderBy('order');
		$categories->result();
		if ($categories->numRows())
		{
			$interval = $this->input->get('interval');
			if (!is_numeric($interval))
			{
				$this->ajax->addError(new AjaxError("Invalid interval - dashboard/load"));
				$this->ajax->output();
			}

			$select = array();
			$select[] = "T.transaction_date";
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

			switch ($this->budget_mode)
			{
				case 'weekly':
					$offset = $this->_getEndDay();
					$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// - 'budget_views' entries and adjust for interval
					$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));		// + 'budget_views' entries and adjust for interval
					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY DAYOFYEAR(T.transaction_date)";
					$sql[] = "ORDER BY DAYOFYEAR(T.transaction_date) ASC";
					break;
				case 'bi-weekly':
					$offset = $this->_getEndDay();
					$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// - 'budget_views' entries and adjust for interval
					$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));		// + 'budget_views' entries and adjust for interval
					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY DAYOFYEAR(T.transaction_date)";
					$sql[] = "ORDER BY DAYOFYEAR(T.transaction_date) ASC";
					break;
				case 'semi-monthy':
					// TODO: divide the month:-
					//		1st through the 15th and 16th through the end of month

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY DAYOFYEAR(T.transaction_date)";
					$sql[] = "ORDER BY DAYOFYEAR(T.transaction_date) ASC";
					break;
				case 'monthly':
					$offset = date('n');			// get the current month
					$start_month = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));	// go back 'budget views' and adjust for interval
					$end_month = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));		// go forward 'budget views' and adjust for interval
					$start = new DateTime($this->budget_start_date);
					$start->add(new DateInterval("P" . $start_month . "M"));
					$end = new DateTime($this->budget_start_date);
					$end->add(new DateInterval("P" . $end_month . "M"));

					$sd = $start->format('Y-m-d');
					$ed = $end->format('Y-m-d');
//					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_month . " Months"));
//					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_month . " Months"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY MONTH(T.transaction_date)";
					$sql[] = "ORDER BY MONTH(T.transaction_date) ASC";
					break;
				default:
					$this->ajax->addError(new AjaxError("Invalid budget_mode setting (dashboard/load)"));
					$this->ajax->output();
			}

			$transactions = new transaction();
			$transactions->queryAll(implode(' ', $sql));

			$forecast = $this->_loadForecast($categories, $sd, $ed);
			// TODO: include forecast in the balance forward if necessary

			// now calculate the balance brought forward
			$balance = new transaction();
			$balance->join('transaction_split', 'transaction_split.transaction_id = transaction.id AND transaction_split.is_deleted = 0', 'LEFT');
			$balance->select("SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
								" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
								" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
								" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
								" + SUM(CASE WHEN transaction_split.type = 'CREDIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
								" + SUM(CASE WHEN transaction_split.type = 'DSLIP' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
								" - SUM(CASE WHEN transaction_split.type = 'DEBIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
								" - SUM(CASE WHEN transaction_split.type = 'CHECK' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
								" AS balance_forward");
			$balance->where('transaction.is_deleted', 0);
			$balance->where("transaction.transaction_date < '" . $sd . "'");
			$balance->row();

			// get the starting bank balances
			$accounts = new bank_account();
			$accounts->select('SUM(balance) as balance');
			$accounts->whereNotDeleted();
			$accounts->row();

			$running_total = $balance->balance_forward + $accounts->balance;

			$data = array();
			$data['balance_forward'] = $running_total;
			$data['interval_total'] = 0;
			$data['running_total'] = $running_total;

			$output = array();
			$date_offset = 0;

			// create interval totals with no values
			$noTotals = array();
			foreach ($transactions[0] as $label => $value)
			{
				if (substr($label, 0, 6) == 'total_')
				{
					$index = explode('_', $label);
					$noTotals[$index[1]] = "0.00";
				}
			}

			$isd = $sd;																					// set the first interval start date
			$ied = $this->_getNextDate($isd, $this->budget_interval, $this->budget_interval_unit);
			$ied = $this->_getNextDate($ied, -1, 'days');												// set the first interval end date
			// now sort transactions into intervals
			foreach ($transactions as $transaction)
			{
				while (strtotime($transaction->transaction_date) > strtotime($ied))
				{
					$data['interval_beginning']	= date('c', strtotime($isd));
					$data['interval_ending']	= date('c', strtotime($ied . " 23:59:59"));
					if (empty($data['totals']))
					{	// no totals for this interval
						$data['totals'] = $noTotals;
					}
					$data['running_total'] = $running_total;
					$output[] = $data;

					$data = array();
					$data['interval_total'] = 0;
					$data['running_total'] = $running_total;

					$isd = $this->_getNextDate($isd, $this->budget_interval, $this->budget_interval_unit);		// set the interval start date
					$ied = $this->_getNextDate($isd, $this->budget_interval, $this->budget_interval_unit);
					$ied = $this->_getNextDate($ied, -1, 'days');
				}

				foreach ($transaction as $label => $value)
				{
					if (substr($label, 0, 6) == 'total_')
					{
						$index = explode('_', $label);
						if (!empty($data['totals'][$index[1]]))
						{
							$data['totals'][$index[1]] += $value;
						} else {
							$data['totals'][$index[1]] = $value;
						}
						$data['interval_total'] += $value;
						$running_total += $value;
					}
				}
			}

			$data['running_total'] = $running_total;
			$data['interval_beginning']	= date('c', strtotime($isd));
			$data['interval_ending']	= date('c', strtotime($ied . " 23:59:59"));
			$output[] = $data;

			while (count($output) < ($this->budget_views * 2))		// show 12 intervals
			{
				foreach ($data['totals'] as &$total)
				{
					$total = 0;
				}

				$isd = $this->_getNextDate($isd, $this->budget_interval, $this->budget_interval_unit);		// set the interval start date
				$ied = $this->_getNextDate($isd, $this->budget_interval, $this->budget_interval_unit);
				$ied = $this->_getNextDate($ied, -1, 'days');												// set the interval end date
				$data['interval_beginning']	= date('c', strtotime($isd));
				$data['interval_ending']	= date('c', strtotime($ied . " 23:59:59"));
				$data['interval_total']		= 0;
				if (empty($data['running_total']) || $data['running_total'] == 0)
				{
					$data['running_total']	= $running_total;
				}
				$output[] = $data;
			}

			$running_total = 0;
			// now add the forecast in
			foreach ($output as $x => &$period)
			{
				$sd = strtotime($period['interval_beginning']);
				$ed = strtotime($period['interval_ending']);
				$now = time();
				if (($now >= $sd && $now <= $ed) || $now < $ed)
				{
					// check to see what current values need to be from the forecast
					foreach ($period['totals'] as $y => $intervalAmount)
					{
						if ($intervalAmount == 0 && $forecast[$x]['totals'][$y] != 0)
						{	// if interval amount is zero and the forecast has a value then ... use the forecasted amount
							$period['totals'][$y] = floatval($forecast[$x]['totals'][$y]);				// use the forcasted amount
							$period['types'][$y] = '1';													// flag this as a forecast total
							$period['interval_total'] += floatval($forecast[$x]['totals'][$y]);			// update the interval total
							$running_total += floatval($forecast[$x]['totals'][$y]);					// update the running total
						}
					}
					$period['running_total'] += $running_total;
				}
			}

			$this->ajax->setData('result', $output);
		} else {
			$this->ajax->addError(new AjaxError("No categories found"));
		}

		$this->ajax->output();
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
						$diff = $this->_datediffInWeeks($fc->first_due_date, $sd);
						$diff = intval(round($diff / $fc->every) * $fc->every);
						$fdd = date('Y-m-d', strtotime($fc->first_due_date . " +" . $diff . " " . $fc->every_unit));		// set first due date
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

}

// EOF
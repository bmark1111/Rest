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
							" + SUM(CASE WHEN TS.category_id = " . $category->id . " AND T.type = 'CREDIT' THEN TS.amount ELSE 0 END)" .
							" + SUM(CASE WHEN TS.category_id = " . $category->id . " AND T.type = 'DSLIP' THEN TS.amount ELSE 0 END)" .
							" - SUM(CASE WHEN TS.category_id = " . $category->id . " AND T.type = 'CHECK' THEN TS.amount ELSE 0 END)" .
							" - SUM(CASE WHEN TS.category_id = " . $category->id . " AND T.type = 'DEBIT' THEN TS.amount ELSE 0 END) " .
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
					$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// -6 entries
					$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));		// +6 entries
					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY DAYOFYEAR(T.transaction_date)";
					$sql[] = "ORDER BY DAYOFYEAR(T.transaction_date) ASC";
					break;
				case 'bi-weekly':
					$offset = $this->_getEndDay();
					$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// -6 entries
					$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));		// +6 entries
					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY DAYOFYEAR(T.transaction_date)";
					$sql[] = "ORDER BY DAYOFYEAR(T.transaction_date) ASC";
					break;
				case 'semi-monthy':
					// TODO:
					break;
				case 'monthly':
					$offset = date('n');
					$start_month = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));
					$end_month = ($offset + ($this->budget_interval * ($this->budget_views + $interval)));
					$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_month . " Months"));
					$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_month . " Months"));

					$sql[] = "WHERE T.transaction_date >= '" . $sd . "' AND T.transaction_date < '" . $ed . "' AND T.is_deleted = 0";
					$sql[] = "GROUP BY MONTH(T.transaction_date)";
					$sql[] = "ORDER BY MONTH(T.transaction_date) ASC";
					break;
				default:
//				throw new Exception("Invalid budget_mode setting");
				$this->ajax->addError(new AjaxError("Invalid budget_mode setting (dashboard/load)"));
				$this->ajax->output();
			}
//die(implode(' ', $sql));
			$transactions = new transaction();
			$transactions->queryAll(implode(' ', $sql));
			if ($transactions->numRows())
			{
				// now calculate the balance brought forward
				$balance = new transaction();
				$balance->join('transaction_split', 'transaction_split.transaction_id = transaction.id AND transaction_split.is_deleted = 0', 'LEFT');
				$balance->select("SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" AS balance_forward");
				$balance->where('transaction.is_deleted', 0);
				$balance->where("transaction.transaction_date < '" . $sd . "'");
				$balance->row();
//echo $balance->lastQuery();die;
//print $balance;
//die;
				// get the starting bank balances
				$accounts = new bank_account();
				$accounts->select('SUM(balance) as balance');
				$accounts->whereNotDeleted();
				$accounts->row();

				$running_total = $balance->balance_forward + $accounts->balance;

				$data = array();
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
				foreach ($transactions as $transaction)
				{
					while (strtotime($transaction->transaction_date) >= strtotime($sd . " +". ($date_offset + $this->budget_interval) . " " . $this->budget_interval_unit))
					{
						if ($date_offset == 0)
						{
							$data['balance_forward'] = $running_total;
						}
						$data['interval_beginning']	= date('c', strtotime($sd . " +" . $date_offset . " " . $this->budget_interval_unit));
						$data['interval_ending']	= date('c', strtotime($sd . " 23:59:59 +" . ($date_offset + $this->budget_interval - 1) . " " . $this->budget_interval_unit));
						if (empty($data['totals']))
						{	// no totals for this interval
							$data['totals'] = $noTotals;
						}
						$output[] = $data;
						$data = array();
						$date_offset += $this->budget_interval;
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
						}
					}
				}

				if ($date_offset == 0)
				{
					$data['balance_forward'] = $running_total;
				}
				$data['interval_beginning']	= date('c', strtotime($sd . " +". $date_offset . " " . $this->budget_interval_unit));
				$data['interval_ending']	= date('c', strtotime($sd . " 23:59:59 +" . ($date_offset + $this->budget_interval - 1) . " " . $this->budget_interval_unit));
				$output[] = $data;

				while (count($output) < ($this->budget_views * 2))		// show 12 intervals
				{
					foreach ($data['totals'] as &$total)
					{
						$total = 0;
					}
					$date_offset += $this->budget_interval;
					$data['interval_beginning']	= date('c', strtotime($sd . " +". $date_offset . " " . $this->budget_interval_unit));
					$data['interval_ending']	= date('c', strtotime($sd . " 23:59:59 +" . ($date_offset + $this->budget_interval - 1) . " " . $this->budget_interval_unit));
					$output[] = $data;
				}
				$this->ajax->setData('result', $output);
			} else {
				$this->ajax->addError(new AjaxError("No transactions found"));
			}
		} else {
			$this->ajax->addError(new AjaxError("No categories found"));
		}

		$this->ajax->output();
	}

	public function these()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/these)"));
			$this->ajax->output();
		}

		$interval_ending	= $this->input->get('interval_ending');
		if (!$interval_ending || !strtotime($interval_ending))
		{
			$this->ajax->addError(new AjaxError("Invalid week ending - dashboard/these"));
			$this->ajax->output();
		}
		$interval_ending = explode('T', $interval_ending);
		$ed = date('Y-m-d', strtotime($interval_ending[0]));
		$sd = date('Y-m-d', strtotime($ed . ' -' . ($this->budget_interval - 1) . ' ' . $this->budget_interval_unit));

		$category_id	= $this->input->get('category_id');
		if ($category_id == 0 || !is_numeric($category_id))
		{
			$this->ajax->addError(new AjaxError("Invalid category id - dashboard/these"));
			$this->ajax->output();
		}

		$transactions = new transaction();
		$transactions->select('transaction.transaction_date, transaction.type, transaction.description, transaction.notes, COALESCE(transaction.amount, transaction_split.amount) AS amount', FALSE);
		$transactions->join('transaction_split', 'transaction_split.transaction_id = transaction.id AND transaction_split.is_deleted = 0 AND transaction_split.category_id = ' . $category_id, 'LEFT');
		$transactions->join('category C1', 'C1.id = transaction.category_id', 'LEFT');
		$transactions->join('category C2', 'C2.id = transaction_split.category_id', 'LEFT');
		$transactions->where('transaction.is_deleted', 0);
		$transactions->groupStart();
		$transactions->orWhere('transaction.category_id', $category_id);
		$transactions->orWhere('transaction_split.category_id', $category_id);
		$transactions->groupEnd();
		$transactions->where('transaction.transaction_date >= ', $sd);
		$transactions->where('transaction.transaction_date <= ', $ed);
		$transactions->orderBy('transaction.transaction_date', 'DESC');
		$transactions->result();
		
		if ($transactions->numRows())
		{
			$this->ajax->setData('result', $transactions);
		} else {
			$this->ajax->addError(new AjaxError("Error - No transactions found"));
		}
		$this->ajax->output();
	}

	private function _getEndDay()
	{
		$ed = date('z');
		$xx =  time();
		$yy = intval(strtotime($this->budget_start_date));
		$xx = ($xx - $yy) / (24 * 60 * 60);
		$xx = ceil($xx / $this->budget_interval);
		return ($xx * $this->budget_interval);
	}

	public function load2()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (dashboard/load2)"));
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
				$this->ajax->addError("Invalid interval - dashboard/load2");
				$this->ajax->output();
			}

			$forecast = new forecast();
			$forecast->whereNotDeleted();
			$forecast->result();
			if ($forecast->numRows())
			{
				// set the forecast start and end
				switch ($this->budget_mode)
				{
					case 'weekly':
						$offset = $this->_getOffsetDay();
						$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// -6 entries
						$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)) - 1);	// +6 entries
						$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
						$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));
						break;
					case 'bi-weekly':
						$offset = $this->_getOffsetDay();
						$start_day = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));		// -6 entries
						$end_day = ($offset + ($this->budget_interval * ($this->budget_views + $interval)) - 1);	// +6 entries
						$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_day . " Days"));
						$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_day . " Days"));
						break;
					case 'semi-monthy':
						break;
					case 'monthly':
						$offset = date('n');
						$start_month = ($offset - ($this->budget_interval * ($this->budget_views - $interval)));
						$end_month = ($offset + ($this->budget_interval * ($this->budget_views + $interval)) - 1);
						$sd = date('Y-m-d', strtotime($this->budget_start_date . " +" . $start_month . " Months"));
						$ed = date('Y-m-d', strtotime($this->budget_start_date . " +" . $end_month . " Months"));
						break;
					default:
//						throw new Exception("Invalid budget_mode setting");
						$this->ajax->addError(new AjaxError("Invalid budget_mode setting (dashboard/load2)"));
						$this->ajax->output();
				}

				// now calculate the balance brought forward
				$balance = new transaction();
				$balance->join('transaction_split', 'transaction_split.transaction_id = transaction.id AND transaction_split.is_deleted = 0', 'LEFT');
				$balance->select("SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id != 0 THEN transaction.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'CREDIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" + SUM(CASE WHEN transaction.type = 'DSLIP' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'DEBIT' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
									" - SUM(CASE WHEN transaction.type = 'CHECK' AND transaction.category_id = 0 THEN transaction_split.amount ELSE 0 END) " .
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
				$this->ajax->setData('balance_forward', $running_total);

				// set the next due date(s) for the forecasted expenses
				foreach ($forecast as $fc)
				{
					$next_due_dates = array();

					// initialize the offset
					$offset = 0;
					switch ($fc->every_unit)
					{
						case 'Days':
							while (strtotime($sd . " +" . $offset . " Days") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Days") <= strtotime($fc->last_due_date)))
							{
								if (strtotime($sd . " +" . $offset . " Days") >= strtotime($fc->first_due_date))// && strtotime($sd . " +" . $offset . " Days") > time())
								{
									$next_due_dates[] = date('Y-m-d', strtotime($sd . " +" . $offset . " Days"));
								}
								$offset += $fc->every;
							}
							$fc->next_due_dates = $next_due_dates;
							break;
						case 'Weeks':
							while (strtotime($sd . " +" . $offset . " Weeks") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Weeks") <= strtotime($fc->last_due_date)))
							{
								if (strtotime($sd . " +" . $offset . " Weeks") >= strtotime($fc->first_due_date))// && strtotime($sd . " +" . $offset . " Weeks") > time())
								{
									$next_due_dates[] = date('Y-m-d', strtotime($sd . " +" . $offset . " Weeks"));
								}
								$offset += $fc->every;;
							}
							$fc->next_due_dates = $next_due_dates;
							break;
						case 'Months':
							$dt = explode('-', $sd);
							$date = $dt[0] . '-' . $dt[1] . '-' . $fc->every_on;
							while (strtotime($date . " +" . $offset . " Months") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Months") <= strtotime($fc->last_due_date)))
							{
								if (strtotime($date . " +" . $offset . " Months") >= strtotime($fc->first_due_date))// && strtotime($date . " +" . $offset . " Months") >= time())
								{
									$next_due_dates[] = date('Y-m-d', strtotime($date . " +" . $offset . " Months"));
								}
								$offset += $fc->every;
							}
							$fc->next_due_dates = $next_due_dates;
							break;
						case 'Years':
							$dt = explode('-', $sd);
							$date = $dt[0] . '-' . $fc->every_on;
							while (strtotime($date . " +" . $offset . " Years") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Years") <= strtotime($fc->last_due_date)))
							{
								if (strtotime($date . " +" . $offset . " Years") >= strtotime($fc->first_due_date))// && strtotime($date . " +" . $offset . " Years") >= time())
								{
									$next_due_dates[] = date('Y-m-d', strtotime($date . " +" . $offset . " Years"));
								}
								$offset += $fc->every;
							}
							$fc->next_due_dates = $next_due_dates;
							break;
					}
				}

				// now sum the expenses for the forecast intervals
				$output = array();
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
				$this->ajax->setData('result', $output);
			} else {
				$this->ajax->addError("No Forecast found");
			}
		} else {
			$this->ajax->addError("No categories found");
		}

		$this->ajax->output();

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

	private function _getOffsetDay()
	{
		$sd = date('z', strtotime($this->budget_start_date));
		$xx =  time();
		$yy = intval(strtotime($this->budget_start_date));
		$xx = ($xx - $yy) / (24 * 60 * 60);
		$xx = ceil($xx / $this->budget_interval);
		return ($xx * $this->budget_interval) + 1 - $sd;
	}

}

// EOF
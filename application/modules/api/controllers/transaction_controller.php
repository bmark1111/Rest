<?php
/*
 * REST Transaction controller
 */

require_once ('rest_controller.php');

class transaction_controller Extends rest_controller
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
				throw new Exception("Invalid budget_mode setting");
		}

		$config->getBy('name', 'budget_start_date');
		$this->budget_start_date  = $config->value;
		$this->budget_views = 6;						// TODO: this should be passed in to accomodate more budget intervals
	}

	public function index()
	{
//		$this->ajax->set_header("Forbidden", '403');
		$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/index)"));
		$this->ajax->output();
	}

	public function load()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/load)"));
			$this->ajax->output();
		}

		$categories = new category();
		$categories->whereNotDeleted();
		$categories->orderBy('order');
		$categories->result();
		if ($categories->numRows())
		{
//			$this->ajax->setData('categories', $categories);

			$interval = $this->input->get('interval');
			if (!is_numeric($interval))
			{
				$this->ajax->addError(new AjaxError("Invalid interval - transaction/load"));
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
					throw new Exception("Invalid budget_mode setting");
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
//				$this->ajax->setData('balance_forward', $running_total);

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

	public function loadAll()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/loadAll)"));
			$this->ajax->output();
		}

		$params = $this->input->get();
		$this->_loadAll($params);
	}
	
	private function _loadAll($params)
	{
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
//echo $transactions->lastQuery();
//die;
		$this->ajax->setData('total_rows', $transactions->foundRows());

		if ($transactions->numRows())
		{
			foreach ($transactions as $transaction)
			{
				isset($transaction->category);
//				$total = 0;
//				foreach($transaction->splits as $category)
//				{
//					$total += $category->amount;
//					isset($category->category);
//				}
//				$transaction->total = $total;
			}
			$this->ajax->setData('result', $transactions);
		} else {
			$this->ajax->addError(new AjaxError("No transactions found"));
		}
		$this->ajax->output();
	}

	public function these()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/these)"));
			$this->ajax->output();
		}

		$interval_ending	= $this->input->get('interval_ending');
		if (!$interval_ending || !strtotime($interval_ending))
		{
			$this->ajax->addError(new AjaxError("Invalid week ending - transaction/these"));
			$this->ajax->output();
		}
		$interval_ending = explode('T', $interval_ending);
		$ed = date('Y-m-d', strtotime($interval_ending[0]));
		$sd = date('Y-m-d', strtotime($ed . ' -' . ($this->budget_interval - 1) . ' ' . $this->budget_interval_unit));

		$category_id	= $this->input->get('category_id');
		if ($category_id == 0 || !is_numeric($category_id))
		{
			$this->ajax->addError(new AjaxError("Invalid category id - transaction/these"));
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
//echo $transactions->builtQuery();die;
		$transactions->result();
//echo $transactions->lastQuery();
//die;
		
		if ($transactions->numRows())
		{
			$this->ajax->setData('result', $transactions);
//			$this->ajax->setData('result', $this->load->view('popover', array('transactions' => $transactions), TRUE));
		} else {
			$this->ajax->addError(new AjaxError("Error - No transactions found"));
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
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/save)"));
			$this->ajax->output();
		}

		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		// VALIDATION
		$this->form_validation->set_rules('transaction_date', 'Date', 'required');
		$this->form_validation->set_rules('description', 'Description', 'required|max_length[150]');
		$this->form_validation->set_rules('type', 'Type', 'required|alpha');
		$this->form_validation->set_rules('amount', 'Amount', 'required');

		// validate split data
		if (!empty($_POST['splits']))
		{
			foreach ($_POST['splits'] as $idx => $split)
			{
				if (empty($split['is_deleted']) || $split['is_deleted'] != 1)
				{
					$this->form_validation->set_rules('splits[' . $idx . '][amount]', 'Split Amount', 'required');
					$this->form_validation->set_rules('splits[' . $idx . '][category_id]', 'Split Category', 'required|integer');
				}
			}
		}

		if ($this->form_validation->ajaxRun('') === FALSE)
		{
			$this->ajax->output();
		}

		$transaction = new transaction($_POST['id']);
		$transaction->transaction_date	= date('Y-m-d', strtotime($_POST['transaction_date']));
		$transaction->description		= $_POST['description'];
		$transaction->type				= $_POST['type'];
		$transaction->category_id		= $_POST['category_id'];
		$transaction->check_num			= $_POST['check_num'];
		$transaction->amount			= $_POST['amount'];
		$transaction->notes				= $_POST['notes'];
		$transaction->bank_account_id	= $_POST['bank_account_id'];
		$transaction->save();

		if (!empty($_POST['splits']))
		{
			foreach ($_POST['splits'] as $split)
			{
				$transaction_split = new transaction_split($split['id']);
				if (empty($split['is_deleted']) || $split['is_deleted'] != 1)
				{
					$transaction_split->description		= $split['description'];
					$transaction_split->amount			= $split['amount'];
					$transaction_split->transaction_id	= $transaction->id;
					$transaction_split->category_id		= $split['category_id'];
					$transaction_split->notes			= $split['notes'];
					$transaction_split->save();
				} else {
					$transaction_split->delete();
				}
			}
		}

		$this->ajax->output();
	}

	public function delete()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
//			$this->ajax->set_header("Forbidden", '403');
			$this->ajax->addError(new AjaxError("403 - Forbidden (transaction/delete)"));
			$this->ajax->output();
		}

		$id = $this->input->get('id');
		if (!is_numeric($id) || $id <= 0)
		{
			$this->ajax->addError(new AjaxError("Invalid transaction id - " . $id . " (transaction/delete)"));
			$this->ajax->output();
		}
		
		$transaction = new transaction($id);
		if ($transaction->numRows())
		{
			if (!empty($transaction->splits))
			{
				foreach ($transaction->splits as $split)
				{
					$split->delete();
				}
			}
			$transaction->delete();
		} else {
			$this->ajax->addError(new AjaxError("Invalid transaction - (transaction/delete)"));
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

//	private function _getTransactionDesc($description)
//	{
//		$transaction_category = new transaction_category();
//		$transaction_category->whereNotDeleted();
//		$transaction_category->like('description', $description);
//		$transaction_category->result();
//		if ($transaction_category->numRows())
//		{
//			$data = array();
//
//			foreach ($transaction_category as $category)
//			{
//				$data[] = $category->id;
//			}
//			return $data;
//		} else {
//			return FALSE;
//		}
//	}

//	private function _getTransactionAmount($amount)
//	{
//		$transaction_category = new transaction_category();
//		$transaction_category->whereNotDeleted();
//		$transaction_category->like('amount', $amount);
//		$transaction_category->result();
//		if ($transaction_category->numRows())
//		{
//			$data = array();
//
//			foreach ($transaction_category as $category)
//			{
//				$data[] = $category->id;
//			}
//			return $data;
//		} else {
//			return FALSE;
//		}
//	}

}

// EOF
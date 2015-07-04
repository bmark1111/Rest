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
		$this->form_validation->set_rules('category_id', 'Category', 'is_validCategory');
		$this->form_validation->set_rules('amount', 'Amount', 'required');

		// validate split data
		if (!empty($_POST['splits']))
		{
			foreach ($_POST['splits'] as $idx => $split)
			{
				if (empty($split['is_deleted']) || $split['is_deleted'] != 1)
				{
					$this->form_validation->set_rules('splits[' . $idx . '][amount]', 'Split Amount', 'required');
					$this->form_validation->set_rules('splits[' . $idx . '][type]', 'Split Type', 'required|alpha');
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
		if (empty($_POST['splits']))
		{	// ignore category if splits are present
			$transaction->category_id	= $_POST['category_id'];
		} else {
			$transaction->category_id	= NULL;
		}
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
					$transaction_split->type			= $split['type'];
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

	public function is_validCategory()
	{
		// TODO: if no splits then category is required otherwise MUST be NULL
		return TRUE;
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

/*	private function _getEndDay()
	{
		$ed = date('z');
		$xx =  time();
		$yy = intval(strtotime($this->budget_start_date));
		$xx = ($xx - $yy) / (24 * 60 * 60);
		$xx = ceil($xx / $this->budget_interval);
		return ($xx * $this->budget_interval);
	}
*/
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
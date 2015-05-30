<?php
/*
 * Admin Test Types controller
 */

require_once (APPPATH . 'modules/api/controllers/api_controller.php');

class testtype_controller Extends api_controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/testtype)"));
			$this->ajax->output();
		}

		$params = $this->input->get();

		$testtypeid			= (!empty($params['testtypeid'])) ? $params['testtypeid']: FALSE;
		$externaltesttypeid	= (!empty($params['externaltesttypeid'])) ? $params['externaltesttypeid']: FALSE;
		$testtypename		= (!empty($params['testtypename'])) ? $params['testtypename']: FALSE;
		$testversion		= (!empty($params['testversion'])) ? $params['testversion']: FALSE;
		$pagination_amount	= (!empty($params['pagination_amount'])) ? $params['pagination_amount']: 150;
		$pagination_start	= (!empty($params['pagination_start'])) ? $params['pagination_start']: 0;
		$sort				= (!empty($params['sort'])) ? $params['sort']: 'test_type_id';
		$sort_dir			= (!empty($params['sort_dir']) && $params['sort_dir'] == 'DESC') ? 'DESC': 'ASC';

		$testtypes = new test_type();
		$testtypes->select('SQL_CALC_FOUND_ROWS *', FALSE);
		if ($testtypeid)
		{
			$testtypes->where('tblTestTypes.test_type_id', $testtypeid);
		}
		if ($externaltesttypeid)
		{
			$testtypes->like('tblTestTypes.external_test_type_id', $externaltesttypeid);
		}
		if ($testtypename)
		{
			$testtypes->like('tblTestTypes.test_type_name', $testtypename);
		}
		if ($testversion)
		{
			$testtypes->where('tblTestTypes.test_version', $testversion);
		}
		$testtypes->limit($pagination_amount, $pagination_start);
		$testtypes->orderBy($sort, $sort_dir);
		$testtypes->result();

		$this->ajax->setData('total_rows', $testtypes->foundRows());

		if (!empty($testtypes))
		{
			foreach ($testtypes as $testtype)
			{
				isset($testtype->contact);
			}
			$this->ajax->setData('result', $testtypes);
		} else {
			$this->ajax->addError("No testtypes found");
		}

		$this->ajax->output();
	}

	public function get()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/testtype/get)"));
			$this->ajax->output();
		}
		
		$test_type_id = $this->input->get('test_type_id');
		if (!$test_type_id || !is_numeric($test_type_id))
		{
			$this->ajax->addError(new AjaxError("Invalid testtype id /admin/testtype/get - (" . $test_type_id . ")"));
			$this->ajax->output();
		}

		$testtype = new test_type();
		$testtype->getBy('test_type_id', $test_type_id);
		if ($testtype->numRows())
		{
			isset($testtype->custom);
			$this->ajax->setData('result', $testtype);
		} else {
			$this->ajax->addError(new AjaxError("No testtype found /admin/testtype/get - (" . $test_type_id . ")"));
		}

		$this->ajax->output();
	}

	public function save()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/testtype/save)"));
			$this->ajax->output();
		}

		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		$this->form_validation->set_rules('display_test_name', 'Display Name', 'required|alpha_dash|max_length[25]');
		$this->form_validation->set_rules('external_test_type_id', 'External ID', 'required|alpha_dash||max_length[15]');
		$this->form_validation->set_rules('test_type_name', 'Name', 'required');
		$this->form_validation->set_rules('test_version', 'Version', 'required|numeric');

		// any custom data
		if (!empty($_POST['custom']))
		{
			// validate custom data
			foreach ($_POST['custom'] as $idx => $custom)
			{
				$this->form_validation->set_rules('custom[' . $idx . '][custom_display_name]', 'Custom Name', 'callback_isValidCustomName');
				$this->form_validation->set_rules('custom[' . $idx . '][type]', 'Type', 'callback_isValidType');
			}
		}

		if ($this->form_validation->ajaxRun('') === FALSE)
		{
			$this->ajax->output();
		}

		// process save
		$test_type = new test_type($_POST['test_type_id']);
		$test_type->external_test_type_id	= $_POST['external_test_type_id'];
		$test_type->test_type_name			= $_POST['test_type_name'];
		$test_type->test_version			= $_POST['test_version'];
		$test_type->save();

		$this->ajax->output();
	}

	public function isValidCustomName($name)
	{
		if (empty($name))
		{
			$this->form_validation->set_message('isValidCustomName', "The 'Custom Name' is a required field");
			return FALSE;
		}
		return TRUE;
	}

	public function isValidType($type)
	{
		if (empty($type))
		{
			$this->form_validation->set_message('isValidType', "The 'Type' field is a required field");
			return FALSE;
		}
		return TRUE;
	}

}

// EOF
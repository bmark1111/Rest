<?php
/*
 * Admin Doctor controller
 */

require_once (APPPATH . 'modules/api/controllers/api_controller.php');

class doctor_controller Extends api_controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/doctor)"));
			$this->ajax->output();
		}
/* Array(
    [csrlastname] => 
    [patientid] => 
    [patientlastname] => 
    [ralastname] => 
 */
		$params = $this->input->get();

		$companyname		= (!empty($params['companyname'])) ? $params['companyname']: FALSE;
		$doctorlastname		= (!empty($params['doctorlastname'])) ? $params['doctorlastname']: FALSE;
		$pagination_amount	= (!empty($params['pagination_amount'])) ? $params['pagination_amount']: 150;
		$pagination_start	= (!empty($params['pagination_start'])) ? $params['pagination_start']: 0;
		$sort				= (!empty($params['sort'])) ? $params['sort']: 0;
		$sort_dir			= (!empty($params['sort_dir']) && $params['sort_dir'] == 'DESC') ? 'DESC': 'ASC';

		$doctors = new doctor();
		$doctors->select('SQL_CALC_FOUND_ROWS tblDoctor.*, AC.company_name, tblAccount.sf_account_id', FALSE);
		$doctors->join('tblContact', 'tblContact.contact_id = tblDoctor.contact_id');
		$doctors->join('tblAccountContact', 'tblAccountContact.contact_id = tblDoctor.contact_id', 'inner');
		$doctors->join('tblAccount', 'tblAccount.account_id = tblAccountContact.account_id', 'inner');
		$doctors->join('tblContact AC', 'AC.contact_id = tblAccount.contact_id');
		if ($doctorlastname)
		{
			$doctors->like('tblContact.last_name', $doctorlastname);
		}
		if ($companyname)
		{
			$doctors->like('AC.company_name', $companyname);
		}
		$doctors->limit($pagination_amount, $pagination_start);
		$doctors->orderBy($sort, $sort_dir);
		$doctors->result();

		$this->ajax->setData('total_rows', $doctors->foundRows());
//echo $doctors->lastQuery()."\n\r";
//print $doctors;
//die;
		if (!empty($doctors))
		{
			foreach ($doctors as $doctor)
			{
				isset($doctor->contact);
			}
			$this->ajax->setData('result', $doctors);
		} else {
			$this->ajax->addError("No doctors found");
		}

		$this->ajax->output();
	}

	public function get()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/doctor/get)"));
			$this->ajax->output();
		}
		
		$doctor_id = $this->input->get('doctor_id');
		if (!$doctor_id || !is_numeric($doctor_id))
		{
			$this->ajax->addError(new AjaxError("Invalid doctor id /admin/doctor/get - (" . $doctor_id . ")"));
			$this->ajax->output();
		}

		$doctor = new doctor();
		$doctor->getBy('doctor_id', $doctor_id);
		if ($doctor->numRows())
		{
			isset($doctor->contact);
			$this->ajax->setData('result', $doctor);
		} else {
			$this->ajax->addError(new AjaxError("No doctor found /admin/doctor/get - (" . $doctor_id . ")"));
		}

		$this->ajax->output();
	}

	public function save()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/doctor/save)"));
			$this->ajax->output();
		}

//		$errors = array();
		$input = file_get_contents('php://input');
		$_POST = json_decode($input, TRUE);

		$this->form_validation->set_rules('first_name', 'First Name', 'required');
		$this->form_validation->set_rules('last_name', 'Last Name', 'required');
		$this->form_validation->set_rules('npi', 'NPI', 'required|numeric');
		$this->form_validation->set_rules('sf_contact_id', 'SF Contact ID', 'required');
		if ($this->form_validation->run() === FALSE)
		{
			$this->ajax->validations($this->form_validation->_error_array);
			$this->ajax->output();
		}

//		// validate the variables
//		if (empty($_POST['prefix.']))
//		{
//			$errors['prefix'] = 'Prefix is required.';
//		}
//
//		if (empty($_POST['first_name.']))
//		{
//			$errors['first_name'] = 'First Name is required.';
//		}
//
//		if (!empty($errors))
//		{	// response if there are errors
//			$this->ajax->addError($errors);
//		} else {
//			// process save
//		}

		$this->ajax->output();
	}

}

// EOF
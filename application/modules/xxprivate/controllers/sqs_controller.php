<?php

class sqs_controller extends EP_Controller
{
	private $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
			$this->output->set_status_header('405');
			return;
		}

		$message = $this->input->post();

		if ($this->debug)
		{
			error_log('debug', 'insert/POST -> '. $message);
		}
		$data = json_decode($message['message'], TRUE);
//print_r($data);die;
die('212121212121');
		// validate the data
		if (empty($data['testName']) || empty($data['sampleId']))
		{
			$this->output->set_status_header('404');
			return;
		}

		// get the test type id
		$test_type = new test_type();
		$test_type->where('external_test_type_id', $data['testName']);
		$test_type->orderBy('test_version', 'desc');
		$test_type->row();
		if (!$test_type->numRows())
		{	// test type not found
			$this->output->set_status_header('404');
			return;
		}

		// get the test
		$test = new test();
		$test->join('tblSample', 'tblSample.sample_id = tblTest.sample_id');
		$test->where('tblSample.is_deleted', 0);
		$test->where('tblSample.sample_status_id', 2);
		$test->where('tblTest.is_deleted', 0);
		$test->where('tblTest.test_status_id', 1);
		$test->where('tblSample.external_sample_id', $data['sampleId']);
		$test->where('test_type_id', $test_type->test_type_id);
		$test->row();
//echo $test->lastQuery();
//print $test;
//die;
		if (!$test->numRows())
		{	// No test found
			$this->output->set_status_header('404');
			return;
		}
		// set the test status to 'Pending Report QC'
		$test->test_status_id = 3;
		$test->save();
	}

/*	public function index()
	{
		$this->load->library('sqs');

		if ($result = $this->sqs->receiveMessage())
		{
			foreach ($result['Messages'] as $object)
			{
print_r($object);
				$message = json_decode($object['Body']);
print_r($message);
die;
			}
			print_r($files);
		} else {
			echo $error."0 Messages Found - Failed</div>";
		}
		die('done');
	}
*/
}

// EOF
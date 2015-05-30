<?php

class grader_controller extends EP_Controller
{
	private $debug = TRUE;

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
	}

	public function receive()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'POST')
		{
			error_log('Message failed on ' . date(DATE_ATOM) . ' | status: 405');
			$this->output->set_status_header('405');
			return;
		}

		$message = file_get_contents('php://input');

		if ($this->debug)
		{
			log_message('debug', 'grader/receive POST -> ' . $message);
		}
		$data = json_decode($message, TRUE);

		// validate the data
		if (empty($data['testName']) || empty($data['sampleId']))
		{
			error_log('Message failed on ' . date(DATE_ATOM) . ' | status: 404');
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
			error_log('Message failed on ' . date(DATE_ATOM) . ' | status: 404');
			$this->output->set_status_header('404');
			return;
		}

		// get the test
		$test = new test();
		$test->join('tblSample', 'tblSample.sample_id = tblTest.sample_id');
		$test->where('tblSample.is_deleted', 0);
		$test->where('tblSample.sample_status_id', 2);
		$test->where('tblTest.is_deleted', 0);
//		$test->where('tblTest.test_status_id', 1);
		$test->where('tblSample.external_sample_id', $data['sampleId']);
		$test->where('test_type_id', $test_type->test_type_id);
		$test->row();
		if (!$test->numRows())
		{	// No test found
			error_log('Message failed on ' . date(DATE_ATOM) . ' | status: 404');
			$this->output->set_status_header('404');
			return;
		}
		switch ($test->test_status_id)
		{
			case 1:
				if (!empty($data['validLabInput']) && $data['validLabInput'] && !empty($data['validPatientInput']) && $data['validPatientInput'])
				{	// set the test status to 'Pending Report QC'
					$test->reportPdfBucket		= $data['reportPdfBucket'];
					$test->reportPdfKey			= $data['reportPdfKey'];
					$test->reportPdfCreatedAt	= date('Y-m-d H:i:s', strtotime($data['reportPdfCreatedAt']));
					$test->test_status_id		= 3;
					$test->save();
					error_log('Test PDF success on ' . date(DATE_ATOM) . ' | test_id: ' . $test->test_id);
				} else {
					// set the test status to 'Test Failed'
					$test->reportPdfBucket		= NULL;
					$test->reportPdfKey			= NULL;
					$test->reportPdfCreatedAt	= NULL;
					$test->test_status_id		= 7;		// Test Failed
					$test->save();
					error_log('Test PDF failure on ' . date(DATE_ATOM) . ' | test_id: ' . $test->test_id);

					// set the sample status to failed
					$sample = new sample();
					$sample->getBy('sample_id', $test->sample_id);
					if ($sample->sample_status_id == 2)
					{
						$sample->sample_status_id = 4;		// Requires Re-swab
						$sample->save();
					}
				}
				break;
			case 3:
			case 4:
			case 5:
			case 6:
//				test is already processed return 200
				error_log('Message already processed on ' . date(DATE_ATOM) . ' | test_id: ' . $test->test_id);
				break;
			default:
//				error status - test not found
				error_log('Message failed on ' . date(DATE_ATOM) . ' | status: 410 | test_id: ' . $test->test_id);
				$this->output->set_status_header('410');
				break;
		}

	}

}

// EOF
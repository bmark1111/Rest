<?php
/*
 * Count controller
 */

class count_controller Extends EP_Controller
{
	protected $debug = TRUE;
	protected $queries = array();

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		
	}

	public function test()
	{
		$excellRow = array("");
		$excell = array();

		$test_status = new test_status();
		$test_status->result();
		foreach ($test_status as $status)
		{
			$excellRow[] = $status->test_status_name;
		}
		$excell[] = implode(',', $excellRow);

		$test_type = new test_type();
		$test_type->where('test_type_id != ', 1);
		$test_type->orderBy('external_test_type_id DESC');
		$test_type->orderBy('test_version DESC');
		$test_type->result();

		$external_test_type_id = FALSE;
		$type = array();
		$x = 0;
		foreach ($test_type as $testType)
		{
			if ($testType['external_test_type_id'] != $external_test_type_id)
			{
				$type[$x]['test_type_id']			= $testType->test_type_id;
				$type[$x]['external_test_type_id']	= $testType->external_test_type_id;
				$type[$x]['test_type_name']			= $testType->test_type_name;
				$type[$x]['test_version']			= $testType->test_version;
				$x++;
 				$external_test_type_id = $testType->external_test_type_id;
			}
		}

		$counts = array();
		$type = array_reverse($type);
		//select Count(*), test_type_id from tblTest where is_deleted = 0 and test_status_id = 1 and test_type_id = 3;
		foreach ($type as $tt)
		{
			$excellRow = array();
			$excellRow[] = $tt['test_type_name'] . ' (' . $tt['external_test_type_id'] . ')';
			foreach ($test_status as $status)
			{
				$test = new test();
				$test->select('count(*) as count');
				$test->whereNotDeleted();
				$test->where('test_status_id', $status->test_status_id);
				$test->where('test_type_id', $tt['test_type_id']);
				$test->row();

				$counts[$tt['external_test_type_id']][$status->test_status_name] = $test->count;
				$excellRow[] = $test->count;
			}
			$excell[] = implode(',', $excellRow);
		}

		echo implode("\n", $excell);
		exit;
	}

	public function sample()
	{
		$excell = array();

		$sample_status = new sample_status();
		$sample_status->result();

		foreach ($sample_status as $status)
		{
			if ($status->sample_status_id == 1)
			{
				$excellDateRow = array("Week Ending");
			}
			$excellCountRow = array($status->sample_status_name);

			$start_date = strtotime('2014-10-05 08:00:00');
			$end_date = strtotime('2014-10-12 07:59:59');
			while ($start_date < time())
			{
				$s_date = date('Y-m-d H:i:s', $start_date);
				$e_date = date('Y-m-d H:i:s', $end_date);
				if ($status->sample_status_id == 1)
				{
					$excellDateRow[] = date('m/d/Y', strtotime(date('m/d/Y', $end_date) . " -8 HOURS"));
				}

				$sample = new sample();
				$sample->select('count(*) as count');
				$sample->whereNotDeleted();
				$sample->where('sample_status_id', $status->sample_status_id);
				$sample->where('created_datetime >= ', $s_date);
				$sample->where('created_datetime <= ', $e_date);
				$sample->row();

				$excellCountRow[] = $sample->count;

				$start_date = strtotime(date('Y-m-d H:i:s', $start_date) . ' + 1 week');
				$end_date = strtotime(date('Y-m-d H:i:s', $end_date) . ' + 1 week');
			}

			if ($status->sample_status_id == 1)
			{
				$excell[] = implode(',', $excellDateRow);
			}
			$excell[] = implode(',', $excellCountRow);
		}

		echo implode("\n", $excell);
		exit;
	}

}

// EOF
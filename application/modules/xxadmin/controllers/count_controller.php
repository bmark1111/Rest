<?php
/*
 * Admin Count controller
 */

require_once (APPPATH . 'modules/api/controllers/api_controller.php');

class count_controller Extends api_controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/count)"));
			$this->ajax->output();
		}

		$start_date = $this->input->get('start_date');
		$end_date = $this->input->get('end_date');
		$start_date = ($start_date) ? date('Y-m-d 00:00:00', strtotime($start_date)) : date('Y-m-d 00:00:00');
		$end_date = ($end_date) ? date('Y-m-d 23:59:59', strtotime($end_date)) : date('Y-m-d 23:59:59');

		$queries = array();
		$queries[] = "CALL pr_Admin_GetIntakeHistory('" . $this->sessionId . "', '" . $start_date . "', '" . $end_date . "')";
		$counts = $this->_call_procedure($queries);
		if (!empty($counts[0]))
		{
			foreach ($counts[0] as $x => $count)
			{
				$counts[0][$x]['Date_of_Collection'] = ($counts[0][$x]['Date_of_Collection']) ? date('m/d/Y', strtotime($counts[0][$x]['Date_of_Collection'])): NULL;
				$counts[0][$x]['Date_Received'] = ($counts[0][$x]['Date_Received']) ? date('m/d/Y', strtotime($counts[0][$x]['Date_Received'])): NULL;
				$counts[0][$x]['Date_Entered_Into_Helix'] = ($counts[0][$x]['Date_Entered_Into_Helix']) ? date('m/d/Y', strtotime($counts[0][$x]['Date_Entered_Into_Helix'])): NULL;
			}
			$this->ajax->setData('result', $counts[0]);
		} else {
			$this->ajax->addError("No encounters found for the time period (" . date('m/d/Y', strtotime($start_date)) . ' - ' . date('m/d/Y', strtotime($end_date)) . ")");
		}

		$this->ajax->output();
	}

	public function test()
	{
		if ($_SERVER['REQUEST_METHOD'] != 'GET')
		{
			$this->ajax->addError(new AjaxError("403 - Forbidden (admin/count/test)"));
			$this->ajax->output();
		}

		$excellRow = array("");
		$excell = array();

		$test_status = new test_status();
		$test_status->result();
		foreach ($test_status as $status)
		{
			$excellRow[] = $status->test_status_name;
		}
		$excell['heading'] = $excellRow;

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
			$excell['data'][] = $excellRow;
		}

		$this->ajax->setData('result', $excell);
		$this->ajax->output();
	}

	public function sample()
	{
		$excell = array();

		$sample_status = new sample_status();
		$sample_status->result();

		foreach ($sample_status as $x => $status)
		{
			if ($status->sample_status_id == 1)
			{
				$excell['heading'][] = "Week Ending";
			}
			$excell['data'][$x][] = $status->sample_status_name;

			// go back 10 weeks from now
			$n = date('N');
			$d = strtotime("+" . (7 - $n) . "DAYS");
			$start_date = strtotime(date('Y-m-d 08:00:00', $d) . " -10 week");
			$end_date = strtotime(date('Y-m-d 07:59:59', $start_date) . " +1 week");
//			$start_date = strtotime('2014-10-05 08:00:00');
//			$end_date = strtotime('2014-10-12 07:59:59');
			while ($start_date < time())
			{
				$s_date = date('Y-m-d H:i:s', $start_date);
				$e_date = date('Y-m-d H:i:s', $end_date);
				if ($status->sample_status_id == 1)
				{
					$excell['heading'][] = date('m/d/Y', strtotime(date('m/d/Y', $end_date) . " -8 HOURS"));
				}

				$sample = new sample();
				$sample->select('count(*) as count');
				$sample->whereNotDeleted();
				$sample->where('sample_status_id', $status->sample_status_id);
				$sample->where('created_datetime >= ', $s_date);
				$sample->where('created_datetime <= ', $e_date);
				$sample->row();

				$excell['data'][$x][] = $sample->count;

				$start_date = strtotime(date('Y-m-d H:i:s', $start_date) . ' + 1 week');
				$end_date = strtotime(date('Y-m-d H:i:s', $end_date) . ' + 1 week');
			}
		}

		$this->ajax->setData('result', $excell);
		$this->ajax->output();
	}

	public function totals()
	{
		$start_date = $this->input->get('start_date');
		$end_date = $this->input->get('end_date');
		$start_date = ($start_date) ? date('Y-m-d 08:00:00', strtotime($start_date)) : date('Y-m-d 08:00:00');
		$end_date = ($end_date) ? date('Y-m-d 07:59:59', strtotime($end_date . ' +24 HOURS')) : date('Y-m-d 07:59:59', strtotime('+24 HOURS'));

		$encounters = new encounter();
		$encounters->select('tblEncounter.encounter_id, tblAccount.account_id, tblContact.company_name');
		$encounters->join('tblAccount', 'tblAccount.account_id = tblEncounter.account_id', 'inner');
		$encounters->join('tblContact', 'tblContact.contact_id = tblAccount.contact_id', 'inner');
		$encounters->where('tblEncounter.is_deleted', 0);
		$encounters->where("tblEncounter.created_datetime BETWEEN '" . $start_date . "' AND '" . $end_date . "'");
		$encounters->result();
		if ($encounters->numRows())
		{
			$accounts = array();
			foreach ($encounters as $encounter)
			{
				$account_name = (!empty($encounter->company_name)) ? $encounter->company_name: 'Unassigned';
				$accounts[$account_name][] = $encounter->encounter_id;
			}

			$excell = array();
			foreach ($accounts as $account_name => $account)
			{
				$encounterIds = array();
				foreach ($account as $encounter_id)
				{
					$encounterIds[] = $encounter_id;
				}
				$samples = new sample();
				$samples->whereNotDeleted();
				$samples->whereIn('encounter_id', $encounterIds);
				$samples->result();

				$excellRow = array();
				$excellRow['Account_Name'] = $account_name;
				$excellRow['Sample_Count'] = $samples->count();

				$tests = new test();
				$tests->whereNotDeleted();
				$tests->where('test_type_id', 3);
				$tests->whereIn('encounter_id', $encounterIds);
				$tests->result();
				$excellRow['PBIO1_Count'] = $tests->count();

				$tests = new test();
				$tests->whereNotDeleted();
				$tests->where('test_type_id', 5);
				$tests->whereIn('encounter_id', $encounterIds);
				$tests->result();
				$excellRow['PBIO2_Count'] = $tests->count();

				$tests = new test();
				$tests->whereNotDeleted();
				$tests->where('test_type_id', 6);
				$tests->whereIn('encounter_id', $encounterIds);
				$tests->result();
				$excellRow['PBIO3_Count'] = $tests->count();

				$tests = new test();
				$tests->whereNotDeleted();
				$tests->where('test_type_id', 7);
				$tests->whereIn('encounter_id', $encounterIds);
				$tests->result();
				$excellRow['PBIO4_Count'] = $tests->count();

				$excell[] = $excellRow;
			}

			$this->ajax->setData('result', $excell);
		} else {
			$this->ajax->addError("No totals found for the time period (" . date('m/d/Y', strtotime($start_date)) . ' - ' . date('m/d/Y', strtotime($end_date)) . ")");
		}

		$this->ajax->output();
	}

	public function downloads()
	{
		$start_date = $this->input->get('start_date');
		$end_date = $this->input->get('end_date');
		$start_date = ($start_date) ? date('Y-m-d 08:00:00', strtotime($start_date)) : date('Y-m-d 08:00:00');
		$end_date = ($end_date) ? date('Y-m-d 07:59:59', strtotime($end_date . ' +24 HOURS')) : date('Y-m-d 07:59:59', strtotime('+24 HOURS'));

		$sql = "SELECT BD.`billing_download_id`,
						CONVERT_TZ(BD.`created_datetime`,'+00:00','-08:00') as created_at,
						CONCAT(U.`first_name`, ' ', U.`last_name`) as name,
						(SELECT COUNT(*) FROM tblTest T WHERE T.`billing_download_id` = BD.`billing_download_id` AND T.`is_deleted` = 0) as count,
						(SELECT PT.payer_type_name
						  FROM tblTest T 
						  INNER JOIN tblEncounterPayer EP ON EP.encounter_id = T.encounter_id AND EP.`is_deleted` = 0
						  INNER JOIN tblPayer P ON P.payer_id = EP.payer_id
						  LEFT JOIN tblPayerCompany PC ON PC.payer_company_id = P.payer_company_id
						  LEFT JOIN tblPayerType PT ON PT.payer_type_id = PC.payer_type_id
						  WHERE T.`billing_download_id` = BD.`billing_download_id` AND T.`is_deleted` = 0
						  LIMIT 1) as payer_type
				FROM `tblBillingDownload` BD
				INNER JOIN tblUser U ON U.user_id = BD.`created_by`
				WHERE BD.`created_datetime` BETWEEN '" . $start_date . "' AND '" . $end_date . "'";

		$downloads = new account();
		$downloads->queryAll($sql);
		if ($downloads->count())
		{
			foreach ($downloads as $download)
			{
				$download->created_at = ($download->created_at) ? date('m/d/Y h:i A', strtotime($download->created_at)): '';
			}
			$this->ajax->setData('result', $downloads->toArray());
		} else {
			$this->ajax->addError("No billing downloads found for the time period (" . date('m-d-Y', strtotime($start_date)) . ' - ' . date('m-d-Y', strtotime($end_date)) . ")");
		}
		$this->ajax->output();
	}

	public function available()
	{
		$start_date = $this->input->get('start_date');
		$end_date = $this->input->get('end_date');
		$start_date = ($start_date) ? date('Y-m-d 08:00:00', strtotime($start_date)) : date('Y-m-d 08:00:00');
		$end_date = ($end_date) ? date('Y-m-d 07:59:59', strtotime($end_date . ' +24 HOURS')) : date('Y-m-d 07:59:59', strtotime('+24 HOURS'));

		$sql = "SELECT `date`, payer_type_name, count(*) as count
				FROM
				(
					SELECT DATE(MIN(date)) as `date`, test_id, payer_type_name
					FROM (
					  SELECT CONVERT_TZ(TH.modified_datetime,'+00:00','-08:00') as `date`, test_id, PT.payer_type_name
					  FROM `tblTestHistory` TH
					  INNER JOIN tblEncounterPayer EP ON EP.encounter_id = TH.encounter_id AND EP.`is_deleted` = 0
					  INNER JOIN tblPayer P ON P.payer_id = EP.payer_id
					  LEFT JOIN tblPayerCompany PC ON PC.payer_company_id = P.payer_company_id
					  LEFT JOIN tblPayerType PT ON PT.payer_type_id = PC.payer_type_id
					  WHERE TH.`test_status_id` = 4 AND TH.is_deleted = 0 AND P.coverage_order = 1
					  ) AS T1
					GROUP BY T1.test_id
				  UNION
					SELECT DATE(`date`) as `date`, test_id, payer_type_name
					FROM (
					  SELECT CONVERT_TZ(T.modified_datetime,'+00:00','-08:00') as `date`, test_id, PT.payer_type_name
					  FROM `tblTest` T
					  INNER JOIN tblEncounterPayer EP ON EP.encounter_id = T.encounter_id AND EP.`is_deleted` = 0
					  INNER JOIN tblPayer P ON P.payer_id = EP.payer_id
					  LEFT JOIN tblPayerCompany PC ON PC.payer_company_id = P.payer_company_id
					  LEFT JOIN tblPayerType PT ON PT.payer_type_id = PC.payer_type_id
					  WHERE T.`test_status_id` = 4 AND T.is_deleted = 0 AND P.coverage_order = 1
					  ) AS T2
				) AS T3
				WHERE T3.`date` BETWEEN '" . $start_date . "' AND '" . $end_date . "'
				GROUP BY T3.`date`, T3.payer_type_name";

		$availables = new account();
		$availables->queryAll($sql);
		if ($availables->count())
		{
			foreach ($availables as $available)
			{
				$available->date = ($available->date) ? date('m/d/Y', strtotime($available->date)): '';
			}
			$this->ajax->setData('result', $availables->toArray());
		} else {
			$this->ajax->addError("No billing downloads available found for the time period (" . date('m-d-Y', strtotime($start_date)) . ' - ' . date('m-d-Y', strtotime($end_date)) . ")");
		}
		$this->ajax->output();
	}

	public function ordering()
	{
		$start_date = $this->input->get('start_date');
		$end_date = $this->input->get('end_date');
		$start_date = ($start_date) ? date('Y-m-d 08:00:00', strtotime($start_date)) : date('Y-m-d 08:00:00');
		$end_date = ($end_date) ? date('Y-m-d 07:59:59', strtotime($end_date . ' +24 HOURS')) : date('Y-m-d 07:59:59', strtotime('+24 HOURS'));

		$sql = "SELECT E.doctor_id, CONCAT(DC.first_name,' ', DC.last_name) as doctor_name, COUNT(*) as sample_count,
						(SELECT COUNT(*) FROM tblTest T WHERE T.is_deleted = 0 AND 
						T.encounter_id IN (SELECT encounter_id FROM tblEncounter WHERE is_deleted = 0 AND doctor_id = E.doctor_id AND created_datetime BETWEEN '" . $start_date . "' AND '" . $end_date . "'))
						 AS test_count
				FROM tblEncounter E
				LEFT JOIN tblDoctor D on D.doctor_id = E.doctor_id
				LEFT JOIN tblContact DC ON DC.contact_id = D.contact_id
				WHERE E.is_deleted = 0 AND E.created_datetime BETWEEN '" . $start_date . "' AND '" . $end_date . "'
				GROUP BY E.doctor_id;";
		$encounters = new encounter();
		$encounters->queryAll($sql);
		if ($encounters->count())
		{
			$this->ajax->setData('result', $encounters->toArray());
		} else {
			$this->ajax->addError("No ordering doctors found for the time period (" . date('m-d-Y', strtotime($start_date)) . ' - ' . date('m-d-Y', strtotime($end_date)) . ")");
		}
		$this->ajax->output();
	}

}

// EOF
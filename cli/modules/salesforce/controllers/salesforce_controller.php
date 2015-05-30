<?php

class salesforce_controller extends EP_Controller
{
	private $csr = array();

	private $table_mapping = array(
		'account' =>
			array(
				array('db_col' => 'sf_account_id', 'sf_col' => 'Id'),
				array('db_col' => 'name', 'sf_col' => 'Name'),
				array('db_col' => 'account_num', 'sf_col' => 'Account_Number__c'),
				array('db_col' => 'type', 'sf_col' => 'Type'),
				array('db_col' => 'status', 'sf_col' => 'Account_Status__c'),
				array('db_col' => 'billing_city', 'sf_col' => 'BillingCity'),
				array('db_col' => 'billing_country', 'sf_col' => 'BillingCountry'),
				array('db_col' => 'billing_postal', 'sf_col' => 'BillingPostalCode'),
				array('db_col' => 'billing_state', 'sf_col' => 'BillingState'),
				array('db_col' => 'billing_street', 'sf_col' => 'BillingStreet'),
				array('db_col' => 'phone', 'sf_col' => 'Phone'),
				array('db_col' => 'description', 'sf_col' => 'Description'),
				array('db_col' => 'npi', 'sf_col' => 'NPI__c'),
				array('db_col' => 'tax_id_no', 'sf_col' => 'Tax_I_D_No__c'),
				array('db_col' => 'physician_licensee', 'sf_col' => 'Physician_Licensee__c'),
				array('db_col' => 'physician_medicare', 'sf_col' => 'Physician_Medicare__c'),
				array('db_col' => 'physician_medicaid', 'sf_col' => 'Physician_Medicaid__c'),
				array('db_col' => 'clinical_associate', 'sf_col' => 'Clinical_Associate__c'),
				array('db_col' => 'agreement_date', 'sf_col' => 'Agreement_Dated__c')
			),
		'contact' =>
			array(
				array('db_col' => 'accounts_id', 'sf_col' => 'AccountId', 'r_table' => 'accounts', 'r_table_col' => 'sf_account_id'),
				array('db_col' => 'sf_contact_id', 'sf_col' => 'Id'),								// varchar(20)
				array('db_col' => 'sf_account_id', 'sf_col' => 'AccountId', 'where' => '!= NULL'),	// varchar(20)
				array('db_col' => 'last_name', 'sf_col' => 'LastName'),								// varchar(80)
				array('db_col' => 'first_name', 'sf_col' => 'FirstName'),							// varchar(40)
				array('db_col' => 'salutation', 'sf_col' => 'Salutation'),							// varchar(40)
				array('db_col' => 'other_street', 'sf_col' => 'OtherStreet'),						// varchar(255)
				array('db_col' => 'other_city', 'sf_col' => 'OtherCity'),							// varchar(40)
				array('db_col' => 'other_state', 'sf_col' => 'OtherState'),						// varchar(80)
				array('db_col' => 'other_zip', 'sf_col' => 'OtherPostalCode'),					// varchar(20)
				array('db_col' => 'other_country', 'sf_col' => 'OtherCountry'),					// varchar(80)
				array('db_col' => 'mailing_street', 'sf_col' => 'MailingStreet'),				// varchar(255)
				array('db_col' => 'mailing_city', 'sf_col' => 'MailingCity'),					// varchar(40)
				array('db_col' => 'mailing_state', 'sf_col' => 'MailingState'),					// varchar(80)
				array('db_col' => 'mailing_zip', 'sf_col' => 'MailingPostalCode'),				// varchar(20)
				array('db_col' => 'mailing_country', 'sf_col' => 'MailingCountry'),				// varchar(80)
				array('db_col' => 'business_phone', 'sf_col' => 'Phone'),						// varchar(40)
				array('db_col' => 'business_fax', 'sf_col' => 'Fax'),							// varchar(40)
				array('db_col' => 'mobile_phone', 'sf_col' => 'MobilePhone'),					// varchar(40)
				array('db_col' => 'home_phone', 'sf_col' => 'HomePhone'),						// varchar(40)
				array('db_col' => 'other_phone', 'sf_col' => 'OtherPhone'),						// varchar(40)
				array('db_col' => 'email', 'sf_col' => 'Email'),								// varchar(80)
				array('db_col' => 'npi', 'sf_col' => 'NPI__c'),									// varchar(20)
				array('db_col' => 'license', 'sf_col' => 'MD_License__c')						// varchar(255)
			),
		'location_del__c' =>
			array(
				array('db_col' => 'account_id', 'sf_col' => 'Account__c', 'r_table' => 'accounts', 'r_table_col' => 'sf_account_id'),
				array('db_col' => 'sf_location_id', 'sf_col' => 'Id'),					// varchar(20)
				array('db_col' => 'name', 'sf_col' => 'Name'),									// varchar(80)
				array('db_col' => 'address1', 'sf_col' => 'Address__c'),						// varchar(255)
				array('db_col' => 'city', 'sf_col' => 'City__c'),								// varchar(255)
				array('db_col' => 'address2', 'sf_col' => 'Address_2__c'),						// varchar(255)
				array('db_col' => 'state', 'sf_col' => 'State__c'),								// varchar(255)
				array('db_col' => 'site', 'sf_col' => 'Site_Number__c'),						// varchar(255)
				array('db_col' => 'sf_account_id', 'sf_col' => 'Account__c'),					// varchar(18)
				array('db_col' => 'zip', 'sf_col' => 'Zip__c'),									// varchar(10)
				array('db_col' => 'phone', 'sf_col' => 'Phone__c'),								// varchar(40)
				array('db_col' => 'fax', 'sf_col' => 'Fax__c')									// varchar(40)
			)
		);

	public function __construct()
	{
		parent::__construct();
		
		$this->load->library('salesforce');
		$this->salesforce->login();
	}

	public function index()
	{
		echo "Usage\n\r";
		echo "reports ytd - New Dr's purchasing YTD\n\r";
		echo "reports orders - Accounts not ordering this month\n\r";
		echo "reports volume - Daily Volume\n\r";
		echo "reports csr - CSR Volume\n\r";
		echo "accounts - retrieve all accounts\n\r";
		echo "show_account {id} - Show data for account {id}\n\r";
		echo "update_account {id} {name} {billing_city} - Update account ***** Test *****\n\r"; 
		echo "updated_accounts - Get updated accounts for today\n\r";
	}

	public function reports($type = FALSE)
	{
		$output = array();
		$data = array();

		switch ($type)
		{
			default:
				$url = "/analytics/reports/";
				$response = $this->salesforce->get($url);
print_r($response);
				break;
			case 'volume':
				$url = "/analytics/reports/00OE0000002G3hfMAC";
				$response = $this->salesforce->get($url);

				// get key part 2
				$output = array();
				foreach ($response['groupingsAcross'] as $groupingsAcross)
				{
					foreach ($groupingsAcross as $groupingAcross)
					{
						foreach ($groupingAcross['groupings'] as $groupings)
						{
							$dt1 = strtotime('-30 day');
							$dt2 = strtotime($groupings['label']);
							if ($dt2 >= $dt1)
							{
								$output[$groupings['label']][] = $groupings['key'];
							}
						}
					}
				}

				$jsonOut = array('graph' => array(	'title'	=> '',
													'type'	=> 'bar',
													'datasequences' => array()));
				$jsonOut['graph']['datasequences'][0]['title'] = 'Daily Volume';
				$y = 0;
				foreach ($output as $day => $totals)
				{
					$total = 0;
					foreach ($totals as $key2)
					{
						$key = 'T!' . $key2;
						$total += $response['factMap'][$key]['aggregates'][0]['value'];
					}
					$jsonOut['graph']['datasequences'][0]['datapoints'][$y]['title'] = date('n/j', strtotime($day));
					$jsonOut['graph']['datasequences'][0]['datapoints'][$y]['value'] = $total;
					$y++;
				}

				$fp = fopen('public/statusboard/report4.json', 'w');
				fwrite($fp, json_encode($jsonOut));
				fclose($fp);

				break;
			case 'orders':				// Dr's not ordering
				$url = "/analytics/reports/00OE0000002FGlrMAG";
				$response = $this->salesforce->get($url);

				// get key part 1
				$data = $this->_getGroupingsDown($response);

				// get key part 2
				foreach ($response['groupingsAcross'] as $groupingsAcross)
				{
					foreach ($groupingsAcross as $groupingAcross)
					{
						$output[$groupingAcross['label']] = array();
						foreach ($groupingAcross['groupings'] as $groupings)
						{
							$output[$groupingAcross['label']][$groupings['key']]['label'] = $groupings['label'];
						}
					}
				}

				$index1 = array();
				$index2 = array();
				foreach ($output as $test => $month)
				{
					// get index of last month and this month
					$index1[] = key(array_slice($month, -1));
					$index2[] = key(array_slice($month, -2));
				}
				// find Dr's that haven't orderd this month but did order last month
				$dataOut = array();
				foreach ($data['key'] as $x => $key1)
				{
					$count_for_current_month = 0;
					$count_for_last_month = 0;
					// get totaled ordered for current month
					foreach ($index1 as $index)
					{
						$key_last = $key1 . '!' . $index;
						$count_for_current_month += $response['factMap'][$key_last]['aggregates'][0]['value'];
					}
					// get totaled ordered for last month
					foreach ($index2 as $index)
					{
						$key_last = $key1 . '!' . $index;
						$count_for_last_month += $response['factMap'][$key_last]['aggregates'][0]['value'];
					}
					// if Dr did not order this month but did order last month
					if ($count_for_current_month == 0 && $count_for_last_month > 0)
					{
						$dataOut[] = $data['label'][$x];
					}
				}

				$fp = fopen('public/statusboard/report2.html', 'w');
				fwrite($fp, $this->load->view('report2', array('dataOut' => $dataOut), TRUE));
				fclose($fp);

				break;
			case 'iso':				// ISO Dr's ordering by month
//				$url = "/services/data/v29.0/analytics/reports/00OE0000002FGlrMAG";
				$url = "/analytics/reports/00OE0000002FGlrMAG";
				$response = $this->salesforce->get($url);

				// get key part 1
				$data = $this->_getGroupingsDown($response);

				// get key part 2
				$output = array();
				foreach ($response['groupingsAcross'] as $groupingsAcross)
				{
					foreach ($groupingsAcross as $groupingAcross)
					{
						foreach ($groupingAcross['groupings'] as $groupings)
						{
							$output[$groupings['label']][] = $groupings['key'];
						}
					}
				}

				// increment the count of Dr's ordering per ISO
				$dataOut = array();
				foreach ($output as $month => $index)			// loop through each month
				{
					foreach ($data['key'] as $key1)				// loop through each Account
					{
						$iso = explode('_', $key1);
						if (!isset($dataOut[$this->csr[$iso[0]]][$month]))
						{
							$dataOut[$this->csr[$iso[0]]][$month] = 0;
						}
						$total = 0;
						foreach ($index as $key2)				// loop through each Test Type
						{
							$key = $key1 . '!' . $key2;
							$total += $response['factMap'][$key]['aggregates'][0]['value'];
						}
						if ($total > 0)
						{
							$dataOut[$this->csr[$iso[0]]][$month]++;	// increment count per ISO
						}
					}
				}

				$jsonOut = array('graph' => array(	'title'	=> "DR's Ordering/ISO ",
													'type'	=> 'line',
													'yAxis'	=> array('minValue' => 0, 'maxValue' => 30),
													'datasequences' => array()));
				$x = 0;
				foreach ($dataOut as $iso => $totals)
				{
					$initials = "";
					$fullNames = explode("/", $iso);
					foreach ($fullNames as $fullName)
					{
						if ($initials != "")
						{
							$initials .= '/';
						}
						$names = explode(" ", $fullName);
						foreach ($names as $name)
						{
							$initials .= substr($name, 0, 1);
						}
					}
					$jsonOut['graph']['datasequences'][$x]['title'] = strtoupper($initials);
					$y = 0;
					foreach ($totals as $date => $total)
					{
						$jsonOut['graph']['datasequences'][$x]['datapoints'][$y]['title'] = date('M j', strtotime($date));
						$jsonOut['graph']['datasequences'][$x]['datapoints'][$y]['value'] = $total;
						$y++;
					}
					$x++;
				}

				$fp = fopen('public/statusboard/report5.json', 'w');
				fwrite($fp, json_encode($jsonOut));
				fclose($fp);

				break;
			case 'ytd':				// YTD Report
				$url = "/analytics/reports/00OE0000002FGlrMAG";
				$response = $this->salesforce->get($url);

				// get key part 1
				$data = $this->_getGroupingsDown($response);

				// get key part 2
				$output = array();
				foreach ($response['groupingsAcross'] as $groupingsAcross)
				{
					foreach ($groupingsAcross as $groupingAcross)
					{
						foreach ($groupingAcross['groupings'] as $groupings)
						{
							$output[$groupings['label']][] = $groupings['key'];
						}
					}
				}

				// increment counts of Dr's ordering per month
				$dataOut = array();
				foreach ($output as $month => $index)
				{
					foreach ($data['key'] as $key1)
					{
						$total = 0;
						foreach ($index as $key2)
						{
							$key = $key1 . '!' . $key2;
							$total += $response['factMap'][$key]['aggregates'][0]['value'];
						}
						if ($total > 0)
						{
							if (isset($dataOut[$month]))
							{
								$dataOut[$month]++;
							} else {
								$dataOut[$month] = 1;
							}
						}
					}
				}

				$fp = fopen('public/statusboard/report1.html', 'w');
				fwrite($fp, $this->load->view('report1', array('dataOut' => $dataOut), TRUE));
				fclose($fp);

				break;
			case 'csr':			// Volume Report by CSR
				$url = "/analytics/reports/00OE0000002G2LnMAK";
				$response = $this->salesforce->get($url);

				// get key part 1
				$data = $this->_getGroupingsDown($response);

				// get key part 2
				$output = array();
				foreach ($response['groupingsAcross'] as $groupingsAcross)
				{
					foreach ($groupingsAcross as $groupingAcross)
					{
						foreach ($groupingAcross['groupings'] as $groupings)
						{
							$output[$groupings['value']][] = $groupings['key'];
						}
					}
				}

				// accumulate csr totals for last 4 weeks
				$dataOut = array();
				$output = array_reverse($output);
				$output = array_chunk ($output, 4, TRUE);
				$output = array_reverse($output[0]);
				foreach ($output as $week => $index)
				{
					foreach ($data['key'] as $key1)
					{
						$csr_index = explode('_', $key1);

						$total = 0;
						foreach ($index as $key2)
						{
							$key = $key1 . '!' . $key2;
							$total += $response['factMap'][$key]['aggregates'][0]['value'];
						}
//						$dataOut[$this->csr[$csr_index[0]]][$week] += $total;
						if (isset($dataOut[$this->csr[$csr_index[0]]][$week]))
						{
							$dataOut[$this->csr[$csr_index[0]]][$week] += $total;
						}
						elseif (isset($dataOut[$this->csr[$csr_index[0]]]))
						{
							$dataOut[$this->csr[$csr_index[0]]][$week] = $total;
						} else {
							$dataOut[$this->csr[$csr_index[0]]] = array();
							$dataOut[$this->csr[$csr_index[0]]][$week] = $total;
						}
					}
				}

				$jsonOut = array('graph' => array(	'title'	=> 'CSR Volume',
													'type'	=> 'line',
													'yAxis'	=> array('minValue' => 0),//, 'maxValue' => 700),
													'datasequences' => array()));
				$x = 0;
				foreach ($dataOut as $csr => $totals)
				{
					$initials = "";
					$fullNames = explode("/", $csr);
					foreach ($fullNames as $fullName)
					{
						if ($initials != "")
						{
							$initials .= '/';
						}
						$names = explode(" ", $fullName);
						foreach ($names as $name)
						{
							$initials .= substr($name, 0, 1);
						}
					}
					$jsonOut['graph']['datasequences'][$x]['title'] = strtoupper($initials);
					$y = 0;
					foreach ($totals as $date => $total)
					{
						$jsonOut['graph']['datasequences'][$x]['datapoints'][$y]['title'] = date('M j', strtotime($date));
						$jsonOut['graph']['datasequences'][$x]['datapoints'][$y]['value'] = $total;
						$y++;
					}
					$x++;
				}

				$fp = fopen('public/statusboard/report3.json', 'w');
				fwrite($fp, json_encode($jsonOut));
				fclose($fp);

				break;
		}
		exit;
	}

	private function _getGroupingsDown($response)
	{
		$data = array();
		foreach ($response['groupingsDown'] as $groupingsDown)
		{
			foreach ($groupingsDown as $groupingDown)
			{
				$this->csr[] = $groupingDown['label'];					// save the CSR or ISO
				foreach ($groupingDown['groupings'] as $groupings)
				{
					$data['key'][] = $groupings['key'];
					$data['label'][] = $groupings['label'];
				}
			}
		}
		return $data;
	}

	public function objects()
	{
		$response = $this->salesforce->get("/sobjects");
		print_r($response);
	}

	public function describe($sObject = FALSE, $all = FALSE)
	{
		if ($sObject)
		{
			$response = $this->salesforce->get("/sobjects/" . $sObject . "/describe");

			foreach ($response['fields'] as $field)
			{
				if ($all === 'all' || $this->_is_mapped($field['name'], $sObject))
				{
					echo $field['label'] . ' ' . $field['name'] . ' ' .  $field['length'] . ' ' .  $field['type'] . "\n\r";
				}
			}
		}
	}

	public function dump($sObject = FALSE)
	{
		if ($sObject)
		{
			$query = $this->_build_query($sObject);

			$response = $this->salesforce->get("/query?q=" . urlencode($query));

			$this->_writeRecord($response['records'], $sObject);
		}
	}

	public function show($sObject, $id, $where = TRUE, $return = FALSE)
	{
		$query = $this->_build_query($sObject, $where) . " WHERE Id = '" . $id . "'";

		$response = $this->salesforce->get("/query?q=" . urlencode($query));

		if (!$return)
		{
			foreach ($response['records'][0] as $key => $value)
			{
				echo "$key: $value\n\r";
			}
		} else {
			return $response['records'][0];
		}
	}

	public function update_account($id, $new_name, $city)
	{
		$content = json_encode(array("Name" => $new_name, "BillingCity" => $city));

		$this->salesforce->put("/sobjects/Account/" . $id, $content);
	}

	public function updates($sObject = FALSE)
	{
		if (!$sObject)
		{
			exit;
		}

		$date = date('Y-m-d');
		// get id's of updated accounts today.
		$response = $this->salesforce->get("/sobjects/" . $sObject . "/updated/?start=" . $date . "T00%3A00%3A00%2B00%3A00&end=" . $date . "T23%3A23%3A59%2B00%3A00");

		if (!empty($response['ids']))
		{
			foreach ($response['ids'] as $updated_id)
			{
				// get the updated account from salesforce
				$updated = $this->show($sObject, $updated_id, FALSE, TRUE);

				// get the current data
				$model = $this->_getModel($sObject)['object'];

				$current = new $model();
				$current->getBy('sf_' . _getModel($sObject)['object'] . '_id', $updated_id);

				if ($current->numRows())
				{	// if record exists .....
					// ..... check to see what fields need to be updated
					foreach ($this->table_mapping[$sObject] as $map)
					{
						if (empty($map['r_table']))
						{	// if not relationship field
							if ($current->$map['db_col'] != $updated[$map['sf_col']])
							{	// data has changed so set new value
								$current->$map['db_col'] = $updated[$map['sf_col']];
							}
						}
					}
				} else {
					// record does not exist ..... write new
					foreach ($this->table_mapping[$sObject] as $map)
					{
						if (empty($map['r_table']))
						{	// if not relationship field
							$current->$map['db_col'] = $updated[$map['sf_col']];
						} else {
							// relational field .... get id
							$table = new $map['r_table']();
							$table->getBy($map['r_table_col'], $updated[$map['sf_col']]);
							if ($table->numRows())
							{
								$current->$map['db_col'] = $table->id;
							} else {
								die('error');
							}
						}
					}
				}
				// save the updated record
				$current->save();
			}
		}
	}

	public function deletes($sObject = FALSE)
	{
		if (!$sObject)
		{
			exit;
		}

		$date = date('Y-m-d');
		// get id's of updated records today.
		$response = $this->salesforce->get("/sobjects/" . $sObject . "/deleted/?start=" . $date . "T00%3A00%3A00%2B00%3A00&end=" . $date . "T23%3A23%3A59%2B00%3A00");

		if (!empty($response['deletedRecords']))
		{
			foreach ($response['deletedRecords'] as $deleted)
			{
				// get the reocrd
				$model = $this->_getModel($sObject)['object'];
				$model = new $model();
				$model->getBy('sf_' . $sObject . '_id', $deleted['id']);

				// delete the record
				$model->delete();
			}
		}
	}

	private function _is_mapped($field_name, $sObject)
	{
//		$table_mapping = $sObject . "_table_mapping";
//		if (isset($this->$table_mapping))
//		{
//			foreach ($this->$table_mapping as $map)
		if (isset($this->table_mapping[$sObject]))
		{
			foreach ($this->table_mapping[$sObject] as $map)
			{
				if (empty($map['r_table']) && $map['sf_col'] == $field_name)
				{	// if not a relational field and field name matches
					return TRUE;
				}
			}
			return FALSE;
		}
		return TRUE;
	}
	
	private function _build_query($sObject, $include_where = TRUE)
	{
		$query = array();
		$where = array();
//		$table_mapping = $sObject . '_table_mapping';
//		if (isset($this->$table_mapping))
//		{
//			foreach ($this->$table_mapping as $map)
		if (isset($this->table_mapping[$sObject]))
		{
			foreach ($this->table_mapping[$sObject] as $map)
			{
				if (empty($map['r_table']))
				{	// if not a relational field
					$query[] = $map['sf_col'];
					if ($include_where && isset($map['where']))
					{
						$where[] = $map['sf_col'] . ' ' . $map['where'];
					}
				}
			}

			if (empty($where))
			{
				return "SELECT " . implode(',', $query) . " FROM " . _getModel($sObject)['table'];
			} else {
				return "SELECT " . implode(',', $query) . " FROM " . _getModel($sObject)['table'] . " WHERE " . implode(' AND ', $where);
			}
		}
		return '';
	}
	
	/*
	 * _writeRecord: writes the Salesforce record to the appropriate mysql table
	 * $records:	Salesforce records to be written
	 * $sObject:	Salesforce Object
	 */
	private function _writeRecord($records, $sObject)
	{
		$model = $this->_getModel($sObject)['object'];
//		$table_mapping = $sObject . '_table_mapping';
//		if (isset($this->$table_mapping))
		if (isset($this->table_mapping[$sObject]))
		{
			foreach ($records as $record)
			{
				$obj = new $model();
//				foreach ($this->$table_mapping as $map)
				foreach ($this->table_mapping[$sObject] as $map)
				{
					if (empty($map['r_table']))
					{	// if not a relational field
						$obj->$map['db_col'] = $record[$map['sf_col']];
					} else {
						// relational field .... get id
						$table = new $map['r_table']();
						$table->getBy($map['r_table_col'], $record[$map['sf_col']]);
						if ($table->numRows())
						{
							$obj->$map['db_col'] = $table->id;
						} else {
							die('error');
						}
					}
				}
//print_r($record);
//print $obj;
//die;
				$obj->save();
			}
		}
	}
	
	private function _getModel($sObject)
	{
		switch ($sObject)
		{
			case 'contact':
				return array('object' => 'contact', 'table' => 'tblImportSalesForceContact');
			case 'account':
				return array('object' => 'account', 'table' => 'tblImportSalesForceAccount');
			case 'location_del__c':
				return array('object' => 'location', 'table' => 'tblImportSalesForceLocation');
		}
	}
}

// EOF
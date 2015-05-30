<?php
/*
 * forecast.php
 * Brian Markham 04/10/2015
 *
*/
class forecast extends Nagilum
{
	public $table = 'forecast';
	
	public $hasOne = array(	'category' => array('class' => 'category', 'joinField' => 'category_id')
						);

	public $autoPopulateHasOne = FALSE;
	public $autoPopulateHasMany = FALSE;

	public function __construct($id = FALSE)
	{
		parent::__construct($id);
	}

//	public function setDueDates($sd, $ed)
//	{
//		$next_due_dates = array();
////print $this;
////die ($sd . ' ' . $ed);
//		// initialize the offset
//		$offset = 0;
//		foreach ($this as $fc)
//		{
//			switch ($fc->every_unit)
//			{
//				case 'Days':
//					while (strtotime($sd . " +" . $offset . " Days") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Days") <= strtotime($fc->last_due_date)))
//					{
//						if (strtotime($sd . " +" . $offset . " Days") >= strtotime($sd))
//						{
//							$next_due_dates[] = date('Y-m-d', strtotime($sd . " +" . $offset . " Days"));
//						}
//						$offset += $fc->every;
//					}
//					$fc->next_due_dates = $next_due_dates;
//					break;
//				case 'Weeks':
//					while (strtotime($sd . " +" . $offset . " Weeks") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Weeks") <= strtotime($fc->last_due_date)))
//					{
//						if (strtotime($sd . " +" . $offset . " Weeks") >= strtotime($sd))
//						{
//							$next_due_dates[] = date('Y-m-d', strtotime($sd . " +" . $offset . " Weeks"));
//						}
//						$offset += $fc->every;;
//					}
//					$fc->next_due_dates = $next_due_dates;
//					break;
//				case 'Months':
//					$dt = explode('-', $sd);
//					$date = $dt[0] . '-' . $dt[1] . '-' . $fc->every_on;
//					while (strtotime($date . " +" . $offset . " Months") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Months") <= strtotime($fc->last_due_date)))
//					{
//						if (strtotime($date . " +" . $offset . " Months") > strtotime($sd))
//						{
//							$next_due_dates[] = date('Y-m-d', strtotime($date . " +" . $offset . " Months"));
//						}
//						$offset += $fc->every;
//					}
//					$fc->next_due_dates = $next_due_dates;
//					break;
//				case 'Years':
//					$dt = explode('-', $sd);
//					$date = $dt[0] . '-' . $fc->every_on;
//					while (strtotime($date . " +" . $offset . " Years") < strtotime($ed) && (!$fc->last_due_date || strtotime($sd . " +" . $offset . " Years") <= strtotime($fc->last_due_date)))
//					{
//						if (strtotime($date . " +" . $offset . " Years") > strtotime($sd))
//						{
//							$next_due_dates[] = date('Y-m-d', strtotime($date . " +" . $offset . " Years"));
//						}
//						$offset += $fc->every;
//					}
//					$fc->next_due_dates = $next_due_dates;
//					break;
//			}
//		}
//die('11111111111');
//	}

}

//EOF
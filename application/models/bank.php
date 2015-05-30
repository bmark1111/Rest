<?php
/*
 * bank.php
 * Brian Markham 04/09/2015
 *
*/
class bank extends Nagilum
{
	public $table = 'bank';

	public $hasMany = array('accounts' => array('class' => 'account', 'joinField' => 'bank_id')
						);

	public $autoPopulateHasOne = FALSE;
	public $autoPopulateHasMany = FALSE;

	public function __construct()
	{
		parent::__construct();
	}

}
//EOF
<?php
/*
 * category.php
 * Brian Markham 04/04/2015
 *
*/
class category extends Nagilum
{
	public $table = 'category';

	public $autoPopulateHasOne = FALSE;
	public $autoPopulateHasMany = FALSE;

	public function __construct()
	{
		parent::__construct();
	}

}
//EOF
<?php

class crystal_controller extends EP_Controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		$error = new AjaxError('This method is not available');

		$this->ajax->addError($error);
		$this->ajax->output();
	}

	public function retrieve()
	{
		$modelName = $this->input->post('model');
		$id = $this->input->post('id');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($id === FALSE)
		{
			$error = new AjaxError('You must specify the id for the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName($id);

		$output = array(
			'modelData' => $model,
		);
		$this->ajax->output($output);
	}

	public function getBy()
	{
		$modelName = $this->input->post('model');
		$fieldName = $this->input->post('field');
		$value = $this->input->post('value');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($fieldName === FALSE)
		{
			$error = new AjaxError('You must specify the field you are using to retrieve the model');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($value === FALSE)
		{
			$error = new AjaxError('You must specify a value to limit the results');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->getBy($fieldName, $value);

		$output = array(
			'modelData' => $model,
		);

		$this->ajax->output($output);
	}

	public function result()
	{
		$modelName = $this->input->post('model');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->result();

		$output = array(
			'modelData' => $model,
		);

		$this->ajax->output($output);
	}

	public function row()
	{
		$modelName = $this->input->post('model');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->row();

		$output = array(
			'modelData' => $model,
		);

		$this->ajax->output($output);
	}

	public function delete()
	{
		$modelName = $this->input->post('model');
		$id = $this->input->post('id');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you wish to use to delete');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($id === FALSE)
		{
			$error = new AjaxError('You must specify the id of the model you want to delete');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName($id);
		$model->delete();

		$this->ajax->output();
	}

	public function deleteAll()
	{
		$modelName = $this->input->post('model');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->result();
		$model->deleteAll();

		$this->ajax->output();
	}

	public function getPaged()
	{
		$modelName = $this->input->post('model');
		$page = $this->input->post('page');
		$pagesize = $this->input->post('pagesize');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($page === FALSE)
		{
			$error = new AjaxError('You must specify the page you wish to retrieve');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($pagesize === FALSE)
		{
			$error = new AjaxError('You must specify the page size you wish to retrieve');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->getPaged($page, $pagesize);

		$output = array(
			'modelData' => $model,
			'paged' => $model->paged,
		);

		$this->ajax->output($output);
	}

	public function hardDelete()
	{
		$modelName = $this->input->post('model');
		$id = $this->input->post('id');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you wish to use to delete');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($id === FALSE)
		{
			$error = new AjaxError('You must specify the id of the model you want to delete');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName($id);
		$model->hardDelete();

		$this->ajax->output();
	}

	public function hardDeleteAll()
	{
		$modelName = $this->input->post('model');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are retrieving');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$this->runCommands($model);
		$model->result();
		$model->hardDeleteAll();

		$this->ajax->output();
	}

	public function query()
	{
		$modelName = $this->input->post('model');
		$sql = $this->input->post('sql');
		$binds = $this->input->post('binds');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are using to run this query');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($sql === FALSE)
		{
			$error = new AjaxError('You must specify the query you wish to run');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$model->query($sql, $binds);

		$this->ajax->output();
	}

	public function queryAll()
	{
		$modelName = $this->input->post('model');
		$sql = $this->input->post('sql');
		$binds = $this->input->post('binds');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are using to run this query');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($sql === FALSE)
		{
			$error = new AjaxError('You must specify the query you wish to run');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$model->queryAll($sql, $binds);

		$this->ajax->output();
	}

	public function save()
	{
		$modelName = $this->input->post('model');
		$id = $this->input->post('id');
		$data = $this->input->post('data');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are using to run this query');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($id === FALSE)
		{
			$error = new AjaxError('You must specify the id for the model you wish to save');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($data === FALSE)
		{
			$error = new AjaxError('You must specify the data for the model you wish to save');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName($id);
		$this->setModelData($model, $data);
		$saved = $model->save();

		if(!$saved)
		{
			$isValid = $model->isValid();
			if(!$isValid)
			{
				$validationErrors = $model->getAjaxValidationErrors();
				if(count($validationErrors))
				{
					$this->ajax->validations($validationErrors);
					$this->ajax->output();
				}
			}
			$error = new AjaxError('Could not save the model');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$output = array('modelData' => $model);

		$this->ajax->output($output);
	}

	private function setModelData($model, $data)
	{
		foreach($data as $key => $value)
		{
			$model->$key = $value;
		}
	}

	public function fieldExists()
	{
		$modelName = $this->input->post('model');
		$field = $this->input->post('field');

		if($modelName === FALSE)
		{
			$error = new AjaxError('You must specify the model you are checking the field on');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		if($field === FALSE)
		{
			$error = new AjaxError('You must specify the field you\'re checking');
			$this->ajax->addError($error);
			$this->ajax->output();
		}

		$model = new $modelName();
		$exists = $model->fieldExists($field);

		$output = array('fieldExists' => $exists);
		$this->ajax->output($output);
	}

	private function runCommands($model)
	{
		$commands = $this->input->post('nagilum');

		foreach($commands as $command)
		{
			foreach($command as $com => $params)
			{
				$this->$com($model, $params);
			}
		}
	}

	private function distinct($model, $params)
	{
		extract($params);

		$model->distinct();
	}

	private function groupBy($model, $params)
	{
		extract($params);

		$model->groupBy($field);
	}

	private function groupEnd($model, $params)
	{
		extract($params);

		$model->groupEnd();
	}

	private function groupStart($model, $params)
	{
		extract($params);

		$model->groupStart();
	}

	private function having($model, $params)
	{
		extract($params);

		if($escape === 'false')
		{
			$escape = FALSE;
		}

		$model->having($key, $value, $escape);
	}

	private function iLike($model, $params)
	{
		extract($params);

		$model->iLike($field, $match, $side);
	}

	private function join($model, $params)
	{
		extract($params);

		$model->join($table, $condition, $type);
	}

	private function like($model, $params)
	{
		extract($params);

		$model->like($field, $match, $side);
	}

	private function limit($model, $params)
	{
		extract($params);

		$model->limit($value, $offset);
	}

	private function notGroupStart($model, $params)
	{
		extract($params);

		$model->notGroupStart();
	}

	private function notILike($model, $params)
	{
		extract($params);

		$model->notILike($field, $match, $side);
	}

	private function notLike($model, $params)
	{
		extract($params);

		$model->notLike($field, $match, $side);
	}

	private function orGroupStart($model, $params)
	{
		extract($params);

		$model->orGroupStart();
	}

	private function orHaving($model, $params)
	{
		extract($params);

		if($escape === 'false')
		{
			$escape = FALSE;
		}

		$model->orHaving($key, $value, $escape);
	}

	private function orILike($model, $params)
	{
		extract($params);

		$model->orILike($field, $match, $side);
	}

	private function orLike($model, $params)
	{
		extract($params);

		$model->orLike($field, $match, $side);
	}

	private function orNotGroupStart($model)
	{
		extract($params);

		$model->orNotGroupStart();
	}

	private function orNotILike($model, $params)
	{
		extract($params);

		$model->orNotILike($field, $match, $side);
	}

	private function orNotLike($model, $params)
	{
		extract($params);

		$model->orNotLike($field, $match, $side);
	}

	private function orWhere($model, $params)
	{
		extract($params);

		if($escape === 'false')
		{
			$escape = FALSE;
		}

		$model->orWhere($key, $value, $escape);
	}

	private function orWhereIn($model, $params)
	{
		extract($params);

		$model->orWhereIn($key, $values);
	}

	private function orWhereNotIn($model, $params)
	{
		extract($params);

		$model->orWhereNotIn($key, $values);
	}

	private function orderBy($model, $params)
	{
		extract($params);

		$model->orderBy($orderBy, $direction);
	}

	private function select($model, $params)
	{
		extract($params);

		if($escape === 'false')
		{
			$escape = FALSE;
		}

		$model->select($select, $escape);
	}

	private function selectAvg($model, $params)
	{
		extract($params);

		$model->selectAvg($select, $alias);
	}

	private function selectMax($model, $params)
	{
		extract($params);

		$model->selectMax($select, $alias);
	}

	private function selectMin($model, $params)
	{
		extract($params);

		$model->selectMin($select, $alias);
	}

	private function selectSum($model, $params)
	{
		extract($params);

		$model->selectSum($select, $alias);
	}

	private function setAutoPopulateHasMany($model, $params)
	{
		extract($params);

		if($bool === 'false')
		{
			$bool = FALSE;
		}

		$model->autoPopulateHasMany = $bool;
	}

	private function setAutoPopulateHasOne($model, $params)
	{
		extract($params);

		if($bool === 'false')
		{
			$bool = FALSE;
		}

		$model->autoPopulateHasOne = $bool;
	}

	private function skipValidation($model, $params)
	{
		extract($params);

		if($bool === 'false')
		{
			$bool = FALSE;
		}

		$model->skipValidation = $bool;
	}

	private function where($model, $params)
	{
		extract($params);

		if($escape === 'false')
		{
			$escape = FALSE;
		}

		$model->where($key, $value, $escape);
	}

	private function whereIn($model, $params)
	{
		extract($params);

		$model->whereIn($key, $values);
	}

	private function whereNotDeleted($model, $params)
	{
		extract($params);

		$model->whereNotDeleted();
	}

	private function whereNotIn($model, $params)
	{
		extract($params);

		$model->whereNotIn($key, $values);
	}
}
// EOF
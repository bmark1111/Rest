<!DOCTYPE html>
<html>
<head>
	<title>Helix CSR Search</title>
	<meta name="viewport" content="width=device-width, user-scalable=no">
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
	<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" />
	<link type="text/css" rel="stylesheet" href="/css/style.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function()
	{
		var firstname = getCookie('FIRSTNAME')
		var dept = getCookie('DEPT')
		$('#header div.welcome-user').find('p').text(firstname + ' ' + dept);

		pagination_start = 0;
		pagination_amount = 15;

		getNext();

		$('input.search').on('keyup',
			function(event)
			{
				var searchText			= $.trim($(this).val());
				var inputLength			= $(this).data('length');
				var isWordCharacter		= String.fromCharCode(event.keyCode).match(/\w/);
				var isBackspaceOrDelete	= (event.keyCode == 8 || event.keyCode == 46);

				// trigger only on word characters, backspace or delete and an entry size of at least inputLength characters
				if(((isWordCharacter || isBackspaceOrDelete) && searchText.length >= inputLength)
							||
					(isBackspaceOrDelete && searchText.length < inputLength))
				{
					getNext();
				}
			});
	});

	function getNext()
	{
		var inputs = Array();
		$('form input.search').each(
			function()
			{
				if (typeof($(this).data('length')) == 'undefined' || $(this).data('length') <= $(this).val().length)
				{
					inputs[$(this).attr('name')] = $(this).val();
				} else {
					inputs[$(this).attr('name')] = '';
				}
			});

		var postData = {};
		for (key in inputs)
		{
			postData[key] = inputs[key];
		};
		postData.pagination_start = pagination_start;
		postData.pagination_amount = pagination_amount;

		$.ajax({
			type:		"GET",
			url:		"test/search",
			headers:	{
							"Authorization":	"Basic cHJvb3ZlYmlvOlByb292ZTIwMTQ=",
							"SESSIONID":		"04b71978a1bf4368a176f519faded7eff7c05febf8e74f6cb732f1e43adfbc1a"
						},
			data:		postData,
			success:	function(json)
						{
							if (json.success == 1)
							{
								if (pagination_start <= 45)
								{
									page_start = 1;
									page_end = 5;
								} else {
									page_start = parseInt(pagination_start / pagination_amount);
									page_end = page_start + 4;
								}
								var selected_page = parseInt(pagination_start / pagination_amount) + 1;
								$('ul.pagination').empty();
								$('ul.pagination').append('<li><a class="paginate" data-page="1"><<</a></li>');
								for (i = page_start; i <= page_end; i++)
								{
									if (selected_page == i)
									{
										var active = 'active';
									} else {
										active = '';
									}
									$('ul.pagination').append('<li class="' + active + '"><a class="paginate" data-page="' + i + '">' + i + '</a></li>');
								}
								$('ul.pagination').append('<li><a class="paginate" data-page="55">>></a></li>');

								$('.paginate').click(
									function()
									{
										pagination_start = parseInt(($(this).data('page') - 1) * pagination_amount)
										getNext();
									});

								$('#test_list td').empty();
								if (json.data.result)
								{
									$.each(json.data.result,
										function(index, test)
										{
											var row = $('#test_list tr').eq(index);
											var name = test.patient[0].first_name + ' ' + test.patient[0].last_name;
											row.find('td.company_name').text(test.account[0].company_name);
											row.find('td.patient_name').text(name);
											row.find('td.birth_date').text(test.patient[0].birth_date);
											row.find('td.dos').text(test.encounter.encounter_datetime);
											row.find('td.sample_id').text(test.sample[0].external_sample_id);
											row.find('td.received_datetime').text(test.sample[0].received_datetime);
											row.find('td.test_type').text(test.test_type_id);
											row.find('td.test_status').text(test.test_status_desc);
										});
								}
							} else {
								alert(json.errors[0].error);
							}
						},
			dataType:	'json'
		});
	};

	function getCookie(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for(var i=0; i<ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1);
			if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
		}
		return "";
	};
	</script>
</head>
<body>
	<div id="mainWrapper">
		<header id="header">
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" data-action="/"><img class="logo"
						src="/imgs/helix_part_l.png" alt="ProoveBio Helix"></a>
				</div>
		
				<div class="collapse navbar-collapse">
					<div id="menu">
						<ul class="nav navbar-nav">
<!--						    <li><a data-action="intake"><span class="fa fa-inbox"></span>&nbsp;Intake</a></li>
						    <li><a data-action="lab"><span class="fa fa-flask"></span>&nbsp;Lab</a></li>
						    <li><a data-action="processing"><span class="fa fa-flag"></span>&nbsp;Processing</a></li>
						    <li><a data-action="billing"><span class="fa fa-bank"></span>&nbsp;Billing</a></li>
						    <li><a data-action="csr"><span class="fa fa-user"></span>&nbsp;CSR</a></li>-->
						    <li><a href="/csr"><span class="fa fa-user"></span>&nbsp;CSR</a></li>
						</ul>
					</div>
					<div class="welcome-user pull-right">
						<div class="user-icon"></div>
						<p>{{name}}</p>
					</div>
				</div>
				
			</div>
		</nav>
		</header>
		<!--<nav>
			<div class="navbar navbar-default navbar-fixed-top">
				<div class="logo pull-left">
					<img src="/imgs/helix_part_l.png" alt="Helix" style="width: 50px;" />
				</div>
				<div class="csr-return pull-left">
					<a href="csr"><span class="fa fa-arrow-left"></span> Return to CSR</a>
				</div>
			</div>
		</nav>-->
		<div class="sub-head">
			<div class="row">
				<div class="col-xs-2">
					<h2>
						<span class="fa fa-group"></span> CSR / Patients
					</h2>
				</div>
				<div class="col-xs-6">
				</div>
				<div class="col-xs-4">
				</div>
			</div>
		</div>
		<div class="container">
			<div class="search-content">
				<div class="patient-input">
					<div class="row">
						<div class="col-sm-12">
							<div class="row">
								<div class="col-sm-12">
									<div class="section-title">
										<div class="section-title-container pull-left">
											<h3><span class="fa fa-search results-icon"></span>CSR Patient Search</h3>
										</div>
										<div class="status-container pull-right">
										</div>
									</div>
								</div>
							</div> <!--// End Search Header //-->
							<div class="form-wrap-search">
								<form>
									<input type="hidden" class="search" name="sort" value="created_datetime" />
									<input type="hidden" class="search" name="sort_dir" value="DESC" />
									<input type="hidden" class="search" name="join" value="Account" />

									<div class="row">
										<div class="col-sm-3">
											<div class="form-group">
												<label for="ssn">Account Name</label>
												<input type="text" class="form-control input-sm search" name="account_name" data-length="4" />
											</div>
										</div>
										<div class="col-sm-3">
											<div class="form-group">
												<label for="lastname">Patient Last Name</label>
												<input type="text" class="form-control input-sm search" name="patient_last_name" data-length="4" />
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label for="firstname">Patient ID</label>
												<input type="text" class="form-control input-sm search" name="ext_patient_id" data-length="4" />
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label for="ssn">Date of Birth</label>
												<input type="text" class="form-control input-sm search" name="patient_dob" data-length="6" />
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label for="ssn">Sample ID</label>
												<input type="text" class="form-control input-sm search" name="ext_sample_id" data-length="4" />
											</div>
										</div>
									</div><!--// End Search Fields //-->
								</form>
<!--								<div class="row">
									<div class="col-sm-12">
										<div class="sub-section-title">
											<h4>Search Results</h4>
										</div>
									</div>
								</div>// End Search Results Header//-->
								<div class="row">
									<div class="col-sm-12">
										<table class="table table-bordered table-striped table-hover table-reponsive results-table">
											<thead>
												<tr>
													<th>Account</th>
													<th>Patient</th>
													<th>DOB</th>
													<th>Date Received</th>
													<th class="hidden-md hidden-sm hidden-xs">DOS</th>
													<th class="hidden-md hidden-sm hidden-xs">Sample ID</th>
													<th class="hidden-md hidden-sm hidden-xs">Test Type</th>
													<th class="hidden-md hidden-sm hidden-xs">Status</th>
												</tr>
											</thead>
											<tbody id="test_list">
												<?php
												for ($x = 0; $x < 15; $x++)
												{
													?>
													<tr>
														<td class="company_name"> </td>
														<td class="patient_name"> </td>
														<td class="birth_date"> </td>
														<td class="received_datetime"> </td>
														<td class="hidden-md hidden-sm hidden-xs dos"> </td>
														<td class="hidden-md hidden-sm hidden-xs sample_id"> </td>
														<td class="hidden-md hidden-sm hidden-xs test_type"> </td>
														<td class="hidden-md hidden-sm hidden-xs test_status"> </td>
													</tr>
													<?php
												}
												?>
											</tbody>
										</table>
									</div>
								</div><!--// End Search Results //-->
								<div class="row">
									<div class="col-sm-12 pagination-wrap">
										<ul class="pagination">
<!--										  <li class="active"><a class="paginate" data-page="1">1</a></li>
										  <li><a class="paginate" data-page="2">2</a></li>
										  <li><a class="paginate" data-page="3">3</a></li>-->
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<footer id="footer">
			<div class="panel-footer navbar-fixed-bottom">
				<p>ProoveBio Copyright <span class="glyphicon glyphicon-copyright-mark"></span> 2014</p>
			</div>
		</footer>
	</div>
</body>
</html>
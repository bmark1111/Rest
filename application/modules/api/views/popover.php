<div class="table-responsive">
<table>
	<thead>
		<tr>
			<th>Date</th>
			<th>Description</th>
			<th>Type</th>
			<th>Amount</th>
		</tr>
	</thead>
	<tbody>
		<?php
		foreach ($transactions as $transaction)
		{
			?>
			<tr>
				<td><span class="pull-left"><?php echo $transaction['transaction_date']; ?></span></td>
				<td><?php echo $transaction['description']; echo ($transaction['notes']) ? ' - ' . $transaction['notes']: ''; ?></span></td>
				<td><?php echo $transaction['type']; ?></td>
				<td><?php echo $transaction['amount']; ?></td>
			</tr>
			<?php
		}
		?>
	</tbody>
</table>
</div>

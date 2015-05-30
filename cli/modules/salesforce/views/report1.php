<table border="1">
	<?php
	if (!empty($dataOut))
	{
		?><tr><?php
		foreach ($dataOut as $title => $data)
		{
			?><th style="width:60px;height:60px;color:red;"><?php echo date('M', strtotime($title)); ?></th><?php
		}
		?></tr><tr><?php
		foreach ($dataOut as $title => $data)
		{
			?><td><?php echo $data; ?></td><?php
		}
		?></tr><?php
	}
	?>
</table>


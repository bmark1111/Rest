<table border="1">
	<?php
	if (!empty($dataOut))
	{
		foreach ($dataOut as $data)
		{
			?><tr><td><?php echo $data; ?></td></tr><?php
		}
	}
	?>
</table>


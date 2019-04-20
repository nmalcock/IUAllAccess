<?php
if (($handle = fopen("Baseschedule.csv", "r")) == !FALSE)
{
	while (($data = fgetcsv($handle, 1000, ",")) == !FALSE)
	{
		$sql ="UPDATE BSschedule (home_score, away_score, w_L, box_score_link) SET home_score = '".$data[3]."', away_score = '".$data[4]."', w_L = '".$data[6]."', box_score_link = '".$data[7]."' 
		WHERE opponent = '".$data[0]."' AND date_time = '".$data[1]."'";
		mysql_query($sql) or die(mysql_error());
	}
	fclose($handle);
}
?>
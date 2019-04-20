<?php
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno()) 
{
	echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); 
	}

	$sql = "SELECT email FROM user WHERE gameReminder = 1";
	$result = $conn->query($sql);
	
		}
mysql_close($con);
?>
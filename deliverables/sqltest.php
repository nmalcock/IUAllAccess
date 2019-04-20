<?php
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno()) 
{
	echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); 
}

$sql = "SELECT email FROM user WHERE gameReminder = 1";
$result = $conn->query($sql);
// not printing result, SQL statement is correct
//echo mysql_num_rows($result);
if ($result->num_rows > 0) {
		$resultArray = array();
		while($row = $result->fetch_assoc()) {
			//$results[] = $row
			$tempArray = array();
			$tempArray = $row;
			array_push($resultArray, $tempArray);
			//echo $output;
			}
		echo json_encode($resultArray);
		//echo $resultArray;
	}else {
		echo 'it didnt work';
	}

	//echo $output;

mysql_close($conn);
?>
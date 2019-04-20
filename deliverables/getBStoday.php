<?php
// Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
 //echo ("Established Database Connection \n");
/*
//$output = array();
if($_SERVER['REQUEST_METHOD']=='POST'){

	$teamid = $_POST['teamid'];
	
	if (!isset($_POST['teamid'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	}

	else {*/
	$sql = "SELECT opponent, DATE_FORMAT(date_time, '%m-%d-%y') AS Baseball FROM BSschedule WHERE DATE_FORMAT(date_time, '%y-%m-%d')= CURDATE()";
	$result = $conn->query($sql);
	if ($result->num_rows > 0) {
		$resultArray = array();
		while($row = $result->fetch_assoc()) {
			$tempArray = array();
			$tempArray = $row;
			array_push($resultArray, $tempArray);
			//echo $output;
			}
		echo json_encode($resultArray);
		//echo $resultArray;
	}else {
		echo json_encode([
		"{Message" => "No Games Today}"
		]);
	}

	//echo $output;
	$conn->close();
?>

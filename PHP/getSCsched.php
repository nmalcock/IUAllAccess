<?php
// Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
else
{ /* //echo ("Established Database Connection \n");
}
if($_SERVER['REQUEST_METHOD']=='POST'){

	$teamid = $_POST['teamid'];
	
	if (!isset($_POST['teamid'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	}
 
	else {*/
	$sql = "SELECT opponent,date_time,site,home_score,away_score,bTenOpp,w_L,teamID FROM SCschedule;";
	$result = $conn->query($sql);

	if ($result->num_rows > 0) {
		$resultArray = array();
		$tempArray = array();
		while($row = $result->fetch_assoc()) {
			$tempArray = $row;
			array_push($resultArray, $tempArray);
		}
		echo json_encode($resultArray);
	}else {
		echo "0 results";
	}

	$conn->close();
}


?>
<?php
// Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
else
{ //echo ("Established Database Connection \n");
}
//$output = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

	$teamid = $_POST['teamid'];
	
	if (!isset($_POST['teamid'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	}

	echo $teamid;
	else {
		if ($teamid = 1) {
			$sql = "SELECT fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM athlete WHERE teamID = 1;";
		} elseif ($teamid = 2) {
			$sql = "SELECT fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM athlete WHERE teamID = 2;";
		} elseif ($teamid = 3) {
			$sql = "SELECT fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM athlete WHERE teamID = 3;";
		} elseif ($teamid = 4) {
			$sql = "SELECT fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM athlete WHERE teamID = 4;";
		}
	
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
			echo "0 results";
		}

		//echo $output;
		$conn->close();
	}
}
?>
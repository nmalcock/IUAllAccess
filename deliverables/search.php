<?php
 // Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
	{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
else {
	
	if($_SERVER['REQUEST_METHOD']=='POST'){
		
		$input =  $_POST['input'];
		//$fname = $_POST['fname'];
		//$lname = $_POST['lname'];
		
		$searchArray = ARRAY();
		if (empty($_POST['input'])) {
			$searchArray['status'] = 'Input a Name';
		} else {
			$sql = "SELECT BBathleteID AS athleteID, fname, lname, image_path, teamID FROM BBathlete WHERE fname LIKE '%" . $input . "%' OR lname LIKE '%" . $input . "%';";
			$result = $conn->query($sql);
			if ($result->num_rows > 0) {
				while($row = $result->fetch_assoc()) {
					$tempArray = array();
					$tempArray = $row;
					array_push($searchArray, $tempArray);
				}
		
			}
			$sql2 = "SELECT FBathleteID AS athleteID, fname, lname, image_path, teamID FROM FBathlete WHERE fname LIKE '%" . $input . "%' OR lname LIKE '%" . $input . "%';";
			$result = $conn->query($sql2);
			if ($result->num_rows > 0) {
				while($row = $result->fetch_assoc()) {
					$tempArray = array();
					$tempArray = $row;
					array_push($searchArray, $tempArray);
				}
		
			}
			$sql2 = "SELECT BSathleteID AS athleteID, fname, lname, image_path,teamID FROM BSathlete WHERE fname LIKE '%" . $input . "%' OR lname LIKE '%" . $input . "%';";
			$result = $conn->query($sql2);
			if ($result->num_rows > 0) {
				while($row = $result->fetch_assoc()) {
					$tempArray = array();
					$tempArray = $row;
					array_push($searchArray, $tempArray);
				}
		
			}
			$sql2 = "SELECT SCathleteID AS athleteID, fname, lname, image_path, teamID FROM SCathlete WHERE fname LIKE '%" . $input . "%' OR lname LIKE '%" . $input . "%';";
			$result = $conn->query($sql2);
			if ($result->num_rows > 0) {
				while($row = $result->fetch_assoc()) {
					$tempArray = array();
					$tempArray = $row;
					array_push($searchArray, $tempArray);
				}
		
			}
			if (empty($searchArray)) {
				$searchArray['status'] = 'No Results';
			}
			echo json_encode($searchArray);
		}
	}
}

?>
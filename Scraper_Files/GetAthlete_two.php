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
	
	if ($teamid = 2) {
		$sql = "SELECT fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM athlete_two WHERE teamID = 2;";
	}
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
?>

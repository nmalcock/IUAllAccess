<?php
 // Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
	{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
else {
 //echo ("Established Database Connection \n");

//$output = array(); 
/* session_start();
if (!isset($_SESSION['userid'])){
	header("Location: login.php");
} */

//echo $_SESSION['userID'];

	if($_SERVER['REQUEST_METHOD']=='POST'){

		$userID = $_POST['userID'];
		
		if (!isset($_POST['userID'])) {
			$response['error1'] = true;
			$response['message1'] = "variable is not set or is NULL";
			
		} else {
			
	//		require_once 'DbOperation.php';
			
	//		$db = new DbOperation();
			
	//		$stmt = $db->getFavorite($userid);
	//		echo $stmt;
			
			$sql = "SELECT * FROM userFavorites WHERE userID='$userID';";
			$result = $conn->query($sql);

			if ($result->num_rows > 0) {
				$resultArray = array();
				while($row = $result->fetch_assoc()) {
					$tempArray = array();
					$tempArray = $row;
					foreach ($tempArray as $key => $val) {
						if ($val != Null) {
							if ($key == "BBathleteID") {
								$playerArray = array();
								//$search = $val;
								$sql2 = "SELECT BBathleteID AS athleteID, fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM BBathlete WHERE BBathleteID='$val';";
								$playerRow = $conn->query($sql2);
								$player = $playerRow->fetch_assoc();
								$playerArray = $player;
								array_push($resultArray, $playerArray);
							} elseif ($key == "FBathleteID") {
								$playerArray = array();
								//$search = $val;
								$sql2 = "SELECT FBathleteID AS athleteID, fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM FBathlete WHERE FBathleteID='$val';";
								$playerRow = $conn->query($sql2);
								$player = $playerRow->fetch_assoc();
								$playerArray = $player;
								array_push($resultArray, $playerArray);
							} elseif ($key == "BSathleteID") {
								$playerArray = array();
								//$search = $val;
								$sql2 = "SELECT BSathleteID AS athleteID, fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM BSathlete WHERE BSathleteID='$val';";
								$playerRow = $conn->query($sql2);
								$player = $playerRow->fetch_assoc();
								$playerArray = $player;
								array_push($resultArray, $playerArray);
							} elseif ($key == "SCathleteID") {
								$playerArray = array();
								//$search = $val;
								$sql2 = "SELECT SCathleteID AS athleteID, fname, lname, number, position, year, height, weight, hometown, highschool, image_path, teamID FROM SCathlete WHERE SCathleteID='$val';";
								$playerRow = $conn->query($sql2);
								$player = $playerRow->fetch_assoc();
								$playerArray = $player;
								array_push($resultArray, $playerArray);
							}
						}
					}
					//echo $output;
					}
				echo json_encode($resultArray);
				//echo $resultArray;
				//echo $userID;
			}else {
				echo "0 results";
			}

			//echo $output;
			$conn->close();
			}
}

//}
}
?>
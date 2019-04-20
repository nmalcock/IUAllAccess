<?php
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
	{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }
else {
	if($_SERVER['REQUEST_METHOD']=='POST'){

		$userID = $_POST['userID'];
		//$gameReminder = $_POST['gameReminder'];
		//$statUpdate = $_POST['statUpdate'];
		
		$sql = ("SELECT gameReminder, statUpdate FROM user WHERE userID='$userID';");
		$result = $conn->query($sql);
		
		if ($result->num_rows > 0) {
			$resultArray = array();
			while($row = $result->fetch_assoc()) {
				//if ($row[0]=0 AND $row[1]=0) {
				$tempArray = array();
				$tempArray = $row;
				//$tempArray = {"gameReminder":"No","statUpdate":"No"};
				if ($tempArray["gameReminder"]=="0" AND $tempArray["statUpdate"]=="0") {
					$array1 = [
						"gameReminder" => "No",
						"statUpdate" => "No",
						];
					array_push($resultArray, $array1);
				}
				else if ($tempArray["gameReminder"]=="1" AND $tempArray["statUpdate"]=="0") {
					$array1 = [
						"gameReminder" => "Yes",
						"statUpdate" => "No",
						];
					array_push($resultArray, $array1);
				}
				else if ($tempArray["gameReminder"]=="0" AND $tempArray["statUpdate"]=="1") {
					$array1 = [
						"gameReminder" => "No",
						"statUpdate" => "Yes",
						];
					array_push($resultArray, $array1);
				}
				else if ($tempArray["gameReminder"]=="1" AND $tempArray["statUpdate"]=="1") {
					$array1 = [
						"gameReminder" => "Yes",
						"statUpdate" => "Yes",
						];
					array_push($resultArray, $array1);
				}
		//echo $output;
			}
			echo json_encode($resultArray);
		}else {
			echo "0 results";
		}

//echo $output;
	$conn->close();

		} 
}


?>
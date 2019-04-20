<?php
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno()) 
{
	echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); 
}


$sql2 = "SELECT opponent, DATE_FORMAT(date_time, '%m-%d-%y') AS Baseball FROM BSschedule WHERE DATE_FORMAT(date_time, '%y-%m-%d')= CURDATE()";
$result2 = $conn->query($sql2);
	if ($result2->num_rows > 0) {
		$resultArray = array();
		while($row2 = $result2->fetch_assoc()) {
			$tempArray = array();
			$tempArray = $row2;
			array_push($resultArray, $tempArray);
			//echo $output;
			}
		echo json_encode($resultArray);
		//echo $resultArray;
	}else {
		echo json_encode([
		"Message" => "No Games Today"
		]);
	}
	//

		//echo $result2
$sql = "SELECT email FROM user WHERE gameReminder = 1";
$result = $conn->query($sql);
		// not printing result, SQL statement is correct
		//echo mysql_num_rows($result);

/*if ($result->num_rows > 0)*/ 
$recipients = array();
while($row = $result->fetch_assoc())
	{
		$recipients[] = $row['email'];
		
		/*$tempArray = array();
		$tempArray = $row;
		array_push($to, $tempArray);
		*/
	}
//
//echo $resultArray
//echo $to;
$to = implode(",", $recipients);
//define the subject of the email
$subject = 'Game Today'; 
//define the message to be sent. Each line should be separated with \n
/*if (empty($resultArray)){
	$message = "No games today!";
} else {
	*/
$message = "Hello!\n\nCheck IU All Access for today's games!.";
//define the headers we want passed. Note that they are separated with \r\n
$headers = "From: jtmilhouse19@gmail.com\r\nReply-To: jtmilhouse19@gmail.com";
//send the email
if (!empty($resultArray)){
	mail($to, $subject, $message, $headers);
} else {
	echo "No games today";
}
//echo "Mail sent ";
//echo 'Mail could not be sent';

mysql_close($conn);
?>
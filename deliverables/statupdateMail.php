<?php
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno()) 
{
	echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); 
}


$sql = "SELECT u.email 
FROM user AS u, userFavorites AS us, BSschedule AS bs, BSathlete AS ba 
WHERE u.userID = us.userID AND us.BSathleteID = ba.BSathleteID AND ba.teamID = us.teamID AND DATE_FORMAT(bs.date_time, '%y-%m-%d') = CURDATE() AND u.statUpdate = 1";
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
//echo $resultArray
//echo $to;
$to = implode(",", $recipients);
//define the subject of the email
$subject = 'Game Today'; 
//define the message to be sent. Each line should be separated with \n
$message = "Hello!\n\nCheck IU All Access for updated stats!."; 
//define the headers we want passed. Note that they are separated with \r\n
$headers = "From: jtmilhouse19@gmail.com\r\nReply-To: jtmilhouse19@gmail.com";
//send the email
if (!empty($recipients)){
	mail($to, $subject, $message, $headers);
} else {
	echo "No favorite athlete stats to update today";
}
//echo "Mail sent ";
//echo 'Mail could not be sent';

mysql_close($conn);
?>
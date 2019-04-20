<?php
// Create connection
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58", "i494f18_team58");

if (mysqli_connect_errno())
{echo ("Failed to connect to MySQL: " . mysqli_connect_error() . "\n "); }

$sql = "DELETE FROM BSschedule";
$result = $conn->query($sql);
if ($result == TRUE) {
	echo "Records deleted";
} else {
	echo "error deleting records";
}
$conn->close();

?>
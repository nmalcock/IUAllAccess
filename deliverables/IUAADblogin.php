<?php
		
	$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team58","my+sql=i494f18_team58","i494f18_team58");

	if (!$conn) {
    echo nl2br("Connection failed: " . mysqli_connect_error());
} else {
	echo nl2br("Established Database Connection");
} 
	$var_email = mysqli_real_escape_string($conn,$_POST['email']);
	$var_username = mysqli_real_escape_string($conn, $_POST['username']);
	$var_password = mysqli_real_escape_string($conn, $_POST['password']);
	$sql = "INSERT INTO user (email, username, password)
	VALUES ('$var_email', '$var_username', '$var_password');"
	$result = mysqli_query($mysqli,$query);
	if (!mysqli_query($conn, $sql))
	{ die('Error: ' . mysqli_error($conn)); }
	else
	{echo "User data saved" ;}
mysqli_close($conn);
?>
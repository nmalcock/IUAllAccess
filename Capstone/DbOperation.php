<?php

class DbOperation
{
	private $conn;
	
	//Constructor
	function __construct()
	{
		require_once dirname(__FILE__) . '/Config.php';
		require_once dirname(__FILE__) . '/DbConnect.php';
		// opening DB connection
		$db = new DbConnect();
		$this->conn = $db->connect();
	}
	
//Function Creating New User	
public function createUser($username, $password)
{
	$stmt = $this->conn->prepare("INSERT INTO user(email, username, password) values(?, ?, ?)");
	$stmt->bind_param("si", $email, $username, $password);
	$result = $stmt->execute();
	$stmt->close();
	if ($result) {
		return true;
	} else {
		return false;
	}
}
}		
?>

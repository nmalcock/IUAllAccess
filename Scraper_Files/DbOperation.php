<?php

class DbOperation
{
	private $conn;
	
	//Constructor
	function __construct()
	{
		require_once 'config.php';
		require_once 'Dbconnect.php';
		// opening DB connection
		$db = new DbConnect();
		$this->conn = $db->connect();
		if (mysqli_connect_errno())
		{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}
	}

	//Function Creating New User	
	public function createUser($email, $password)
	{
		$stmt = $this->conn->prepare("INSERT INTO user(email, password) VALUES (?, ?);");
		$stmt->bind_param("ss", $email, $password);
		$result = $stmt->execute();
		$stmt->close();
		if ($result) {
			return true;
		} else {
			return false;
		}
	/* 	if (!$this->isUserExist($email, $username)) {
		$stmt = $this->conn->prepare("INSERT INTO user(email, username, password) values(?, ?, ?)");
		$stmt->bind_param("sss", $email, $username, $password);
		if ($stmt->execute()) {
			return USER_CREATED;
		} else {
			return USER_NOT_CREATED;
	} else {
		return USER_EXISTS;
	}	 */
	}

	//Function Login
	public function userLogin($email, $password)
	{
		$stmt = $this->conn->prepare("SELECT userID FROM user WHERE email = ? AND password = ?");
		$stmt->bind_param("ss", $email, $password);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}

	public function getUserByEmail($email)
	{
		$stmt = $this->conn->prepare("SELECT userID, email FROM user WHERE email = ?");
		$stmt->bind_param("s", $email);
		$stmt->execute();
		$stmt->bind_result($id, $Email);
		$stmt->fetch();
		$user = array();
		$user['userID'] = $id;
		$user['email'] = $Email;
		return $user;
	}
	
	private function isUserExist($email,$username)
	{
		$stmt = $this->conn->prepare("SELECT userID FROM user WHERE email = ?");
		$stmt->bind_param("s",$email);
		$stmt->execute();
		$stmt->store_result();
		return $stmt->num_rows > 0;
	}
}
?>

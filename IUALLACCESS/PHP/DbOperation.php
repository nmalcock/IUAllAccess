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
	}

	//Function Creating New User	
	public function createUser($email, $password)
	{
		$encPswd = password_hash($password, PASSWORD_DEFAULT);
		if (($this->isUserExist($email)) == false){
			$stmt = $this->conn->prepare("INSERT INTO user(email, password) VALUES (?, ?);");
			$stmt->bind_param("ss", $email, $encPswd);
			if ($stmt->execute()) {
				return 'USER_CREATED';
			} else {
				return 'USER_NOT_CREATED';
			}
		} else {
			return 'USER_ALREADY_EXIST';
		}
	}
	

	//Function Login
	public function userLogin($email, $pass)
	{
		if (($this->isUserExist($email)) == true){
			$stmt = $this->conn->prepare("SELECT password FROM user WHERE email = ?;");
			$stmt->bind_param("s", $email);
			$stmt->execute();
			$stmt->store_result();
			$stmt->bind_result($password);
			//while ($row = $result->fetch_assoc()) {
			//$result = $stmt->get_result();
			if ($stmt->num_rows == 1) {
				while ($stmt->fetch()) {
/* 					echo $password;
					echo " SPACEHERE ";
					echo password_hash($pass,PASSWORD_DEFAULT); */
					if (password_verify($pass, $password)){ 
						return "CORRECT_PASSWORD";
					} else {
						return "INCORRECT PASSWORD";
					}
				}
			}
		} else {
			return 'INVALID_EMAIL';
		}
	}

	//Retrives all User Data
	public function getUserByEmail($email)
	{
		$stmt = $this->conn->prepare("SELECT userID, email, finalScore, gameReminder, statUpdate, gameStart FROM user WHERE email = ?;");
		$stmt->bind_param("s", $email);
		$stmt->execute();
		$stmt->bind_result($userID, $email, $finalScore, $gameReminder, $statUpdate, $gameStart);
		$stmt->fetch();
		$user = array();
		$user['userID'] = $userID;
		$user['email'] = $email;
		$user['Final-Score'] = $finalScore;
		$user['Game-Reminder'] = $gameReminder;
		$user['Stat-Update'] = $statUpdate;
		$user['Game-Start'] = $gameStart;
		return $user;
	}
	 

	//Checks if User Exists
	private function isUserExist($email)
	{
		$stmt = $this->conn->prepare("SELECT email FROM user WHERE email = ?;");
		$stmt->bind_param("s",$email);
		$stmt->execute();
		$stmt->store_result();
		$row_count = $stmt->num_rows;
		return $row_count == 1;
	} 
}
?>

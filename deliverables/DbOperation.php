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
			if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
				$stmt = $this->conn->prepare("INSERT INTO user(email, password) VALUES (?, ?);");
				$stmt->bind_param("ss", $email, $encPswd);
				if ($stmt->execute()) {
					return 'USER_CREATED';
				} else {
					return 'USER_NOT_CREATED';
				}
			} else {
				return 'EMAIL_NOT_VALID';
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
		$stmt = $this->conn->prepare("SELECT userID, email, gameReminder, statUpdate FROM user WHERE email = ?;");
		$stmt->bind_param("s", $email);
		$stmt->execute();
		$stmt->bind_result($userID, $email, $gameReminder, $statUpdate);
		$stmt->fetch();
		$user = array();
		$user['userID'] = $userID;
		$user['email'] = $email;
		$user['Game-Reminder'] = $gameReminder;
		$user['Stat-Update'] = $statUpdate;
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
	//Retrives all Emails with Game Reminder
	public function getUserGR($email)
	{
		$stmt = $this->conn->prepare("SELECT email FROM user WHERE gameReminder = 1;");
		$stmt->bind_param("s", $email);
		$stmt->execute();
		$stmt->bind_result($email);
		$stmt->fetch();
		$user = array();
		$user['email'] = $email;
		return $user;
		
	}
	//Retrieves a Users Favorites
	public function getFavorite($userID)
	{
		$sql = ("SELECT * FROM userFavorites WHERE userID='$userID';");
		$result = $conn->query($sql);
		if ($result->num_rows > 0) {
			$resultArray = array();
			while($row = $result->fetch_assoc()) {
				$tempArray = array();
				$tempArray = $row;
				array_push($resultArray, $tempArray);
				//echo $output;
				}
			//echo json_encode($resultArray);
			return $resultArray;
			//echo $userID;
		} else {
			return 'No Favorites';
		}
		
		//return $resultArray;
	}
	
	//Add USER Favorite Function
	public function addFavorite($userID, $athleteID, $teamID)
	{
		//$athlete = $this->getathleteID($teamID);
		if ($teamID == '1'){
			$stmt = $this->conn->prepare("INSERT INTO userFavorites(userID, BBathleteID, teamID) VALUES (?,?,?);");
			$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'CREATED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_CREATED';
			}
		} elseif ($teamID == '2'){
			$stmt = $this->conn->prepare("INSERT INTO userFavorites(userID, FBathleteID, teamID) VALUES (?,?,?);");
			$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'CREATED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_CREATED';
			}
		} elseif ($teamID == '3'){
			$stmt = $this->conn->prepare("INSERT INTO userFavorites(userID, BSathleteID, teamID) VALUES (?,?,?);");
			$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'CREATED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_CREATED';
			}
		} elseif ($teamID == '4'){
			$stmt = $this->conn->prepare("INSERT INTO userFavorites(userID, SCathleteID, teamID) VALUES (?,?,?);");
			$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'CREATED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_CREATED';
			}
		} else {
			return 'INVALID_ID';
		}
	}
	
		 
	 //Delete USER Favorite Function
	public function deleteFavorite($userID, $athleteID, $teamID)
	{
		//$athlete = $this->getathleteID($teamID);
		if ($teamID == '1'){
			$stmt = $this->conn->prepare("DELETE FROM userFavorites WHERE userID='$userID' AND BBathleteID='$athleteID' AND teamID='$teamID';");
			//$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'DELETED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_DELETED';
			}
		} elseif ($teamID == '2'){
			$stmt = $this->conn->prepare("DELETE FROM userFavorites WHERE userID='$userID' AND FBathleteID='$athleteID' AND teamID='$teamID';");
			//$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'DELETED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_DELETED';
			}
		} elseif ($teamID == '3'){
			$stmt = $this->conn->prepare("DELETE FROM userFavorites WHERE userID='$userID' AND BSathleteID='$athleteID' AND teamID='$teamID';");
			//$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'DELETED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_DELETED';
			}
		} elseif ($teamID == '4'){
			$stmt = $this->conn->prepare("DELETE FROM userFavorites WHERE userID='$userID' AND SCathleteID='$athleteID' AND teamID='$teamID';");
			//$stmt->bind_param("sss", $userID, $athleteID, $teamID);
			if ($stmt->execute()) {
				return 'DELETED_FAVORITE';
			} else {
				return 'FAVORITE_NOT_DELETED';
			}
		} else {
			return 'INVALID_ID';
		}
	}
	
	
	public function getathleteID($fname, $lname, $teamID)
	{
		if ($teamID == '1'){
			$stmt = $this->conn->prepare("SELECT BBathleteID FROM BBathlete WHERE fname = ? AND lname = ?;");
			$stmt->bind_param("ss", $fname, $lname);
			$stmt->execute();
			$stmt->bind_result($BBathleteID);
			$stmt->fetch();
			$ID = array();
			$ID['AID'] = $BBathleteID;
			return $ID;
		} elseif ($teamID == '2'){
			$stmt = $this->conn->prepare("SELECT FBathleteID FROM FBathlete WHERE fname = ? AND lname = ?;");
			$stmt->bind_param("ss", $fname, $lname);
			$stmt->execute();
			$stmt->bind_result($FBathleteID);
			$stmt->fetch();
			$ID = array();
			$ID['AID'] = $FBathleteID;
			return $ID;
		} elseif ($teamID == '3'){
			$stmt = $this->conn->prepare("SELECT BSathleteID FROM BSathlete WHERE fname = ? AND lname = ?;");
			$stmt->bind_param("ss", $fname, $lname);
			$stmt->execute();
			$stmt->bind_result($BSathleteID);
			$stmt->fetch();
			$ID = array();
			$ID['AID'] = $BSathleteID;
			return $ID;
		} elseif ($teamID == '4'){
			$stmt = $this->conn->prepare("SELECT SCathleteID FROM SCathlete WHERE fname = ? AND lname = ?;");
			$stmt->bind_param("ss", $fname, $lname);
			$stmt->execute();
			$stmt->bind_result($SCathleteID);
			$stmt->fetch();
			$ID = array();
			$ID['AID'] = $SCathleteID;
			return $ID;
		} else {
			return 'INVALID_ID';
		}
	}
	
	/* //Retrieves a Users Settings
	public function getSetting($userID)
	{
		$sql = ("SELECT gameReminder, statUpdate FROM userFavorites WHERE userID='$userID';");
		$result = $conn->query($sql);
		if ($result->num_rows > 0) {
			$resultArray = array();
			while($row = $result->fetch_assoc()) {
				$tempArray = array();
				$tempArray = $row;
				array_push($resultArray, $tempArray);
				//echo $output;
				}
			//echo json_encode($resultArray);
			return $resultArray;
			//echo $userID;
		} else {
			return 'Cant Find Settings';
		}
		
		//return $resultArray;
	}  */
	
	//Modifies a Users Settings
 	public function ModSetting($userID, $gameReminder)
	{
		if ($gameReminder=='Yes'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=1 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} elseif ($gameReminder=='No'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=0 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} else {
			return 'INVALID_PARAMETERS';
		}
			
	}
	
	
		//Modifies a Users Settings
 	public function StatModSetting($userID, $statUpdate)
	{
		if ($statUpdate=='Yes'){
			$stmt = $this->conn->prepare("UPDATE user SET statUpdate=1 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} elseif ($statUpdate=='No'){
			$stmt = $this->conn->prepare("UPDATE user SET statUpdate=0 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} else {
			return 'INVALID_PARAMETERS';
		}
			
	}
/* 		//Modifies a statReminder Settings
 	public function StatModSetting($userID, $statUpdate)
	{
		if ($gameReminder=='Yes' AND $statUpdate=='Yes'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=1, statUpdate=1 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} elseif ($gameReminder=='Yes' AND $statUpdate=='No'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=1, statUpdate=0 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} elseif ($gameReminder=='No' AND $statUpdate=='Yes'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=0, statUpdate=1 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} elseif ($gameReminder=='No' AND $statUpdate=='No'){
			$stmt = $this->conn->prepare("UPDATE user SET gameReminder=0, statUpdate=0 WHERE userID='$userID';");
			if ($stmt->execute()) {
				return 'UPDATED';
			} else {
				return 'SETTINGS_NOT_UPDATED';
			}
		} else {
			return 'INVALID_PARAMETERS';
		}
			
	} */
	
		//Function Login
	public function userChangePW($email, $old, $new, $confirm)
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
					if (password_verify($old, $password)){
						if ($new == $confirm){
							$encPswd = password_hash($new, PASSWORD_DEFAULT);
							if (($this->UPDATE_PW($email, $encPswd)) == true){
								return "PASSWORD_CHANGE";
							} else{
								return "UPDATE_PW";
							}
						} else {
							return "NOT_MATCHED";
						}
					} else {
						return "INCORRECT PASSWORD";
					}
				}
			}
		} else {
			return 'INVALID_EMAIL';
		}
	}
	
	public function UPDATE_PW($email, $new_PW)
	{
		$stmt = $this->conn->prepare("UPDATE user SET password='$new_PW' WHERE email='$email';");
		if ($stmt->execute()) {
			return true;
		} else {
			return false;
		}
	}
	

}
?>
<?php
	
$response = array();
$user = array();
	
if($_SERVER['REQUEST_METHOD']=='POST'){

	$email = $_POST['email'];
	$password = $_POST['password'];
	
	if (!isset($_POST['email']) && !isset($_POST['password'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	}
	else if (empty($_POST['email']) || empty($_POST['password'])){
		$response['error2'] = true;
		$response['message2'] = "Email or Password is Empty";
	}

	else {
		
		require_once 'DbOperation.php';
		
		$db = new DbOperation();
		
		$stmt = $db->userLogin($email, $password);
		
		$stmt->store_result();
		$row_count = $stmt->num_rows;
		//$row = $stmt->fetch_assoc();
		//$row = mysqli_fetch_assoc($stmt);
		//$row = mysql_fetch_array($stmt, MYSQL_ASSOC);
		if($row_count == 1){
			//$row = $stmt->fetch();
			//$row = mysqli_fetch_assoc($stmt, MYSQL_ASSOC);
			$response['status']=true;
			$response['message'] = 'Successful Login';
			$user['user'] = $db->getUserByEmail($_POST['email']);
/* 			while ($row = mysqli_fetch_assoc($stmt)){
				$response['email'] = $row['email'];
			}
			mysqli_free_result($result); */
		}else{
			$response['status']=false;
			$response['message']='Invalid Username or Password';
		}
	}
	
	 	
}else{
	$response['error'] = true;
	$response['message'] = 'Request not allowed';
}
/* if ($response['message'] == 'Successful Login') {
	$user = $db->getUserByEmail($email);
	//$user->store_result();
} */
echo json_encode($response);

echo json_encode($user);
?>

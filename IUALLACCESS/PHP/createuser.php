<?php

$response = array();
	
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
		
		$stmt = $db->createUser($email, $password);
	
		if($stmt == 'USER_CREATED'){
			$response['status']=true;
			$response['message3']='User added successfully';
		}else if ($stmt == 'USER_NOT_CREATED'){
			$response['status']=false;
			$response['message4']='Could Not Add User';
		}
		else{
			$response['status']=false;
			$response['message4']='Email has already been used';
		}
	}
}else{
	$response['error5']=true;
	$response['message5']='You are not authorized';
}
echo json_encode($response);
?>
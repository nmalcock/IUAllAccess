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
	
#	$email = isset($_POST['email']) ? $_POST['email'] ”;
#	$email = !empty($_POST['email']) ? $_POST['email'] : ”;

#	$password = isset($_POST['password']) ? $_POST['password'] : ”;
#	$password = !empty($_POST['password']) ? $_POST['password'] : ”;
	
#	$email = $_POST['email'];
#   $password = $_POST['password'];

	else {
	
		require_once 'DbOperation.php';
	
		$db = new DbOperation();
	
		if($db->createUser($email, $password)){
			$response['error3']=false;
			$response['message3']='User added successfully';
		}else{
			$response['error4']=true;
			$response['message4']='Could not add user';
		}
	}
}else{
	$response['error5']=true;
	$response['message5']='You are not authorized';
}
echo json_encode($response);
?>
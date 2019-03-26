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
		
		require_once 'DbOperationTester.php';
		
		$db = new DbOperation();
		
		$stmt = $db->userLogin($email, $password);

		if($stmt=="CORRECT_PASSWORD"){
			$response['status']=true;
			$response['message'] = 'Successful Login';
			$user = $db->getUserByEmail($_POST['email']);
		} else if($stmt=="INCORRECT PASSWORD"){
			$response['status']=false;
			$response['message']='Invalid Password';
		} else if($stmt=="INVALID_EMAIL") {
			$response['status']=false;
			$response['message']='INVALID_EMAIL';
		} else {
			$response['status']=false;
			$response['message']='Unforseen Error Try Again';
		}
	}
	
}else{
	$response['error'] = true;
	$response['message'] = 'Request not allowed';
}

echo json_encode($response);
echo json_encode($user);
?>
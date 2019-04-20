<?php
	
$response = array();
	
if($_SERVER['REQUEST_METHOD']=='POST'){
	$email = $_POST['email'];
	$oldPassword = $_POST['oldPassword'];
	$newPassword = $_POST['newPassword'];
	$newPasswordconfirm = $_POST['newPasswordconfirm'];
	
	if (!isset($_POST['email']) && !isset($_POST['oldPassword']) && !isset($_POST['newPassword']) && !isset($_POST['newPasswordconfirm'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	} else if (empty($_POST['email']) || empty($_POST['oldPassword']) || empty($_POST['newPassword']) || empty($_POST['newPasswordconfirm'])){
		$response['error2'] = true;
		$response['message2'] = "Email or Password is Empty";
	} else {
		
		require_once 'DbOperation.php';
		
		$db = new DbOperation();
		
		$stmt = $db->userChangePW($email, $oldPassword, $newPassword, $newPasswordconfirm);
		if($stmt=="PASSWORD_CHANGE"){
			$response['status']=true;
			$response['message'] = 'Password Succcessfully Changed';						
		} else if($stmt=="INCORRECT PASSWORD"){
			$response['status']=false;
			$response['message']='Invalid Password';
		} else if($stmt=="INVALID_EMAIL") {
			$response['status']=false;
			$response['message']='INVALID_EMAIL';
		} else if($stmt=="NOT_MATCHED") {
			$response['status']=false;
			$response['message']='Passwords do not Match';
		} else if($stmt=="UPDATE_PW") {
			$response['status']=false;
			$response['message']='Problem with Update_PW function';
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

?>
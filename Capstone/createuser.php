<? php

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

	$email = $_POST['email']
	$username = $_POST['username']
	$password = $_POST['password']
	
	
	require_once '../includes/DbOperation.php';
	
	$db = new DbOperation();
	
	
	if($db->createUser($email, $username, $password)){
		$response['error']=false;
		$response['message']='User added successfully';
	}else{
		
		$response['error']=true;
		$response['message']='Could not add user';
	}

}else{
	$response['error']=true;
	$response['message']='You are not authorized';
}
echo json_encode($response);
<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST'){

	$userID = $_POST['userID'];
	$gameReminder = $_POST['gameReminder'];
	
	if (!isset($_POST['userID']) && !isset($_POST['gameReminder'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	} else {
		
		require_once 'DbOperation.php';

		$db = new DbOperation();
		
		$stmt = $db->ModSetting($userID, $gameReminder);
			
		if($stmt == 'UPDATED'){
			$response['status']=true;
			$response['message3']='UPDATED SETTINGS';
		} else if ($stmt == 'SETTINGS_NOT_UPDATED'){
			$response['status']=false;
			$response['message4']='Could Not Add Favorite';
		}else if ($stmt == 'INVALID_PARAMETERS'){
			$response['status']=false;
			$response['message4']='INVALID PARAMETERS Send Yes or No for both settings';
		}  else {
			$response['status']=false;
			$response['message4']='Unidentified Error';
		}
	} 
}
echo json_encode($response);
?>
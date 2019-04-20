<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST'){

	$userID = $_POST['userID'];
	$athleteID = $_POST['athleteID'];
	$teamID = $_POST['teamID'];
	
	if (!isset($_POST['userID']) && !isset($_POST['athleteID']) && !isset($_POST['teamID'])) {
		$response['error1'] = true;
		$response['message1'] = "variable is not set or is NULL";
	} else {
		
		require_once 'DbOperation.php';

		$db = new DbOperation();
		
		$stmt = $db->addFavorite($userID, $athleteID, $teamID);
			
		if($stmt == 'CREATED_FAVORITE'){
			$response['status']=true;
			$response['message3']='Favorite added successfully';
		}else if ($stmt == 'FAVORITE_NOT_CREATED'){
			$response['status']=false;
			$response['message4']='Could Not Add Favorite';
		} else if ($stmt == 'INVALID_ID'){
			$response['status']=false;
			$response['message4']='Invalid AthleteID';
		} else {
			$response['status']=false;
			$response['message4']='Unidentified Error';
		}
	} 
}
echo json_encode($response);
?>
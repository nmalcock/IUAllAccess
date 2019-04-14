<?php

class DbConnect 
{
	private $conn;
	
	function __construct()
	{
	}
	
	/**
	*establish database connection
	*/
	
	function connect()
	{
		require_once 'config.php';
		
		//Connecting to DB
		$this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
		
		//Check error
		if (mysqli_connect_errno()) {
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}

		
		// returning connection resource
		return $this->conn;
	}
}
?>

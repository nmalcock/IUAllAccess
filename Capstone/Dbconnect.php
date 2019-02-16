<?php

	private ?conn;
	
	function __construct()
	{
	}
	
	/**
	*establish database connection
	*/
	
	function connect()
	{
		require_once 'Config.php';
		
		//Connecting to DB
		$this->conn = new mysqli('db.sice.indiana.edu', 'i494f18_team58', 'my+sql=i494f18_team58', 'i494f18_team58');
		
		//Check error
		if (mysqli_connect_errno()) {
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}
		
		// returning connection resource
		return $this->conn;
	}
}
?>

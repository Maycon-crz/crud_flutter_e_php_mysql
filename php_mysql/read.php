<?php 

include 'database.php';
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type, Accept");

	$query = $link->query("SELECT * FROM person");
	$result = array();

	while($rowData = $query->fetch_assoc()){
		$result[] = $rowData;
	}

	echo json_encode($result);

?>
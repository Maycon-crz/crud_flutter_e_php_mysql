<?php 

include 'database.php';
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type, Accept");

	$id = $_POST['id'];

	$link->query("DELETE FROM person WHERE id = '".$id."'");

?>
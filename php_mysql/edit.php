<?php 

include 'database.php';
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Headers: Content-Type, Accept");

	$id = $_POST['id'];
	$firstname = $_POST['firstname'];
	$lastname = $_POST['lastname'];
	$phone = $_POST['phone'];
	$address = $_POST['address'];

	$link->query("UPDATE person SET firstname = '".$firstname."', lastname = '".$lastname."', phone = '".$phone."', address = '".$address."' WHERE id = '".$id."'");

?>
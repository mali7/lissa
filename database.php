<?php
session_start();
if(isset($_POST['action']) && !empty($_POST['action'])) {
    $action = $_POST['action'];
    switch($action) {
        case 'checkStage' : echo checkStage();  break;
		case 'getId' : echo getId(); break;
        case 'updateFeedbackId' : updateFeedbackId();break;
    }
};

//echo "stuff";
$db = mysqli_connect("localhost", "root", "test", "RocSpeak");
//if(!$db) { die("Unable to connect to MySQL: " . mysql_error()); }

$query = "SELECT * FROM Feedback;";

/*while($table = mysqli_fetch_array($result)) { // go through each row that was returned in $result
    echo($table[0] . "<BR>1". $table[1] . "<BR>1" .$table[2]);    // print the table that was returned on that row.

}*/

/*$query = "Insert INTO Feedback (FeedbackId) Values (');";
$query = "Insert INTO Feedback (HITId) Values ();";
$query = "Insert INTO Feedback (HITId) Values ();";*/

//check Stage
//echo checkStage();
function checkStage()
{

	//$datakey = '3c60ef46c7afb9fbbae7a0ecaef3066b_1';
	$datakey = $_POST['datakey'];
	$db = mysqli_connect("localhost", "root", "test", "RocSpeak");
	$query = "SELECT * FROM Feedback WHERE FeedbackId = '$datakey';"; 
	$result = mysqli_query($db, $query);
	$rows = mysqli_num_rows($result);
	/*$query = "describe Feedback;";
	$result = mysqli_query($db, $query);

	while($table = mysqli_fetch_array($result)) { // go through each row that was returned in $result
		echo($table[0] . "______________". $table[1] . "____________" .$table[2]."<br>");    // print the table that was returned on that row.

	}*/
	if($rows == 0)
		return 0;
	$row = mysqli_fetch_array($result);
	if($row[1] == NULL)
		return 1;
	if($row[2] == NULL)
		return 2;
	return 3;
}
//echo checkStage();
function updateFeedbackId()
{
	$db = mysqli_connect("localhost", "root", "test", "RocSpeak");

	$query;
	//$key = "3QTFNPMJC6IBI4LGDEWUH1HV7KHNZ7";
	//$datakey = "3c60ef46c7afb9fbbae7a0ecaef3066b_1";
	//$column = 2;
	$datakey = $_POST['datakey'];
	$key = $_POST['HITId'];
	$column = $_POST['column'];

	if($column == 0)
	{
		//insert FeedbackId
		$query = "Insert INTO Feedback (FeedbackId) Values ('$datakey');";
	}else if($column == 1){
		//insert HITId
		$query = "UPDATE Feedback SET `HITId1` = '$key' WHERE FeedbackId = '$datakey';";
	}else
	{
		//insert HITId2
		$query = "UPDATE Feedback SET `HITId2` = '$key' WHERE FeedbackId = '$datakey';";
	}
	mysqli_query($db, $query);
	//echo $key." ".$datakey;

}

function getId()
{
	$db = mysqli_connect("localhost", "root", "test", "RocSpeak");
	
	//$datakey = "3c60ef46c7afb9fbbae7a0ecaef3066b_1";
	//$column = 1;
	$datakey = $_POST['datakey'];
	$column = $_POST['column'];
	
	$query = "SELECT * FROM Feedback WHERE FeedbackId = '$datakey';"; 
	$result = mysqli_query($db, $query);
	$row = mysqli_fetch_array($result);

	return $row[$column];

}

/*if($_POST['action'] == "checkStage")
{
	echo checkStage();
}

if($_POST['action'] == "getId")
{
	echo getId();
}*/

?>
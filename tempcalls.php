<?php

function createHIT($filepath, $Hitname)
{
	//require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => TRUE));
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	$GetAccountBalanceResponse = $turk50->GetAccountBalance();
	print_r($GetAccountBalanceResponse);
	
	$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);
	
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui.php?dataKey=$filepath</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Please complete the survey after watching the video.",
	"Question" => $Question,
	"Reward" => array("Amount" => "0.50", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "1200",
	"LifetimeInSeconds" => "172800",
	"Keywords" => "Speaking, Skill, MACH, Interaction, Analysis, Survey",
	"MaxAssignments" => "10",
	"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	
	//print($CreateHITresponse);
	echo $CreateHITResponse->HIT->HITId;

}

//createHIT("9dbd6fdf5d071c370d83a61871ca5f4e", "Speaking Skill Analysis 1");
//createHIT("9a3101ca11d8605251a476f317caf50e", "Speaking Skill Analysis 2");
//createHIT("09e37e717d5787ce89b64a06a3735f5a", "Speaking Skill Analysis 3");
//createHIT("23e5e2cd0648d6d45c6967b1c62b5459", "Speaking Skill Analysis 4");
//createHIT("9dbd6fdf5d071c370d83a61871ca5f4e", "Speaking Skill Analysis a");
//createHIT("23e5e2cd0648d6d45c6967b1c62b5459", "Speaking Skill Analysis b");
//createHIT("75f6b6f6d01f1b879d0cc0717f79082f", "Speaking Skill Analysis c");
//createHIT("0817a1ec813dff7cdaf342dedd1e1a06", "Speaking Skill Analysis d");


function createHIT2($filepath, $Hitname, $HITId)
{
	//$Hitname = $_POST['Hitname'];

	//$Hitname = "Rating $Hitname comments";
	require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => TRUE));
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	//$GetAccountBalanceResponse = $turk50->GetAccountBalance();
	//print_r($GetAccountBalanceResponse);
	 //$HITId = $_POST['HITId'];

	$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);
	
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui2.php?dataKey=$filepath&amp;HITId=$HITId</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Please rate the comments by their helpfulness to the speaker after watching the video.",
	"Question" => $Question,
	"Reward" => array("Amount" => "0.50", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "1200",
	"LifetimeInSeconds" => "172800",
	"Keywords" => "Speaking, Skill, MACH, Interaction, Analysis, Survey",
	"MaxAssignments" => "10",
	"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	
	//print_r($CreateHITResponse);
	echo $CreateHITResponse->HIT->HITId;

}
createHIT2("9dbd6fdf5d071c370d83a61871ca5f4e", "Speaking Skill Analysis Commentary Rating a2", "37PGLWGSJT6OF8B3GXGSPEX1HC2KIU"); //3QTFNPMJC6IBI4LGDEWUH1HV7KHNZ7  //3UYRNV2KITZWY8KT4OWH4HKR8BEN86
//createHIT2("23e5e2cd0648d6d45c6967b1c62b5459", "Speaking Skill Analysis Commentary Rating b1", "3N5YJ55YXG3AHWD81MGV08QMYZ3ANM");
//createHIT2("75f6b6f6d01f1b879d0cc0717f79082f", "Speaking Skill Analysis Commentary Rating c", "374UMBUHN5PW5OFQIWYYF2M2NK9CTQ");	//3L55D8AUFAXSMAEKS2LXNJEH2MWCYK
//createHIT2("0817a1ec813dff7cdaf342dedd1e1a06", "Speaking Skill Analysis Commentary Rating d1", "36AZSFEYZ40S8BR99R2I50452KPVBI");

function searchHIT()
{
	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	$Request = array(
		AWSAccessKeyId => "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "SearchHITs",
		SortDirection => "Descending",
	);
	
	$HITs = $turk50->SearchHITs($Request);
	print("<pre>".print_r($HITs,true)."</pre>");
	//echo $turk50->SearchHIT();
}

//searchHIT();

echo "done";
?>
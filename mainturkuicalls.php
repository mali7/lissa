<?php 

if(isset($_POST['action']) && !empty($_POST['action'])) {
    $action = $_POST['action'];
    switch($action) {
        case 'createHIT' : createHIT();break;
        case 'getAssignmentsforHIT' : getAssignmentsforHIT();break;
        case 'createHIT2' : createHIT2();break;
		case 'getAssignmentsforHIT2' : getAssignmentsforHIT2(); break;
    }
}

//RocSpeak keys
//AKIAJRBPIJ5V6K6SMABQ
//rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9

require_once("Turk50.php");    
//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => TRUE));
//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
//$filepath = "75f6b6f6d01f1b879d0cc0717f79082f";
//75f6b6f6d01f1b879d0cc0717f79082f
//3HEADTGN2PSFOI8Y4NKKI5RU1U2VRW

function createHIT()
{

	require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => TRUE));
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	//$GetAccountBalanceResponse = $turk50->GetAccountBalance();
	//print_r($GetAccountBalanceResponse);
	$Hitname = $_POST['Hitname'];

	$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui.php?dataKey=75f6b6f6d01f1b879d0cc0717f79082f</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	//"Description" => "Please complete the survey after watching the video. You may complete only one of the HITs titled Speaking Skills 1, 2, 3, or 4 but not more than one, otherwise your results will be rejected.",
	"Description" => "Please complete the survey after watching the video.",
	"Question" => $Question,
	"Reward" => array("Amount" => "0.50", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "1200",
	"LifetimeInSeconds" => "172800",
	"Keywords" => "Speaking, Skill, MACH, Interaction, Analysis, Survey",
	"MaxAssignments" => "10",
	//"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	//print_r($CreateHITResponse);
	
	echo $CreateHITResponse->HIT->HITId;
	


}

function createHIT2()
{
	$Hitname = $_POST['Hitname'];

	$Hitname = "Rating $Hitname comments";
	require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => TRUE));
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	//$GetAccountBalanceResponse = $turk50->GetAccountBalance();
	//print_r($GetAccountBalanceResponse);
	 $HITId = $_POST['HITId'];

	$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);
	
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui2.php?dataKey=75f6b6f6d01f1b879d0cc0717f79082f&amp;HITId=$HITId</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Please rate the comments by their usefulness after watching the video.",
	"Question" => $Question,
	"Reward" => array("Amount" => "0.50", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "1200",
	"LifetimeInSeconds" => "172800",
	"Keywords" => "Speaking, Skill, MACH, Interaction, Analysis, Survey",
	"MaxAssignments" => "10",
	//"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	
	print_r($CreateHITResponse);
	//echo $CreateHITResponse->HIT->HITId;

}
//createHIT("9dbd6fdf5d071c370d83a61871ca5f4e", "Speaking Skill Analysis 1");
//createHIT("9a3101ca11d8605251a476f317caf50e", "Speaking Skill Analysis 2");
//createHIT("09e37e717d5787ce89b64a06a3735f5a", "Speaking Skill Analysis 3");
//createHIT("23e5e2cd0648d6d45c6967b1c62b5459", "Speaking Skill Analysis 4");

function searchHIT()
{
	//require_once("Turk50.php");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
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

//


function getAssignmentsforHIT()
{	
	
    $HITId = "3HEADTGN2PSFOI8Y4NKKI5RU1U2VRW";
	//$HITId = $_POST['HITId'];

	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));	
	
	//echo "what is it".$HITId."what is going on";
	$Request = array(
		AWSAccessKeyId => "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "GetAssignmentsForHIT",
		//Signature => 
		//Timestamp =>
		//ResponseGroup => "Request",
		HITId => $HITId,	
	);
	
	$assignments = $turk50->GetAssignmentsForHIT($Request);
	print("<pre>".print_r($assignments,true)."</pre>");
	$numofAssignments = $assignments->GetAssignmentsForHITResult->NumResults;
	
	$commentcount = 0;
	if($numofAssignments == 10)
	{
		echo "completed";
	}
	else if($numofAssignments > 0)
	{
	
	$Titles = array(
		0 => "Body Gesture",	
		2 => "Friendliness",
		4 => "Volume Modulation"
	);
	
	for($j = 0; $j < 6; $j= $j+2)
	{
		echo "<fieldset>
				<legend>$Titles[$j]</legend>
				<table  id='$j' class='table table-hover' style='width:100%'>";
		echo "<thead><tr>
				<th data-sort='string'>Timestamp</th> 
				<th>Comment</th>
				</thead>
			</tr>";
		for ($i = 0; $i < $numofAssignments; $i++) {
			$assignment = "";
			if($numofAssignments == 1)
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment;			
			else
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment[$i];						

			$answer = $assignment->Answer;
			$status = $assignment->AssignmentStatus;
			$answer = new SimpleXMLElement($answer);
			$assignmentId = $assignment->AssignmentId;

			//print("<pre>".print_r($answer,true)."</pre>");

			/*for(int i = 3; i < 8; i++)
			{
				echo "<tr class='warning'>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td><button class='myButton' onclick=approveAssignment('$assignmentId')>Approve</button>
					<button class='myButton' onclick=rejectAssignment('$assignmentId')>Reject</button>
					</td>
				</tr>";
			}*/
			
			$timestamp = $answer->Answer[3+$j]->FreeText;
			$comment = $answer->Answer[4+$j]->FreeText;
			echo "<tr>
					<td>".$timestamp."</td>
					<td>".$comment."</td>
				</tr>";
			$commentcount++;
			/*if($status == "Submitted")
			{
				echo "<tr class='warning'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td><button class='myButton' onclick=approveAssignment('$assignmentId')>Approve</button>
					<button class='myButton' onclick=rejectAssignment('$assignmentId')>Reject</button>
					</td>
				</tr>";
			
			}
			else if($status == "Rejected")
			{
			//print("<pre>".print_r($answer,true)."</pre>");
			//print("<pre>".print_r($answer->Answer[2]->FreeText,true)."</pre>");

			//print_r($answer);
			//echo "<p>".$answer[0]."</p>";
			//echo $answer[1];
			//echo $answer[2];
				echo "<tr class= 'danger'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td>".$status."</td>
				
				</tr>";
			}
			else
			{
				echo "<tr class= 'success'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td>".$status."</td>

				</tr>";					
			}*/
		}
		echo "</table></fieldset>";
	}
	}	
	else
	{
		echo "<center><font size='5' color='red'>Waiting for feedback from Amazon Mechanical Turk Workers</font></center>";
	}
	//echo $assignments->GetAssignmentsForHITResult;
	

}

function getAssignmentsforHIT2test()
{
	$HITId = "3Y3N5A7N4G95VWQB5RFBQFJTWYRYMB";
	//$HITId = $_POST['HITId'];

	//require_once("Turk50.php");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));	
	
	//echo "what is it".$HITId."what is going on";
	$Request = array(
		AWSAccessKeyId => "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "GetAssignmentsForHIT",
		//Signature => 
		//Timestamp =>
		//ResponseGroup => "Request",
		HITId => $HITId,	
	);
	
	$assignments = $turk50->GetAssignmentsForHIT($Request);
	//print("<pre>".print_r($assignments,true)."</pre>");
	$numofAssignments = $assignments->GetAssignmentsForHITResult->NumResults;
	
	$commentcount = 0;

	if($numofAssignments > 0)
	{
	
	$Titles = array(
		0 => "Body Gesture",	
		2 => "Friendliness",
		4 => "Volume Modulation"
	);
	
	for($j = 0; $j < 6; $j= $j+2)
	{
		echo "<fieldset>
				<legend>$Titles[$j]</legend>
				<table  id='$j' class='table table-hover' style='width:100%'>";
		echo "<thead><tr>
				<th data-sort='string'>Timestamp</th> 
				<th>Comment</th>
				<th>Votes</th>
				</thead>
			</tr>";
		for ($i = 0; $i < $numofAssignments; $i++) {
			$assignment = "";
			if($numofAssignments == 1)
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment;			
			else
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment[$i];						

			$answer = $assignment->Answer;
			$status = $assignment->AssignmentStatus;
			$answer = new SimpleXMLElement($answer);
			$assignmentId = $assignment->AssignmentId;

			//print("<pre>".print_r($answer,true)."</pre>");

			/*for(int i = 3; i < 8; i++)
			{
				echo "<tr class='warning'>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td><button class='myButton' onclick=approveAssignment('$assignmentId')>Approve</button>
					<button class='myButton' onclick=rejectAssignment('$assignmentId')>Reject</button>
					</td>
				</tr>";
			}*/
			
			$timestamp = $answer->Answer[3+$j]->FreeText;
			$comment = $answer->Answer[4+$j]->FreeText;
			echo "<tr>
					<td>".$timestamp."</td>
					<td>".$comment."</td>
				</tr>";
			$commentcount++;
			/*if($status == "Submitted")
			{
				echo "<tr class='warning'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td><button class='myButton' onclick=approveAssignment('$assignmentId')>Approve</button>
					<button class='myButton' onclick=rejectAssignment('$assignmentId')>Reject</button>
					</td>
				</tr>";
			
			}
			else if($status == "Rejected")
			{
			//print("<pre>".print_r($answer,true)."</pre>");
			//print("<pre>".print_r($answer->Answer[2]->FreeText,true)."</pre>");

			//print_r($answer);
			//echo "<p>".$answer[0]."</p>";
			//echo $answer[1];
			//echo $answer[2];
				echo "<tr class= 'danger'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td>".$status."</td>
				
				</tr>";
			}
			else
			{
				echo "<tr class= 'success'>
					<td>".$answer->Answer[0]->FreeText."</td>
					<td>".$answer->Answer[1]->FreeText."</td>
					<td>".$answer->Answer[2]->FreeText."</td>
					<td>".$status."</td>

				</tr>";					
			}*/
		}
		echo "</table></fieldset>";
	}
	}	
	else
	{
		echo "<center><font size='5' color='red'>Waiting for ratings from Amazon Mechanical Turk Workers</font></center>";
	}
	//echo $assignments->GetAssignmentsForHITResult;



}

function getAssignmentsforHIT1()
{
	//$HITId = $_GET["HITId"];
    //$HITId = "3Y3N5A7N4G95VWQB5RFBQFJTWYRYMB";
	$HITId = "37PGLWGSJT6OF8B3GXGSPEX1HC2KIU";
	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));	
	
	//echo "what is it".$HITId."what is going on";
	$Request = array(
		AWSAccessKeyId => "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "GetAssignmentsForHIT",
		//Signature => 
		//Timestamp =>
		//ResponseGroup => "Request",
		HITId => $HITId,	
	);
	
	$assignments = $turk50->GetAssignmentsForHIT($Request);
	//print("<pre>".print_r($assignments,true)."</pre>");
	$numofAssignments = $assignments->GetAssignmentsForHITResult->NumResults;
	
	$alldata = array();

	$commentcount = 0;

	if($numofAssignments > 0)
	{
	
	for($j = 0; $j < 6; $j= $j+2)
	{

		for ($i = 0; $i < $numofAssignments; $i++) {
			$assignment = "";
			if($numofAssignments == 1)
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment;			
			else
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment[$i];						

			$answer = $assignment->Answer;
			$status = $assignment->AssignmentStatus;
			$answer = new SimpleXMLElement($answer);
			$assignmentId = $assignment->AssignmentId;

			//print("<pre>".print_r($answer,true)."</pre>");

			
			$timestamp = $answer->Answer[3+$j]->FreeText;
			$comment = $answer->Answer[4+$j]->FreeText;
			
			if($j == 0)
			{
				$alldata[$commentcount] = array(
				category => "B",
				timestamp => $timestamp,
				comment => $comment,
				rating => 0
				);
			}else if($j == 2)
			{
				$alldata[$commentcount] = array(
				category => "F",
				timestamp => $timestamp,
				comment => $comment,
				rating => 0
				);
			
			}else
			{
				$alldata[$commentcount] = array(
				category => "V",
				timestamp => $timestamp,
				comment => $comment,
				rating => 0
				);
			}
			
			$commentcount++;
			
			//echo " length of ".count(($answer->Answer));
			for($k = 9; $k < count($answer->Answer)-1; $k=$k+3)
			{
				//echo $j;
				if($j == 0)
				{
					if($answer->Answer[$k]->FreeText == 1)
					{
						$timestamp = $answer->Answer[$k+1]->FreeText;
						$comment = $answer->Answer[$k+2]->FreeText;
						
							
						$alldata[$commentcount] = array(
							category => "B",
							timestamp => $timestamp,
							comment => $comment,
							rating => 0
						);
						$commentcount++;
					}
				}
				else if($j == 2)
				{
					//echo $answer->Answer[$k]->FreeText;
					if($answer->Answer[$k]->FreeText == 2)
					{
						$timestamp = $answer->Answer[$k+1]->FreeText;
						$comment = $answer->Answer[$k+2]->FreeText;
				
							$alldata[$commentcount] = array(
								category => "F",
								timestamp => $timestamp,
								comment => $comment,
								rating => 0
							);
							$commentcount++;

					}
				}
				else
				{
					if($answer->Answer[$k]->FreeText == 3)
					{
						$timestamp = $answer->Answer[$k+1]->FreeText;
						$comment = $answer->Answer[$k+2]->FreeText;
						
							$alldata[$commentcount] = array(
								category => "V",
								timestamp => $timestamp,
								comment => $comment,
								rating => 0
							);
							$commentcount++;
					
					}
				}
			}
		}
		}
	}	
	else
	{
		echo "none";
	}
	//echo $assignments->GetAssignmentsForHITResult;
	
	print("<pre>".print_r($alldata,true)."</pre>");

}


//getAssignmentsforHIT1();
getAssignmentsforHIT();
?>
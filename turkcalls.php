<?php




//testing some example styles
/*$Question = "<QuestionForm xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd'>
  <Overview>
    <Title>Game 01523, 'X' to play </Title>
    <Text>
      You are helping to decide the next move in a game of Tic-Tac-Toe.  The board looks like this:
    </Text>
    <Binary>
      <MimeType>
        <Type>image</Type>
        <SubType>gif</SubType>
      </MimeType>
      <DataURL>https://www.google.com</DataURL>
      <AltText>The game board, with 'X' to move.</AltText>
    </Binary>
    <Text>
      Player 'X' has the next move.
    </Text>
  </Overview>
  <Question>
    <QuestionIdentifier>nextmove</QuestionIdentifier>
    <DisplayName>The Next Move</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <Text>
        What are the coordinates of the best move for player 'X' in this game?
      </Text>
    </QuestionContent>
    <AnswerSpecification>
      <FreeTextAnswer>
        <Constraints>
          <Length minLength='2' maxLength='2' />
        </Constraints>
        <DefaultText>C1</DefaultText>
      </FreeTextAnswer>
    </AnswerSpecification>
  </Question>
  <Question>
    <QuestionIdentifier>likelytowin</QuestionIdentifier>
    <DisplayName>The Next Move</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <Text>
        How likely is it that player 'X' will win this game?
      </Text>
    </QuestionContent>
    <AnswerSpecification>
      <SelectionAnswer>
        <StyleSuggestion>radiobutton</StyleSuggestion>
        <Selections>
          <Selection>
            <SelectionIdentifier>notlikely</SelectionIdentifier>
            <Text>Not likely</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>unsure</SelectionIdentifier>
            <Text>It could go either way</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>likely</SelectionIdentifier>
            <Text>Likely</Text>
          </Selection>
        </Selections>
      </SelectionAnswer>
    </AnswerSpecification>
  </Question>
</QuestionForm>";*/

// prepare ExternalQuestion - doesn't quite work yet
/*Question = "<QuestionForm xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd'>
  <Question>
   <QuestionIdentifier>1</QuestionIdentifier>
   <QuestionContent>
     <iframe src= 'http://www.machinteraction.com/feedback_2014_IAP?dataKey=ag9zfm1hY2hpbnRlcnZpZXdyFgsSCVJlY29yZGluZxiAgICA0v_KCww' width='100%' height='100%'></iframe>
   </QuestionContent>
   <AnswerSpecification>
     <FreeTextAnswer/>
   </AnswerSpecification>
  </Question>
  </QuestionForm>";*/
  
  //phpinfo();

//$turker = new MTurkInterface("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
//print $turker->GetAccountBalance();


/*if (isset($GetAccountBalanceResponse->OperationRequest->Errors) || isset($GetAccountBalanceResponse->GetAccountBalanceResult->Errors))
{
    // handle error
	echo "please";
}*/


$Question = "<QuestionForm xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd'>
  <Overview>
    <Title> Providing feedback for interviewers </Title>
    <Text>
      Watch the video and look at the charts to comment and rate the interview.
    </Text>
  </Overview>
  <Question>
    <QuestionIdentifier>comment</QuestionIdentifier>
    <DisplayName>General Comment</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
		<FormattedContent><![CDATA[
  <p><b>Sources for the interview are below</b> <br/><a href='http://www.machinteraction.com/feedback_2014_IAP?dataKey=ag9zfm1hY2hpbnRlcnZpZXdyFgsSCVJlY29yZGluZxiAgICA0v_KCww'>Link to the Charts</a>
  <br/><a href='http://www.youtube.com/watch?v=OfCl0i-16aA'>Link to the video</a></p>
]]></FormattedContent>

	<Text>
		Provide general comment about the interview.
	</Text>
    </QuestionContent>
    <AnswerSpecification>
      <FreeTextAnswer>
      </FreeTextAnswer>
    </AnswerSpecification>
  </Question>
  <Question>
    <QuestionIdentifier>confidence</QuestionIdentifier>
    <DisplayName>Confidence</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <Text>
        How confident does he look?
      </Text>
    </QuestionContent>
    <AnswerSpecification>
      <SelectionAnswer>
        <StyleSuggestion>radiobutton</StyleSuggestion>
        <Selections>
          <Selection>
            <SelectionIdentifier>veryconfident</SelectionIdentifier>
            <Text>Very Confident</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>confident</SelectionIdentifier>
            <Text>Confident</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>notveryconfident</SelectionIdentifier>
            <Text>Not Very Confident</Text>
          </Selection>
        </Selections>
      </SelectionAnswer>
    </AnswerSpecification>
  </Question>
</QuestionForm>";

$Question="<HTMLQuestion xmlns = 'http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2011-11-11/HTMLQuestion.xsd'>
  <HTMLContent><![CDATA[
	<!DOCTYPE html>
	<html>
		<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
			<script type='text/javascript' src='https://s3.amazonaws.com/mturk-public/externalHIT_v1.js'></script>
		</head>
		<body>
			<iframe width='560' height='315' src='//www.youtube.com/embed/-Qg-CXvIGWM' frameborder='0' allowfullscreen></iframe>
			
			<form name='mturk_form' method='post' id='mturk_form' action='https://www.mturk.com/mturk/externalSubmit'>
			<input type='hidden' value='' name='assignmentId' id='assignmentId'/>
			<h1>What's up?</h1>
			<p><textarea name='comment' cols='80' rows='3'></textarea></p>
			<p><input type='submit' id='submitButton' value='Submit' /></p></form>
			<script language='Javascript'>turkSetAssignmentID();</script>
		</body>
	</html>
	]]>
	</HTMLContent>
		<FrameHeight>450</FrameHeight>
	</HTMLQuestion>";

  

/*$Notification = array(
	https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester
&AWSAccessKeyId=[the Requester's Access Key ID]
&Operation=SendTestEventNotification
&Signature=[signature for this request]
&Timestamp=[your system's local time]
&Notification.1.Destination=janedoe@example.com
&Notification.1.Transport=Email
&Notification.1.Version=2006-05-05
&Notification.1.EventType=AssignmentSubmitted
&TestEventType=AssignmentSubmitted


);
// notify hit
$turk50->SendTestEventNotification($Notification);
echo "hersqqwqe";*/

//require_once("Turk50.php");
//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));

/*function createHIT()
{
	//require_once("Turk50.php");
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	//$GetAccountBalanceResponse = $turk50->GetAccountBalance();
	//print_r($GetAccountBalanceResponse);

	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkdata.php?dataKey=e9d933d95ccc17df107c1eb0344ec9e5_1</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	// prepare Request
	$Hitname = $_POST['Hitname'];
	
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Stuff",
	"Question" => $Question,
	"Reward" => array("Amount" => "0.01", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "3000",
	"LifetimeInSeconds" => "30000",
	"MaxAssignments" => "4",
	"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	echo $CreateHITResponse->HIT->HITId;
	//echo "3XABXM4AJ154E3JHFAGJXYIDOFC8Q0";
	echo "3VIVIU06FKC6IUX2W3LTTESMHEAIMT";
}*/

function approveAssignment()
{
	$AssignmentId = $_POST['AssignmentId'];
	//echo $AssignmentId;
	
	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	
	$Request = array(
		AWSAccessKeyId => "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "ApproveAssignment",
		AssignmentId => $AssignmentId,
	);
	
	$approved = $turk50->ApproveAssignment($Request);

	//print("<pre>".print_r($Request,true)."</pre>");

}

function rejectAssignment()
{
	$AssignmentId = $_POST['AssignmentId'];
	
	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");

	$Request = array(
		AWSAccessKeyId => "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => " RejectAssignment",
		AssignmentId => $AssignmentId,
	);
	
	$rejected = $turk50->RejectAssignment($Request);

	//print("<pre>".print_r($rejected,true)."</pre>");

}

function getAssignmentsforHIT1()
{
    $HITId = $_POST['HITId'];

	require_once("Turk50.php");
	$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	
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
	
	

	if($numofAssignments > 0)
	{
	
		echo "<table  class='table table-hover' style='width:100%'>";
		echo "<tr>
				<th>quality</th>
				<th>attribute</th> 
				<th>comment</th>
				<th>status</th>
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

			//print("<pre>".print_r($assignment,true)."</pre>");


			if($status == "Submitted")
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
			}
		}	
		echo "</table>";
	}	
	else
	{
		echo "<center><font size='5' color='red'>Waiting for feedback from Amazon Mechanical Turk Workers</font></center>";
	}
	//echo $assignments->GetAssignmentsForHITResult;
	

}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
require_once("Turk50.php");

function getCountsforHIT()
{
	$turk50 = new Turk50("AKIAITNM7AJPU4GNXGFA", "juKr+1g3SqH1Xo6N8e7+OPY8v3KL4x1R6EZkmEMJ", array("sandbox" => FALSE));	

	$HITId = $_POST["HITId"];

	//require_once("Turk50.php");

	$Request = array(
		AWSAccessKeyId => "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9",
		Service => "https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester",
		Operation => "GetAssignmentsForHIT",
		//Signature => 
		//Timestamp =>
		//ResponseGroup => "Request",
		HITId => $HITId,	
	);
	//echo "whatssup";
	$assignments = $turk50->GetAssignmentsForHIT($Request);
	$numofAssignments = $assignments->GetAssignmentsForHITResult->NumResults;
	return $numofAssignments;
}


function getAssignmentsforHIT()
{
	$turk50 = new Turk50("AKIAITNM7AJPU4GNXGFA", "juKr+1g3SqH1Xo6N8e7+OPY8v3KL4x1R6EZkmEMJ", array("sandbox" => FALSE));	

	$HITId = $_POST["HITId1"];
    //$HITId = "3Y3N5A7N4G95VWQB5RFBQFJTWYRYMB";
	//$HITId = "37PGLWGSJT6OF8B3GXGSPEX1HC2KIU";
	//require_once("Turk50.php");
	
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
	$ratingdata = array (
		"O" => array(0, 0, 0, 0, 0, 0, 0),
		"B" => array(0, 0, 0, 0, 0, 0, 0),
		"F" => array(0, 0, 0, 0, 0, 0, 0),
		"V" => array(0, 0, 0, 0, 0, 0, 0),
	);
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
			
			if($j == 0)
			{	
				$ratingdata["O"][((int) $answer->Answer[count($answer->Answer)-1]->FreeText)-1]++;
				$ratingdata["B"][((int) $answer->Answer[0]->FreeText)-1]++;
				$ratingdata["F"][((int) $answer->Answer[1]->FreeText)-1]++;
				$ratingdata["V"][((int) $answer->Answer[2]->FreeText)-1]++;
			}

			
			$timestamp = (string) $answer->Answer[3+$j]->FreeText;
			$comment = (string) $answer->Answer[4+$j]->FreeText;
			
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
							timestamp => (string) $timestamp,
							comment => (string) $comment,
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
								timestamp => (string) $timestamp,
								comment => (string) $comment,
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
								timestamp => (string) $timestamp,
								comment => (string) $comment,
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
	
	$alldata = getRatings($alldata);
	$alldata = array($alldata, $ratingdata);
	//print("<pre>".print_r($alldata,true)."</pre>");
	echo json_encode($alldata);
	

}

function getRatings($alldata)
{
	$turk50 = new Turk50("AKIAITNM7AJPU4GNXGFA", "juKr+1g3SqH1Xo6N8e7+OPY8v3KL4x1R6EZkmEMJ", array("sandbox" => FALSE));	

	$HITId = $_POST["HITId2"];

	//$HITId = "3UYRNV2KITZWY8KT4OWH4HKR8BEN86";
	//require_once("Turk50.php");
	
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
	if($numofAssignments > 0)
	{
		for ($i = 0; $i < $numofAssignments; $i++) {
			$assignment = "";
			if($numofAssignments == 1)
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment;			
			else
				$assignment = $assignments->GetAssignmentsForHITResult->Assignment[$i];						

			$answer = $assignment->Answer;
			//$status = $assignment->AssignmentStatus;
			$answer = new SimpleXMLElement($answer);
			$assignmentId = $assignment->AssignmentId;
			
			for($j = 0; $j < count($answer->Answer); $j++)
			{
				$alldata[(int)$answer->Answer[$j]->QuestionIdentifier]['rating']+=(int)$answer->Answer[$j]->FreeText;
				//echo $answer->Answer[$j]->QuestionIdentifier;
				//$alldata[(int)$answer->Answer[$j]->QuestionIdentifier]['rating'] = "sup";
			}
		}
	}
	//print("<pre>".print_r($alldata,true)."</pre>");

	return $alldata;
}

function createHIT()
{
	$turk50 = new Turk50("AKIAITNM7AJPU4GNXGFA", "juKr+1g3SqH1Xo6N8e7+OPY8v3KL4x1R6EZkmEMJ", array("sandbox" => FALSE));

	$filepath = $_POST['datakey'];
	$Hitname ="Speech Analysis Study #".substr($filepath, -5);
	
	//require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));
	
	/*$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);*/
	
	$QualificationRequirement = array(
		array(
		"QualificationTypeId" => "000000000000000000L0",
		"Comparator" => "GreaterThan",
		"IntegerValue" => 90
		),
		array(
		"QualificationTypeId" => "00000000000000000040",
		"Comparator" => "GreaterThan",
		"IntegerValue" => 100
		)
	);
	/*$QualificationRequirement = array(
		"QualificationTypeId" => "000000000000000000L0",
		"Comparator" => "GreaterThan",
		"IntegerValue" => 90
	);*/
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui.php?dataKey=$filepath</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Please complete the survey after watching this short video. We recommend using Chrome.",
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

function createHIT2()
{
	$turk50 = new Turk50("AKIAITNM7AJPU4GNXGFA", "juKr+1g3SqH1Xo6N8e7+OPY8v3KL4x1R6EZkmEMJ", array("sandbox" => FALSE));

	$HITId = $_POST['HITId'];
	$filepath = $_POST['datakey'];
	$Hitname ="Rating Speech Analysis Study Comments  #".substr($filepath, -5);
	
	$QualificationRequirement = array(
		array(
		"QualificationTypeId" => "000000000000000000L0",
		"Comparator" => "GreaterThan",
		"IntegerValue" => 90
		),
		array(
		"QualificationTypeId" => "00000000000000000040",
		"Comparator" => "GreaterThan",
		"IntegerValue" => 100
		)
	);
	
	//require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
	//$turk50 = new Turk50("AKIAJRBPIJ5V6K6SMABQ", "rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9", array("sandbox" => FALSE));

	/*$QualificationRequirement = array(
	"QualificationTypeId" => "2F1QJWKUDD8XADTFD2Q0G6UTO95ALH",
	"Comparator" => "Exists"
	);*/
	
	// prepare question 
	$Question =  "<?xml version='1.0'?><ExternalQuestion xmlns='http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd'>
	<ExternalURL>https://www.machinteraction.com/rocspeak/turkui2.php?dataKey=$filepath&amp;HITId=$HITId</ExternalURL>
	<FrameHeight>1000</FrameHeight>
	</ExternalQuestion>";
  
	$Request = array(
	"Title" => $Hitname,
	"Description" => "Please rate the comments by their helpfulness to the speaker after watching this short video. We recommend using Chrome.",
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
	
	//print_r($CreateHITResponse);
	echo $CreateHITResponse->HIT->HITId;

}

//getAssignmentsforHIT();
if(isset($_POST['action']) && !empty($_POST['action'])) {
    $action = $_POST['action'];
    switch($action) {
        case 'createHIT' : createHIT();break;
		case 'createHIT2' : createHIT2();break;
        case 'getAssignmentsforHIT' : getAssignmentsforHIT();break;
		case 'getAssignmentsforHIT2' : getAssignmentsforHIT2();break;
        case 'approveAssignment' : approveAssignment();break;
		case 'rejectAssignment' : rejectAssignment(); break;
		case 'getCountsforHIT' : echo getCountsforHIT(); break;
    }
}

?>
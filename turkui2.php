<?php $dataKey = $_GET["dataKey"];   ?>


<!DOCTYPE html>
<html lang="en">

<head>
		<?php echo $flatuiHeaderImport; ?>
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script src= "js/jquery-ui-timepicker-addon.js"></script>
		<link rel="stylesheet" href="css/jquery-ui-timepicker-addon.css" />
		
		<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/stupidtable/0.0.1/stupidtable.min.js"></script>

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		
		<script type='text/javascript' src='https://s3.amazonaws.com/mturk-public/externalHIT_v1.js'></script>
		
		<script>
			$(function(){
				$("table").stupidtable();
				 $("#0").find("th").eq(0).click(); 
				 $("#2").find("th").eq(0).click(); 
				 $("#4").find("th").eq(0).click(); 

			});
			
		</script>
</head>
<script src="/amstockchart_3.4.5/amcharts.js" type="text/javascript"></script>
<script src="/amstockchart_3.4.5/serial.js" type="text/javascript"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/themes/light.js"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/amstock.js"></script>

<script>
	function mstoMMSS(ms){
		var totalSec = parseInt(ms, 10); // don't forget the second param
		//var hours = parseInt( totalSec / 3600 ) % 24;
		console.log(totalSec);
		var minutes = parseInt( totalSec / 60 );
		var seconds = totalSec % 60;

		var result = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
		return result;
	}
	
	var counter = 4;
	
    function addTime() {
        //var table = document.getElementById("timereference");
        //$('#timereference').append("<p class='time'><input style='float:left;' type='text' name='time"+ counter +"'> <textarea style='float:left;' name='comment" + counter + "' cols='80' rows='3'></textarea></p><div style='clear:both;'></div>");
		
		$('#timereference').append("<div class='row'>"
				+ "<div class='col-lg-2'>"
				+	"<fieldset style='float:left;'>"
				+		"<input type='radio' required name='category" + counter +"' value='1'> &nbsp &nbsp &nbsp &nbsp"
				+		"<input type='radio' required name='category" + counter +"' value='2'> &nbsp &nbsp &nbsp &nbsp" 
				+		"<input type='radio' required name='category" + counter +"' value='3'> &nbsp &nbsp &nbsp &nbsp"
				+	"</fieldset>"
				+ "</div>"
				+ "<div class = 'col-lg-10'><p class='time'><div class='input-group' style='float:left;width:200px;'><input class = 'form-control' type='text' placeholder='mm:ss' id = 'time"+ counter + "' name='time"+ counter +"'><span class='input-group-btn'> <button class='btn btn-default' type='button' onclick=getTime("+ counter +")><span class='glyphicon glyphicon-flash'></span></button></span></div><textarea  style='float:left;' name='comment" + counter + "'cols='80' rows='3'></textarea></p></div>"
				+ "</div><div style='clear:both;'></div>");
				
		counter++;
		            $(".form-control").timepicker({timeFormat: 'mm:ss'});


    }
	 
	var myVid;
	AmCharts.ready(function () {
    AmCharts.theme = AmCharts.themes.light;
    myVid = document.getElementById("sessionVideo");
	    if (myVid.duration) {
        console.log("The video duration has already been set");
        timeUpdate();
    } else {
        myVid.ondurationchange=function() {
            console.log("The video duration has changed");
            timeUpdate();
        };
    }
	
	//console.log("here it is " + myVid.currentTime);
});
var timeTracker = 0;

	function timeUpdate() {
		myVid.addEventListener("timeupdate", function(){
		//console.log("here it is " + myVid.currentTime);
		var totalSec = parseInt(myVid.duration, 10)*3; // don't forget the second param
		timeTracker++;
		//console.log("max me " + totalSec);
		//console.log(timeTracker);
		if(myVid.currentTime == myVid.duration)
		{
			if(timeTracker < totalSec)
			{
				timeTracker = 0;
				$('#mturk_info2').html("<h3 style = 'color:red'>You did not completly watch the video, please go back and start from the beggining.</h3>");
			}
			else
			{
				document.getElementById('mturk_info').style.display = 'none';
				document.getElementById('mturk_form').style.display = 'block';
			}
		}
		else
		{
			$('#mturk_info2').html("");
		}
			
        
    });}
</script>
<style>
	#videoContainer {
	position:relative;
	text-align:center;
	margin-bottom:15px;
	top: 50px;
	}
	
}
</style>


<div class="row">
<div class = "col-lg-6">
<div id="videoContainer">
		<!-- <video id="sessionVideo" width="640" style="max-width:100%" src="https://www.machinteraction.com/rocspeak/uploads/1427_2fe0dfd905ebb1c3666897a3cd03b1d0-merge.webm"  type="video/webm" controls ></video> -->
		<!-- <video id="sessionVideo" width="640" style="max-width:100%" src="https://www.machinteraction.com/rocspeak/uploads/e9d933d95ccc17df107c1eb0344ec9e5_1-merge.webm"  type="video/webm" controls ></video>-->
		 <video id="sessionVideo" width="640" style="max-width:100%" src="<?php echo "uploads/$dataKey-merge.webm"; ?>"  type="video/webm" controls >
</div></div>
 
 <div class="col-lg-6">

 <div name="mturk_info" id="mturk_info">
	<h2>The survey will appear once you have finished watching the video.</br></br> You must accept the "HIT" to submit the survey, otherwise your submission will not be recorded. Please use Chrome, you may experience issues with other browsers. (If you can't click to play the video, you might want to use ctrl- to zoom out because the the text might have been on top of the play button.)</h2>
	<div name="mturk_info2" id="mturk_info2"></div>
</div>

 <form name='mturk_form' method='post'  style = "display:none"  id='mturk_form' action='https://www.mturk.com/mturk/externalSubmit'>
			<input type='hidden' value='' name='assignmentId' id='assignmentId'/>
		<h3>Indicate all of the comments that would help the speaker in the video improve his/her speaking skills.</h3><h4>There are three categories of skills; Body Gestures, Friendliness, Volume Modulation.</h4>

<?php 


//RocSpeak keys
//AKIAJRBPIJ5V6K6SMABQ
//rENoDuUupuVZcBDulxQexu+iijbh8vQsktMjKaT9


/*function createHIT($filepath, $Hitname)
{
	//require_once("Turk50.php");    
	//$turk50 = new Turk50("AKIAJOPZ7TYPRENJQXWA", "juf3vl/qaZaaVF+H7UxJ6Hh8CQSLTA80BmwHgR3t");
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
	"Description" => "Please complete the survey after watching the video. You may complete only one of the HITs titled Speaking Skills 1, 2, 3, or 4 but not more than one, otherwise your results will be rejected.",
	"Question" => $Question,
	"Reward" => array("Amount" => "1.00", "CurrencyCode" => "USD"),
	"AssignmentDurationInSeconds" => "1200",
	"LifetimeInSeconds" => "172800",
	"Keywords" => "Speaking, Skill, MACH, Interaction, Analysis, Survey",
	"MaxAssignments" => "1",
	"QualificationRequirement" => $QualificationRequirement
	);
	
	// invoke CreateHIT
	$CreateHITResponse = $turk50->CreateHIT($Request);
	
	// return HIT ID
	//$Hitname = $_POST['Hitname'];
	//echo $Hitname;
	
	print($CreateHITresponse);
	echo $CreateHITResponse->HIT->HITId;

}

createHIT("9dbd6fdf5d071c370d83a61871ca5f4e", "Speaking Skill Analysis 1");
createHIT("9a3101ca11d8605251a476f317caf50e", "Speaking Skill Analysis 2");
createHIT("09e37e717d5787ce89b64a06a3735f5a", "Speaking Skill Analysis 3");
createHIT("23e5e2cd0648d6d45c6967b1c62b5459", "Speaking Skill Analysis 4");*/

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

//


function getAssignmentsforHIT()
{
	$HITId = $_GET["HITId"];
    //$HITId = "3Y3N5A7N4G95VWQB5RFBQFJTWYRYMB";
	//echo $HITId;
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
				<th>Least Helpful<->Most Helpful </th></thead>
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
					<td><div style='width:200px;' class='btn-group btn-group-justified' data-toggle='buttons'>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' required value=1>1
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=2>2
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=3>3
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=4>4
						</label>
						</div>
					</td>
				</tr>";
				
			
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
						echo "<tr>
								<td>".$timestamp."</td>
								<td>".$comment."</td>
							<td><div style='width:200px;' class='btn-group btn-group-justified' data-toggle='buttons'>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' required value=1>1
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=2>2
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=3>3
						</label>
						<label class = 'btn btn-default'>
							<input type='radio' name='$commentcount' value=4>4
						</label>
						</div>
								</td>
							</tr>";
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
						echo "<tr>
								<td>".$timestamp."</td>
								<td>".$comment."</td>
							<td><div style='width:200px;' class='btn-group btn-group-justified' data-toggle='buttons'>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' required value=1>1
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=2>2
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=3>3
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=4>4
									</label>
									</div>
								</td>
							</tr>";
							$commentcount++;

					}
				}
				else
				{
					if($answer->Answer[$k]->FreeText == 3)
					{
						$timestamp = $answer->Answer[$k+1]->FreeText;
						$comment = $answer->Answer[$k+2]->FreeText;
						echo "<tr>
								<td>".$timestamp."</td>
								<td>".$comment."</td>
							<td><div style='width:200px;' class='btn-group btn-group-justified' data-toggle='buttons'>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' required value=1>1
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=2>2
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=3>3
									</label>
									<label class = 'btn btn-default'>
										<input type='radio' name='$commentcount' value=4>4
									</label>
									</div>
								</td>
							</tr>";
							$commentcount++;
					
					}
				}
			}
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


getAssignmentsforHIT();
?>

			<center><p><input type='submit' id='submitButton' value='Submit' /></p>
			<script language='Javascript'>turkSetAssignmentID();</script>

			</form>
</div>
</html>
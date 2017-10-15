<?php $dataKey = $_GET["dataKey"]; ?>


<!DOCTYPE html>
<html lang="en">

<head>
		<?php echo $flatuiHeaderImport; ?>
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script src= "js/jquery-ui-timepicker-addon.js"></script>
		<link rel="stylesheet" href="css/jquery-ui-timepicker-addon.css" />

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		
		<script type='text/javascript' src='https://s3.amazonaws.com/mturk-public/externalHIT_v1.js'></script>

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
	
	$(function() {
		document.getElementsByName("category1")[0].checked = true;
		document.getElementsByName("category2")[1].checked = true;
		document.getElementsByName("category3")[2].checked = true;

		for(var i = 0; i < 3; i++)
		{
			document.getElementsByName("category1")[i].disabled = true;
			document.getElementsByName("category2")[i].disabled = true;
			document.getElementsByName("category3")[i].disabled = true;

		}
		$(".form-control").timepicker({timeFormat: 'mm:ss'});
          });
		  
	function getTime(timebox)
	{
		var id = "#time" + timebox;
		//document.write(id);
		
		$(id).val(mstoMMSS(myVid.currentTime));
		//$('#time1').val("stuff");
	}
	
	
</script>
<style>
	.time{
		margin: auto;
	}
	
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
	<h2>The survey will appear once you have finished watching the video.</br></br> You must accept the "HIT" to submit the survey, otherwise your submission will not be recorded. Please use Chrome, you may experience issues with other browsers. (If you can't click to play the video, you might want to use ctrl- to zoom out because the the text might have been on top of the play button. </h2>
	<div name="mturk_info2" id="mturk_info2"></div>
</div>


<form name='mturk_form' method='post' style = "display:none"  id='mturk_form' action='https://www.mturk.com/mturk/externalSubmit'>
			<input type='hidden' value='' name='assignmentId' id='assignmentId'/>
			
			<h3>Please provide an appropriate rating for the following features.</h3></br></br>
			

			<fieldset style="width:31%;float:left;">
				<legend>Body Gestures</legend>
				<label>Did the speaker use gestures appropriately?</label></p>
				<input type="radio" name="movement" required value="1"> 1
				<input type="radio" name="movement" value="2"> 2
				<input type="radio" name="movement" value="3"> 3
				<input type="radio" name="movement" value="4"> 4
				<input type="radio" name="movement" value="5"> 5
				<input type="radio" name="movement" value="6"> 6
				<input type="radio" name="movement" value="7"> 7 
				</p> Very inappropriate <----> Very appropriate </p>
			</fieldset>
			<
			<fieldset style="width:31%;float:left;">
				<legend>Friendliness</legend>
				<label>Did the speaker appear friendly?</label></p>
				<input type="radio" name="smile" required value="1"> 1
				<input type="radio" name="smile" value="2"> 2
				<input type="radio" name="smile" value="3"> 3
				<input type="radio" name="smile" value="4"> 4
				<input type="radio" name="smile" value="5"> 5
				<input type="radio" name="smile" value="6"> 6
				<input type="radio" name="smile" value="7"> 7
				</p> Very unfriendly <----> Very friendly </p>
			</fieldset>
			
			<fieldset style="width:31%;float:left;">
				<legend>Volume Modulation</legend>
				<label>Did the speaker modulate his/her volume appropriately? (not too loud, not too soft, etc)</label>
				<input type="radio" name="volume" required value="1"> 1
				<input type="radio" name="volume" value="2"> 2
				<input type="radio" name="volume" value="3"> 3
				<input type="radio" name="volume" value="4"> 4
				<input type="radio" name="volume" value="5"> 5
				<input type="radio" name="volume" value="6"> 6
				<input type="radio" name="volume" value="7"> 7
				</p> Very inappropriate <----> Very appropriate </p>
			</fieldset>
			
			<div style="clear:both;"></div>
			</br></br>
			<div id="timereference"> 
				<h4> For each category Body Gestures(B), Friendliness(F), and Volume Modulation(V), please provide a time stamp of the point in the video that you felt influenced your rating the most, along with a comment <b>directed to the speaker </b>(i.e You did this ...) explaining why. </h4>
				<h6> The timestamps should be formatted in mm:ss format. Examples of proper syntax for timestamps include 3:30 (3 minutes 30 seconds) and 10:03 (10 minutes 3 seconds). You may add additional timestamps and comments for any category by clicking the "Add Commentary" button. You may also click the lightning symbol to get the current timestamp of the video.</h6>
				<p> B &nbsp &nbsp &nbsp &nbsp &nbsp  F &nbsp &nbsp &nbsp &nbsp V </p> 

				<div class="row">

				<div class="col-lg-2">
					<fieldset style="float:left;">
						<input type="radio" name="category1" class='disable' value="1"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category1" class='disable' value="2"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category1" class='disable' value="3"> &nbsp &nbsp &nbsp &nbsp 
					</fieldset>
				</div> 
				<div class = "col-lg-10"><p class="time"><div class="input-group" style="float:left;width:200px;"><input class = "form-control" type="text" required placeholder="mm:ss" id = "time1"  name="time1"><span class="input-group-btn"> <button class="btn btn-default" type="button" onclick=getTime('1')><span class="glyphicon glyphicon-flash"></span></button></span></div><textarea  style="float:left;"  required name='comment1' cols='80' rows='3'></textarea></p></div>
				</div><div style="clear:both;"></div>
				<div class="row">

				<div class="col-lg-2">
					<fieldset style="float:left;">
						<input type="radio" name="category2" value="1"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category2" value="2"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category2" value="3"> &nbsp &nbsp &nbsp &nbsp 
					</fieldset>
				</div>
				<div class = "col-lg-10"><p class="time"><div class="input-group" style="float:left;width:200px;"><input class = "form-control" type="text" required placeholder="mm:ss" id = "time2"  name="time2"><span class="input-group-btn"> <button class="btn btn-default" type="button" onclick=getTime('2')><span class="glyphicon glyphicon-flash"></span></button></span></div><textarea  style="float:left;"  required name='comment2' cols='80' rows='3'></textarea></p></div>
				</div><div style="clear:both;"></div>
				<div class="row">

				<div class="col-lg-2">
					<fieldset style="float:left;">
						<input type="radio" name="category3" value="1"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category3" value="2"> &nbsp &nbsp &nbsp &nbsp 
						<input type="radio" name="category3" value="3"> &nbsp &nbsp &nbsp &nbsp 
					</fieldset>
				</div>
				<div class = "col-lg-10"><p class="time"><div class="input-group" style="float:left;width:200px;"><input class = "form-control" type="text" required placeholder="mm:ss" id = "time3"  name="time3"><span class="input-group-btn"> <button class="btn btn-default" type="button" onclick=getTime('3')><span class="glyphicon glyphicon-flash"></span></button></span></div><textarea  style="float:left;"  required name='comment3' cols='80' rows='3'></textarea></p></div>
				</div><div style="clear:both;"></div>
			</div>
			<button class='myButton' type='button' onclick=addTime()>Add Commentary</button>
			
			</br>
			</br>
			<fieldset>
				<legend>Overall Performance</legend>
				<label>What is your overall rating of the speaker's performance?</label></p>
				<input type="radio" name="overall" required value="1"> 1 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="2"> 2 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="3"> 3 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="4"> 4 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="5"> 5 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="6"> 6 &nbsp &nbsp &nbsp &nbsp 
				<input type="radio" name="overall" value="7"> 7 &nbsp &nbsp &nbsp &nbsp 
				</p> Very Poor <--------------------------------------------------> Excellent </p>
			</fieldset>
			
			
			<center><p><input type='submit' id='submitButton' value='Submit' /></p>
			<script language='Javascript'>turkSetAssignmentID();</script>

</form>
</div>
</div>
<!-- <div class="row">
  <div class="col-lg-6">
    <div class="input-group">
      <span class="input-group-btn">
        <button class="btn btn-default" type="button">Go!</button>
      </span>
      <input type="text" class="form-control">
    </div><!-- /input-group 
  </div><!-- /.col-lg-6 
  <div class="col-lg-6">
    <div class="input-group">
      <input type="text" class="form-control">
      <span class="input-group-btn">
        <button class="btn btn-default" type="button">Go!</button>
      </span>
    </div><!-- /input-group 
  </div><!-- /.col-lg-6 
</div><!-- /.row -->



</html>
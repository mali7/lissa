<?php 
include "include/vars.php";
$result = $_GET['result'];
$speechNum=$_GET['speechNum'];
$day=$_GET['day'];
$ip=$_SERVER['REMOTE_ADDR'];
$user = $_GET['user'];
$keyNumber = $_GET['keyNumber'];
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
if (!empty($_GET["debug"])) $dataKey = "debug_".$dataKey;
if (!empty($_GET["private"])) $isPrivateModeOn = "true";
else $isPrivateModeOn = "false";
$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/".$user.".txt";
$keyfile=fopen($fileName,'r');
$val= fread($keyfile,filesize($fileName));
?>
<!DOCTYPE html>
<html lang="en" onkeydown="keydown(event)" onkeyup="keyup(event)">
<head>

<style>
#status {
  width: 100%;
  color: #999999;
  text-align: center;
  position:fixed;
  bottom:0px;
  padding:5px 0;
}
#status2 {
  width: 100%;
  color: #C78737;
  
  position:fixed;
  padding:5px 0;
}
body
{
    font-size:12px;
    color:#000000;
    background-color:#ffffff;
    font-family:verdana,helvetica,arial,sans-serif;
}


</style>

<script src="https://cwilso.github.io/AudioContext-MonkeyPatch/AudioContextMonkeyPatch.js"></script>
<script src="js/RecordRTC_TryIt_New.js"></script>
<script src="js/channel.js"></script>
<script src="amcharts/serial.js"></script>
<script src="amcharts/amcharts.js"></script>

<script src="js/TryItPageSenior.js"></script>
<!-- Load the polyfill to switch-hit between Chrome and Firefox -->
<script src="js/adapter.js"></script>
<script src="https://www.amcharts.com/lib/amcharts.js" type="text/javascript"></script> 
</head>
<body>
<title><?php echo $pageTitle; ?></title>
<?php //include "include/nav.php"; ?>
  <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript">
var baseDataKey = "<?php echo $dataKey; ?>";
var isPrivateModeOn = <?php echo $isPrivateModeOn; ?>;

var datebegin=1;
setTimeout(initialize, 100);
//setTimeout(startDate(),100);
setTimeout(findkey,1000);

</script>



<div id="videoContainer" style="background:#FFFFFF;position:absolute; left:0%;width:100%;text-align:center">
  <video width=10% height="40" style="display: none;" id="localVideo" autoplay="autoplay" muted="true"/></video>

  
  <script language="JavaScript" type="text/javascript" src="https://vhss-d.oddcast.com/vhost_embed_functions_v2.php?acc=4792750&js=1"></script><script language="JavaScript" type="text/javascript">AC_VHost_Embed(4792750,window.screen.availHeight,window.screen.availWidth*0.6,'FFFFFF', 1, 1, 2386864, 0, 1, 0, '44f9eb13c7630f717dc5a7fedd62a063', 9);</script>
  
  
  <!--
   <script language="JavaScript" type="text/javascript" src="https://vhss-d.oddcast.com/vhost_embed_functions_v2.php?acc=4792750&js=1"></script><script language="JavaScript" type="text/javascript">AC_VHost_Embed(4792750,window.screen.availHeight,window.screen.availWidth*0.6,'FFFFFF',1,1, 2386865, 0,1,0,'80a93b99403d25afe7a8222be35de0a9',9);</script>
-->

  </div>
<div id="chartdiv" style="width: 0%; position: absolute; height:30%; bottom:2%; right:0% "></div>
<div id="images" style="position:fixed ; width:10%;height:30%; bottom: 70%; right:50%; visibility:hidden">
	<img src="logo.png"  ><br>
</div>
<div id= "textdiv" style="position:fixed ; width:20%;height:30%; bottom: 40%; right:0%"> </div>
<div id= "result" style="position:fixed ; width:20%;height:30%; bottom: 30%; right:0%">
<!--
<input type = "textarea" id = "instruction" ></input><br>
<input type="button" class="btn btn-primary btn-lg" value="Submit Instruction" id="instruction_button" onclick="submitInstruction()" style="width:200px;"/>
 -->
 </div>
<br>
<textarea rows="4" cols="100" id="speechtext" style="width: 0%; position: absolute;top:50%; right:0; visibility:hidden">
</textarea>
<form action="" style="width: 0%; position: absolute;top:8%; right:0">
<div style="background-color: #FF0000; color:#FFFFFF ; visibility:hidden">
<input type="checkbox" id="Movement" name="vehicle" value="Movement" checked="true" onclick="check()">Movement<br>
</div>
<div style="background-color: #1FFF00; color:#FFFFFF; visibility:hidden" >
<input type="checkbox" id="Smile" name="vehicle" value="Smile" checked="true" onclick="check()">Smile<br>
</div>
<div style="background-color: #0000FF; color:#FFFFFF; visibility:hidden">
<input type="checkbox" id="Loudness" name="vehicle" value="Loudness" checked="true" onclick="check()">Loudness
</div>
</form>
<div id="status">
	<img src="eyeContact.png" alt="eye" id= "eyePic" width="60" hspace="20" height="60" style="visibility:hidden">
	<img src="smile.png" alt="Smile" id="smilePic" width="60" hspace="20" height="60" style="visibility:hidden">
	<img src="volume.png" alt="Louder" id= "loudPic" width="60"hspace="20" height="60" style="visibility:hidden">
	<img src="body.png" alt="Move" id="movePic" width="60" height="60" style="visibility:hidden"><br>
</div>
<div id="" style="position: absolute; right:0% ;bottom:0%" >
  <input type="button" class="btn btn-primary btn-lg" value="Start " id="start_button" onclick="startRecordingAfterActive()" style="width:100px; background-color:#c78737" disabled/>
  <input type="button" class="btn btn-default btn-lg" id="stop_button" value="Stop " onclick="stopRecordingOnHangup1()" style="background-color:#c78737" disabled />
  <input type="button" class="btn btn-primary btn-lg" id="keylabel" value="key " style="background-color:#c78737"  />
  <br>
  <input type="button" class="btn btn-primary btn-lg" id="postfeedback" value="Post Analysis" onclick="postAnalysis()" style="width:290px; background-color:#c78737" disabled />
</div>
<?php echo $flatuiJSImport; ?>
</body>
</html>

<script type="text/javascript">
var wizozrunning=0;
var timecount=0;
var keyNumber ="<?php echo $keyNumber;?>";;
var maxeyestreak=0;
var maxvolumestreak=0;
var maxsmilestreak=0;
var maxbodystreak=0;
var eyestreak=0;
var volumestreak=0;
var bodystreak=0;
var smilestreak=0;
var eyePopCount=0;
var volumePopCount=0;
var bodyPopCount=0;
var smilePopCount=0;
var preveyePopCount=0;
var prevvolumePopCount=0;
var prevbodyPopCount=0;
var prevsmilePopCount=0;
var mineyeResponse=10000;
var minsmileResponse=10000;
var minbodyResponse=10000;
var minvolumeResponse=10000;
var eyeResponse=0;
var smileResponse=0;
var bodyResponse=0;
var volumeResponse=0;
var stopped=0;
var eyeUp=0;
var smileUp=0;
var bodyUp=0;
var volumeUp=0;
var speechNum=0;
var avgEyeResponse=[];
var avgSmileResponse=[];
var avgBodyResponse=[];
var avgVolumeResponse=[];
var postAnalysisButton = document.getElementById("postfeedback");
var dataReadyFileNames = [];
var session = 0;
var result = "<?php echo $result; ?>";
var speechNum= "<?php echo $speechNum; ?>";
var ip = "<?php echo $ip; ?>";
var user = "<?php echo $user; ?>";
var summary = "<?php echo $val;?>";
var day ="<?php echo $day;?>";
var talking = 0;
var getLispSpeechTimer;
var checkingCount = 0;
function vh_talkStarted (){
	talking = 1;
}
function vh_talkEnded(){ 
	talking = 0;
}
function postAnalysis(){
	//upload sesh hole endone.php te move korbe. 
	console.log("post");
	clearInterval(getLispSpeechTimer);
	var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("post analysis: "+this.responseText);
					if(this.responseText.indexOf("Done")!=-1){
						
						if(result.length>0){
							console.log("post analysis: in if"+this.responseText);
							window.location="endone.php?keyNumber="+keyNumber+"&session="+session+"&result="+result+"&speechNum="+speechNum+"&user="+user+"&dataKey="+dataKey;
						}
						else 
						{
							result = "0000";
							window.location="endone.php?keyNumber="+keyNumber+"&session="+session+"&result="+result+"&speechNum="+speechNum+"&user="+user+"&dataKey="+dataKey;
						}
					}
					else{
						checkingCount++;
						if(checkingCount%5 == 0) sayText("Please wait. I am still processing the feedback",1,1,3);
						if(checkingCount >= 300) {
							result = "0000";
							window.location="endone.php?keyNumber="+keyNumber+"&session="+session+"&result="+result+"&speechNum="+speechNum+"&user="+user+"&dataKey="+dataKey;
						}
						console.log("checking again");
						xhr.open('GET', "response.php?action=findUploadDone&user="+user+"&dataKey="+dataKey, true);
						xhr.send();
					}
				}
			}
			console.log("waiting");
		}
	xhr.open('GET', "response.php?action=findUploadDone&user="+user+"&dataKey="+dataKey, true);
	xhr.send();
	
	
	
}
function stopRecordingOnHangup1(){
	
	console.log("Stopping Speech");
	stopSpeech();
	stopRecordingOnHangup();
}
setTimeout(function(){
	setStatus(0,0,2); 
	setGaze(180,1000,15);
	followCursor(0);
	if(speechNum>0){
		console.log("speechNum = "+speechNum);
		speechNum = parseInt(speechNum) +1;
	}
	else{
		speechNum=1;
	}
	if(keyNumber>0){
		startRecordingAfterActive();
		
	}
	console.log("keyNumber from prev= "+ keyNumber);
},3000);

// setTimeout(function(){
	// console.log("result = "+result);
	// if(result.length>=1){
		// startDate();
		// startRecordingAfterActive();
	// }
// },4000);

var talking = 0;
function vh_talkStarted (){
	
	talking = 1;
}
function vh_talkEnded(){ 
	talking = 0;
}

function wizoz(){
	var messageGot=0;
	var backColor=0;
	var wizozTimer=setInterval(function(){
		
		if(document.getElementById('stop_button').disabled==true && messageGot==0){
			var xhr1 = new XMLHttpRequest();
			xhr1.onreadystatechange = function() {
				if (this.readyState == 4) {
					if (this.status == 200) {
						console.log("notes: "+this.responseText);
						document.getElementById('speechtext').value=this.responseText;
						messageGot=1;
					}
				}	
			}
			xhr1.open('GET', "response.php?action=readnote&keyNumber"+keyNumber, true);
			xhr1.send();
		}
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					//console.log(".........hay............" +this.responseText[0]+"  "+this.responseText[1]+"  "+this.responseText[2]+"  "+this.responseText[3]);
					if(this.responseText[0]=='1'){
						document.getElementById("eyePic").src="eyeContact2.png";
						eyePopCount++;
						eyeResponse++;
						eyeUp=1;
						if(eyestreak>maxeyestreak){
							maxeyestreak=eyestreak;
							eyestreak=0;
						}
					}
					else {
						document.getElementById("eyePic").src="eyeContact.png";
						if(eyePopCount>0 && eyePopCount > preveyePopCount && eyeUp==1){
							if(eyeResponse<mineyeResponse){
								mineyeResponse=eyeResponse;
								
							}
							avgEyeResponse[avgEyeResponse.length]=avgEyeResponse;
							eyeResponse=0;
							eyeUp=0;
							preveyePopCount=eyePopCount;
						}
					}
					if(this.responseText[1]=='1'){
						document.getElementById("smilePic").src="smile2.png";
						smilePopCount++;
						smileResponse++;
						if(smilestreak>maxsmilestreak){
							maxsmilestreak=smilestreak;
							smilestreak=0;
						}
					}
					else {
						document.getElementById("smilePic").src="smile.png";
						if(smilePopCount>0 && smilePopCount > prevsmilePopCount){
							if(smileResponse<minsmileResponse){
								minsmileResponse=smileResponse;
							}
							smileResponse=0;
							prevsmilePopCount=smilePopCount;
						}
					}
					if(this.responseText[2]=='1'){
						document.getElementById("loudPic").src="volume2.png";
						volumePopCount++;
						volumeResponse++;
						if(volumestreak>maxvolumestreak){
							maxvolumestreak=volumestreak;
							volumestreak=0;
						}
					}
					else {
						document.getElementById("loudPic").src="volume.png";
						if(volumePopCount>0 && volumePopCount > prevvolumePopCount){
							if(volumeResponse<minvolumeResponse){
								minvolumeResponse=volumeResponse;
							}
							volumeResponse=0;
							prevvolumePopCount=volumePopCount;
						}
					}
					if(this.responseText[3]=='1'){
						document.getElementById("movePic").src="body2.png";
						bodyPopCount++;
						bodyResponse++;
						if(bodystreak>maxbodystreak){
							maxbodystreak=bodystreak;
							bodystreak=0;
						}
					}
					else  {
						document.getElementById("movePic").src="body.png";
						if(bodyPopCount>0 && bodyPopCount > prevbodyPopCount){
							if(bodyResponse<minbodyResponse){
								minbodyResponse=bodyResponse;
								
							}
							bodyResponse=0;
							prevbodyPopCount=bodyPopCount;
						}
					}
					if(this.responseText=='0000'){
						backColor+=1;
					}
					else backColor=0;
					//console.log("backColor =  "+backColor);
					if (backColor==0){
						document.getElementById("videoContainer").style.background="#FFFFFF";
					}
					else if(backColor==10 ){
						document.getElementById("videoContainer").style.background="#DEFFC6";
					}
					else if(backColor==20 ){
						document.getElementById("videoContainer").style.background="#C7FF9E";
					}
					else if(backColor==30 ){
						document.getElementById("videoContainer").style.background="#B8FF85";
					}
					else if(backColor==40){
						document.getElementById("videoContainer").style.background="#A6FE67";
					}
					
				}
			}	
		}
		xhr.open('GET', "response.php?action=readicon&time="+timecount+"&keyNumber="+keyNumber, true);
		xhr.send();
	},500);
}
function gazeNod(){
	setTimeout(function(){
		setGaze(180,1,30);
	},100);
	setTimeout(function(){
		setGaze(180,1,10);
	},500);
	setTimeout(function(){
		setGaze(180,1,20);
	},1000);
	setTimeout(function(){
		setGaze(180,1,10);
	},1500);
	setTimeout(function(){
		setGaze(180,400,15);
	},2000);
}
function gazeNodHard(){
	setTimeout(function(){
		setGaze(180,1,30);
	},100);
	setTimeout(function(){
		setGaze(180,1,5);
	},400);
	setTimeout(function(){
		setGaze(180,1,30);
	},800);
	setTimeout(function(){
		setGaze(180,1,5);
	},1200);
	setTimeout(function(){
		setGaze(180,1,30);
	},1600);
	setTimeout(function(){
		setGaze(180,1,5);
	},2200);
	setTimeout(function(){
		setGaze(180,1,30);
	},3000);
	setTimeout(function(){
		setGaze(180,400,15);
	},3500);
}
function gazeNp(){
	setTimeout(function(){
		setGaze(230,1,25);
	},100);
	setTimeout(function(){
		setGaze(130,1,25);
	},700);
	setTimeout(function(){
		setGaze(230,1,20);
	},1400);
	setTimeout(function(){
		setGaze(130,1,20);
	},2000);
	setTimeout(function(){
		setGaze(180,400,15);
	},2500);
}
function reset(){
	stopRecordingOnHangup();
	postAnalysis();
}
function putspeech(){
	setInterval(function(){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("Speech found: "+this.responseText+" "+this.responseText.substring(0,3));
					if(this.responseText!= ""){
						if(this.responseText.substring(0,3)=="Exp"){
							//console.log("here");
							setFacialExpression(parseInt(this.responseText[3]));
						}
						else if(this.responseText.substring(0,5)=="reset"){
							//console.log("here");
							reset();
						}
						else if(this.responseText.substring(0,3)=="nod"){
							//console.log("here");
							gazeNod();
						}
						else if(this.responseText.substring(0,3)=="nHp"){
							//console.log("here");
							gazeNodHard();
						}
						else if(this.responseText.substring(0,3)=="nop"){
							//console.log("here");
							gazeNp();
						}
						else if(this.responseText.substring(0,6)=="endone"){
							end1conv(1);
						}
						else if(this.responseText.substring(0,6)=="endtwo"){
							end1conv(2);
						}
						else if(this.responseText.substring(0,8)=="endthree"){
							end1conv(3);
						}
						else if(this.responseText.substring(0,7)=="endfour"){
							end1conv(4);
						}
						else if(this.responseText.substring(0,7)=="endfive"){
							end1conv(5);
						}
						else if(this.responseText.substring(0,6)=="endsix"){
							end1conv(6);
						}
						else if(this.responseText.substring(0,8)=="endfinal"){
							end1conv(7);
						}
						else if(this.responseText.substring(0,3)=="e02"){
							end2conv();
						}
						else if(this.responseText.substring(0,3)=="e03"){
							end3conv();
						}
						else{
							//wizozrunning=1;
							console.log("Before saying");
							sayText(this.responseText,1,1,3);
							setGaze(180,400,15);
							//sayText("ha ha \\_Whistle_01 ",1,1,3);
							wizozrunning=0;
						}

					}
				}
			}	
		}
		xhr1.open('GET', "response.php?action=readspeech&keyNumber="+keyNumber, true);
		xhr1.send();
	},1000);
}
function end1conv(ses){
	// keydown(75);
	// keyup(75);
	
	postAnalysisButton.disabled = false;
	sayText("lets pause here so I can give you feedback. Please wait while I process the audio and video.",1,1,3);
	session = ses;
	console.log("from end1conv "+dataKey+" " +splitCount);
	if (recording==1) stopRecordingOnHangup1();
	postAnalysis();
	// var xhr1 = new XMLHttpRequest();
	// xhr1.onreadystatechange = function() {
		// if (this.readyState == 4) {
			// if (this.status == 200) {
				// console.log("after running java = "+this.responseText);
				// //postAnalysis();
			// }
		// }
	// }
	
	// xhr1.open('GET', "response.php?action=seniorProcess&keyNumber="+keyNumber+"&dataKey="+dataKey+"&range="+splitCount+"&session="+ses+"&user="+user, true);
	// xhr1.send();
}
function end2conv(){
	
}
function end3conv(){
	
}
function getLispSpeech(){
	getLispSpeechTimer = setInterval(function(){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("inside speechNum = "+speechNum+" "+ this.responseText);
					var lines = this.responseText.split("\n");
					for (var i = 0; i<lines.length;i++){
						var text = lines[i].split(":");
						var pre = "#"+speechNum+"";
						
						if (text[0]==pre && talking==0){
							try{
								// console.log(text[1].indexOf("lets pause here so i can give you final feedback") !== -1);
								if(text[1].substring(0,6)=="endone"){
									end1conv(1);
								}
								else if(text[1].indexOf("lets pause here so i can give you feedback") !== -1){
									end1conv(1);
								}
								else if(text[1].indexOf("lets pause here so i can give you final feedback") !== -1){
									end1conv(7);
								}
								else{
									console.log("LISSA will say: "+text[1]);
									//sayText(text[1],6,1,3);// 3,1,3
									sayText(text[1],1,1,3);
									//sayAIResponse(text[1],3,1,3);
									setGaze(180,400,15);
									speechNum+=1;
								}
							}
							catch(err){
								console.log(err.message);
							}						
						}
						else{
							
						}
					}
				}
			}	
		}
		xhr1.open('GET', "response.php?action=readspeechLisp&keyNumber="+keyNumber, true);
		xhr1.send();
	},2000);
}
function getSummaryFeedback(){
	var feedbackNames = ["Eye contact", "Volume","Smile","Content"];
	console.log("from summary"+summary);
	var feed = summary.split(" ");
	for (var i=0; i< feed.length;i++){
		console.log("Each line of summary = "+feed[i]);
	}
	var diff =[[0,0,0,0],[0,0,0,0]];
	var noChangeKeepItUp = "";
	var noChangeBad = "";
	var improve = "";
	var worse = "";

	for (var i=feed.length-1, k=0; i>=0 && i>=feed.length-2;k++, i--){
		for (var j=0;j<4;j++){
			if((i-1) >= 0){
				diff[k][j] = parseInt(feed[i][j])-parseInt(feed[i-1][j]);
			}
		}
	}
	console.log(diff[0]+" "+diff[1]);
	for (var j=0;j<4;j++){
		if (diff[0][j] == 0 && parseInt(feed[feed.length-1][j])==1){
			if (noChangeKeepItUp == ""){
				noChangeKeepItUp = noChangeKeepItUp + " " +feedbackNames[j];
			}
			else {
				noChangeKeepItUp = noChangeKeepItUp + " and " +feedbackNames[j];
			}
		}
		else if (diff[0][j] == 0 && parseInt(feed[feed.length-1][j])==0){
			if (noChangeBad == ""){
				noChangeBad = noChangeBad + " " +feedbackNames[j];
			}
			else {
				noChangeBad = noChangeBad + " and " +feedbackNames[j];
			}
		}
		else if (diff[0][j] == 1 ){
			if (improve == ""){
				improve = improve + " " +feedbackNames[j];
			}
			else {
				improve = improve + " and " +feedbackNames[j];
			}
		}
		else if (diff[0][j] == -1 ){
			if (worse == ""){
				worse = worse + " " +feedbackNames[j];
			}
			else {
				worse = worse + " and " +feedbackNames[j];
			}
		}
	}
	var statements = [" Last time we talked, it was trickier for you. Let's focus on ",
	" Last time it seemed that it was a bit challenging for you. Let's focus on ",
	" Last time you had some trouble with it. Let's focus on ",
	" Last time it didn't go as well. Let's focus on ",
	" really helps you to connect. ",
	" is important when we talk with others. ",
	" makes conversations more enjoyable. ",
	" makes conversations more engaging. "
	];
	var randworse = Math.floor((Math.random() * 4));
	console.log(randworse);
	var feedbackStatement = "Nice to meet you. Let's review what we talked about last time.";
	if (improve != ""){
		feedbackStatement = feedbackStatement + " You did well with your " + improve +". Keep it up.";
	}
	if (noChangeKeepItUp != ""){
		feedbackStatement = feedbackStatement + " You did well with your " + noChangeKeepItUp +". Keep it up.";
	}
	if (noChangeBad != ""){
		feedbackStatement = feedbackStatement + noChangeBad+ statements[randworse+4]+ " You should keep working on " + noChangeBad +".";
	}
	if (worse != ""){
		feedbackStatement = feedbackStatement + " You made improvement on "+ worse +" but "+ statements[randworse]+ worse +" today.";
	}
	console.log("Summary feedback = "+feedbackStatement);
	sayText(feedbackStatement,1,1,3);
	
}
function startDate(){
	postAnalysisButton.disabled = false;
	var scoring_seconds=[];
	var scoring_seconds_count=0;
	//wizoz();
	// speechNum=1;
	
	// getLispSpeech();
	// putspeech();
	setStatus(0,0,2); 
	setGaze(180,1000,15);
	followCursor(0);
	if(day>1){
		getSummaryFeedback();
	}
	
	getLispSpeech();
	keyNumber = document.getElementById('keylabel').value.substr(6);
	document.getElementById('keylabel').value = user;
	console.log("key ="+keyNumber);
	document.getElementById('keylabel').disabled="true";
	setIdleMovement(0,40);
	//gotoNextScene();
	setSpeechMovement(80);
	if(date>0 && date <10){
		var xhr1 = new XMLHttpRequest();
		xhr1.open('GET', "response.php?action=dateon&keyNumber="+keyNumber+"&user="+user+"&day="+day, true);
		xhr1.send();
	}
	
	
}
var chart;
var chartData = [];
var chartCursor;

var firstDate = new Date();
var graph1;
var graph2;
var graph3;
var keepGoingTimer;
var stop=1;
var json;
var json_loud;
var checkInterval=0;
firstDate.setDate(firstDate.getDate() - 500);

// generate some random data, quite different range
// function generateChartData() {
    // for (day = 0; day < 50; day++) {
		// chartData.push({
			// time: day,
			// smile:0,
			// movement:0,
			// Loudness:0
		// });
    // }
// }
function check(){
	console.log("Inside the onclick Listener");
	if(document.getElementById('Movement').checked==false)graph1.valueField="";
	else graph1.valueField="movement";
	if(document.getElementById('Smile').checked==false)graph2.valueField="";
	else graph2.valueField="smile";
	if(document.getElementById('Loudness').checked==false)graph3.valueField="";
	else graph3.valueField="Loudness";

}
// create chart
AmCharts.ready(function() {
    // generate some data first
    // generateChartData();
	
    // SERIAL CHART    
    chart = new AmCharts.AmSerialChart();
    chart.pathToImages = "https://www.amcharts.com/lib/images/";
    chart.marginTop = 0;
    chart.marginRight = 10;
    chart.autoMarginOffset = 5;
    chart.zoomOutButton = {
        backgroundColor: '#000000',
        backgroundAlpha: 0.15
    };
    chart.dataProvider = chartData;
    chart.categoryField = "time";

    // AXES
    // category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.parseDates = false; // as our data is date-based, we set parseDates to true
    categoryAxis.minPeriod = "DD"; // our data is daily, so we set minPeriod to DD
    categoryAxis.dashLength = 1;
    categoryAxis.gridAlpha = 0.15;
    categoryAxis.axisColor = "#DADADA";
	categoryAxis.labelsEnabled= false;
	
	//catagoryAxis.axisColor = "#00FFFF";

    // value                
    var valueAxis = new AmCharts.ValueAxis();
    valueAxis.axisAlpha = 0.2;
    valueAxis.dashLength = .1;
	valueAxis.minimum=0;
	valueAxis.maximum=100;
	//valueAxis.gridAlpha=1;
    chart.addValueAxis(valueAxis);

    // movement
     graph1 = new AmCharts.AmGraph();
	graph1.type="smoothedLine";
    graph1.title = "red line";
    graph1.valueField = "movement";
    graph1.bullet = "round";
    graph1.bulletBorderColor = "#FFFFFF";
    graph1.bulletBorderThickness = 1;
    graph1.lineThickness = 2;
    graph1.lineColor = "#FF0000";
    graph1.negativeLineColor = "#0352b5";
    graph1.hideBulletsCount = 30; // this makes the chart to hide bullets when there are more than 50 series in selection
    chart.addGraph(graph1);
	//if(document.getElementById('Movement').checked==true)chart.addGraph(graph);
	
	// smile 
     graph2 = new AmCharts.AmGraph();
    graph2.title = "red line";
    graph2.valueField = "smile";
    graph2.bullet = "round";
    graph2.bulletBorderColor = "#FFFFFF";
    graph2.bulletBorderThickness = 1;
    graph2.lineThickness = 2;
    graph2.lineColor = "#00FF00";
    graph2.negativeLineColor = "#0352b5";
    graph2.hideBulletsCount = 30; // this makes the chart to hide bullets when there are more than 50 series in selection
    chart.addGraph(graph2);
	//if(document.getElementById('Smile').checked==true)chart.addGraph(graph);
	
	//Loudness
	 graph3 = new AmCharts.AmGraph();
    graph3.title = "red line";
    graph3.valueField = "Loudness";
    graph3.bullet = "bubble";
    graph3.bulletBorderColor = "#FFFFFF";
    graph3.bulletBorderThickness = 1;
    graph3.lineThickness = 2;
    graph3.lineColor = "#0000FF";
    graph3.negativeLineColor = "#0352b5";
    graph3.hideBulletsCount = 30; // this makes the chart to hide bullets when there are more than 50 series in selection
    chart.addGraph(graph3);
	//if(document.getElementById('Loudness').checked==true)chart.addGraph(graph);
	
    // CURSOR
    chartCursor = new AmCharts.ChartCursor();
    chartCursor.cursorPosition = "mouse";
    chart.addChartCursor(chartCursor);

    // SCROLLBAR
    var chartScrollbar = new AmCharts.ChartScrollbar();
    //chartScrollbar.graph = graph;
    chartScrollbar.scrollbarHeight = 40;
    chartScrollbar.color = "#FFFFFF";
    chartScrollbar.autoGridCount = true;
    chart.addChartScrollbar(chartScrollbar);

    // WRITE
    chart.write("chartdiv");
});

var i = 0;                     //  set your counter to 1

function keepGoing(){

}

// function displayUpdatedemo(fileNo) {

		// stop=1;
		// json = (function () {
			// var json = null;
			// $.ajax({
					// 'async': false,
					// 'global': false,
					// 'url': "../RocSpeakRafayet/data/temporal-features-"+fileNo+"",
					// //'url': "../RocSpeakRafayet/data/average-features-"+fileNo+"",
					// 'dataType': "json",
					// 'success': function (data) {
							// json = data;
					// }
			// });
			// return json;
		// })(); 
		
		// json_loud = (function () {
			// var json_loud = null;
			// $.ajax({
					// 'async': false,
					// 'global': false,
					// //'url': "../RocSpeakRafayet/data/temporal-features-"+fileNo+"",
					// 'url': "../RocSpeakRafayet/data/average-features-"+fileNo+"",
					// 'dataType': "json",
					// 'success': function (data) {
							// json_loud = data;
					// }
			// });
			// return json_loud;
		// })(); 
		
		// for(i=0;i<json.length-1;i+=2){
			// //console.log(json[i].movement);
			// chart.dataProvider.shift();
			// day++;
			// chart.dataProvider.push({
				// time: day,
				// smile: (json[i].smile+json[i+1].smile)/2,
				// movement: (json[i].movement+json[i+1].movement)/2,
				// Loudness: json_loud[0].Loudness
			// });
			
		// }
		// //chart.validateData();
		// stop=0;

    // }


</script>
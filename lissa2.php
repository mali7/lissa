<?php 
include "include/vars.php";
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
if (!empty($_GET["debug"])) $dataKey = "debug_".$dataKey;
if (!empty($_GET["private"])) $isPrivateModeOn = "true";
else $isPrivateModeOn = "false";
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

<script src="js/TryItPageLissa.js"></script>
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
//setTimeout(findkey,1000);

</script>



<div id="videoContainer" style="background:#FFFFFF;position:absolute; left:0%;width:100%;text-align:center">
  <video width=10% height="40" style="display: none;" id="localVideo" autoplay="autoplay" muted="true"/></video>

   <script language="JavaScript" type="text/javascript" src="https://vhss-d.oddcast.com/vhost_embed_functions_v2.php?acc=4792750&js=1"></script><script language="JavaScript" type="text/javascript">AC_VHost_Embed(4792750,window.screen.availHeight,window.screen.availWidth*0.6,'FFFFFF',1,1, 2386865, 0,1,0,'80a93b99403d25afe7a8222be35de0a9',9);</script>

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
	<img src="eyeContact.png" alt="eye" id= "eyePic" width="60" hspace="20" height="60" style="visibility:visible">
	<img src="smile.png" alt="Smile" id="smilePic" width="60" hspace="20" height="60" style="visibility:visible">
	<img src="volume.png" alt="Louder" id= "loudPic" width="60"hspace="20" height="60" style="visibility:visible">
	<img src="body.png" alt="Move" id="movePic" width="60" height="60" style="visibility:visible"><br>
</div>
<div id="" style="position: absolute; right:0% ;bottom:0%" >
  <input type="button" class="btn btn-primary btn-lg" value="Start " id="start_button" onclick="startDate()" style="width:100px; background-color:#c78737" disabled/>
  <input type="button" class="btn btn-default btn-lg" id="stop_button" value="Stop " onclick="stopRecordingOnHangup()" style="background-color:#c78737" disabled />
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
var keyNumber;
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

function postAnalysis(){
	console.log("Here go to Post Analysis");
	if(stopped==111){
		window.location="post.php?keyNumber="+keyNumber;
	}
}

function wizoz(){
	var messageGot=0;
	var backColor=0;
	var wizozTimer=setInterval(function(){
		
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
			else {
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=readicon&time="+timecount+"&keyNumber="+keyNumber, true);
				xhr.send();
			}
		}
		
		xhr.open('GET', "response.php?action=readicon&time="+timecount+"&keyNumber="+keyNumber, true);
		xhr.send();
	},1000);
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
function getLispSpeech(){
	setInterval(function(){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					//console.log("Speech found: "+this.responseText+" "+this.responseText.substring(0,3));
					var lines = this.responseText.split("\n");
					//console.log("hello======"+lines[0]);
					for (var i = 0; i<lines.length;i++){
						//console.log("hello======"+lines[i]);
						var text = lines[i].split(":");
						var pre = "#"+speechNum+"";
						//console.log("text 0 ="+text[0]+" pre ="+pre);
						if (text[0]==pre){
							console.log(text[1]);
							sayText(text[1],3,1,3);
							var xhr = new XMLHttpRequest();
							xhr1.open('GET', "response.php?action=saveDialogueLisp&value="+text[1], true);
							xhr1.send();
							speechNum+=1;
						}
						else{
							
						}
					}
				}
			}	
		}
		xhr1.open('GET', "response.php?action=readspeechLisp&keyNumber="+keyNumber, true);
		xhr1.send();
	},1000);
	
}
function startDate(){
	var scoring_seconds=[];
	var scoring_seconds_count=0;
	wizoz();
	speechNum=1;
	getLispSpeech();
	//putspeech();
	//gaze();
	setStatus(0,0,2); 
	setGaze(180,1000,15);
	//setGaze(90, 1);
	followCursor(0);
	keyNumber = document.getElementById('keylabel').value.substr(6);
	console.log("key ="+keyNumber);
	document.getElementById('keylabel').disabled="true";
	setIdleMovement(0,40);
	//gotoNextScene();
	setSpeechMovement(50);
	var xhr1 = new XMLHttpRequest();
	xhr1.open('GET', "response.php?action=dateon&keyNumber="+keyNumber, true);
	xhr1.send();
	setInterval(function(){
		timecount++;
		eyestreak++;
		bodystreak++;
		smilestreak++;
		volumestreak++;
		//console.log("streaks :: "+maxeyestreak+" "+maxvolumestreak+" "+maxsmilestreak+" "+maxbodystreak);
		if(wizozrunning==0){
		}
	},1000);
}
var chart;
var chartData = [];
var chartCursor;
var day = 0;
var firstDate = new Date();
var graph1;
var graph2;
var graph3;
var keepGoingTimer;
var stop=1;
var json;
var json_loud;
var checkInterval=0;


var i = 0;      			
function keepGoing(){
}

function displayUpdatedemo(fileNo) {
}


</script>
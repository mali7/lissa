<?php 
include "include/vars.php";
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
if (!empty($_GET["debug"])) $dataKey = "debug_".$dataKey;
if (!empty($_GET["private"])) $isPrivateModeOn = "true";
else $isPrivateModeOn = "false";
?>
<!DOCTYPE html>
<html>
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

<script src="js/TryItPage2.js"></script>
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

   <script language="JavaScript" type="text/javascript" src="https://vhss-d.oddcast.com/vhost_embed_functions_v2.php?acc=4792750&js=1"></script><script language="JavaScript" type="text/javascript">AC_VHost_Embed(4792750,window.screen.availHeight,window.screen.availWidth*0.6,'FFFFFF',1,1, 2386865, 0,1,0,'80a93b99403d25afe7a8222be35de0a9',9);</script>

  </div>
<div id="chartdiv" style="width: 0%; position: absolute; height:30%; bottom:2%; right:0% "></div>
<div id="images" style="position:fixed ; width:10%;height:30%; bottom: 70%; right:50%; visibility:hidden">
	<img src="logo.png"  ><br>
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
  <input type="button" class="btn btn-primary btn-lg" value="Start " id="start_button" onclick="startRecordingAfterActive()" style="width:100px; background-color:#c78737" disabled/>
  <input type="button" class="btn btn-default btn-lg" id="stop_button" value="Stop " onclick="stopRecordingOnHangup()" style="background-color:#c78737" disabled />
  <input type="button" class="btn btn-primary btn-lg" id="keylabel" value="key " style="background-color:#c78737"  />
  <br>
  <input type="button" class="btn btn-primary btn-lg" id="postfeedback" value="Post Analysis" onclick="postAnalysis()" style="width:290px; background-color:#c78737" />
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
var avgEyeResponse=[];
var avgSmileResponse=[];
var avgBodyResponse=[];
var avgVolumeResponse=[];

function postAnalysis(){
	if(stopped==1){
	window.location="post.php?keyNumber="+keyNumber;
	}
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
function putspeech(){
	setInterval(function(){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					
					if(this.responseText!= ""){
						console.log("Speech found: "+this.responseText);
						if(this.responseText.substring(0,3)=="Exp"){
							//console.log("here");
							setFacialExpression(parseInt(this.responseText[3]));
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
						else{
							//wizozrunning=1;
							//sayText(this.responseText,3,1,3);
							
							sayText(this.responseText,3,1,3);
							// setTimeout(function (){
								
								// loadScene(07);
							// },10000);
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
	},500);
}

function startDate(){
	var scoring_seconds=[];
	var scoring_seconds_count=0;
	wizoz();
	putspeech();
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
	setSpeechMovement(100);
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
firstDate.setDate(firstDate.getDate() - 500);

// generate some random data, quite different range
function generateChartData() {
    for (day = 0; day < 50; day++) {
		chartData.push({
			time: day,
			smile:0,
			movement:0,
			Loudness:0
		});
    }
}
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
    generateChartData();
	
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
			// function mymainLoop () {
			   // //setTimeout(function () {    //  call a 3s setTimeout when the loop is called
				  // console.log('delay 5 sec');          //  your code here
				  // setIdleMovement(0, 0);
				  // recenter();
				  // i=0;
				  // //setFacialExpression(2, -1, 80);
				  // myLoop2();
				  // setIdleMovement(50, 20);
				  // //setFacialExpression(1, -1, 100);
				  // recenter();
				  // //  ..  again which will trigger another 
				  // //mymainLoop();
			   // //}, 7000)
			   // //setFacialExpression(1, -1, 100);
			// }
			
			// function myLoop () {
				// setGaze(0,.5,15);
			   // setTimeout(function () {    //  call a 3s setTimeout when the loop is called
				  // console.log('delay 1 sec');          //  your code here
				  // console.log(i);
				    // i++;
					// if (i < 3) {
						// myLoop2();             //  ..  again which will trigger another 
					// }
			   // }, 500)
			// }
			
			// function myLoop2 () {
			   // setGaze(180,.5,25);
			   // setTimeout(function () {    //  call a 3s setTimeout when the loop is called
				  // console.log('delay 11 sec');          //  your code here
				  // if (i < 3) {
					// myLoop();             //  ..  again which will trigger another 
				  // }
			   // }, 500)
			// }
			
function keepGoing(){
	// keepGoingTimer=setInterval(function(){
		// if(stop==0){
			// chart.dataProvider.shift();
			// day++;
			// chart.dataProvider.push({
				// time: day,
				// smile: json[json.length-1].smile,
				// movement: json[json.length-1].movement,
				// Loudness: json_loud[0].Loudness
			// });
			// //console.log("in keepGoing "+chart.dataProvider[30].movement +" "+day);
			// chart.validateData();
		// }
		// if(stopButton.disabled==true){
			// clearInterval(keepGoingTimer);
			// stop=1;
		// }
		// checkInterval+=1;
		// if(checkInterval>=3){
		// //sayText("welcome",1,1,1);
			// checkInterval=0;
			// var movecount=0;
			// var smilecount=0;
			// var loudcount=0;
			// for(i=30;i<60;i++){
				// movecount+=chart.dataProvider[i].movement;
				// smilecount+=chart.dataProvider[i].smile;
				// loudcount+=chart.dataProvider[i].Loudness;
				
			// }
			// if(movecount<30){
				// document.getElementById("movePic").style.visibility="visible";
			// }
			// else {
				// document.getElementById("movePic").style.visibility="hidden";
			// }
			// if(smilecount<15){
			
				// document.getElementById("smilePic").style.visibility="visible";
			// }
			// else {
				// document.getElementById("smilePic").style.visibility="hidden";
			// }
			// if(loudcount<30){
				// document.getElementById("loudPic").style.visibility="visible";
			// }
			// else {
				// document.getElementById("loudPic").style.visibility="hidden";
			// }
		// }
	
	// },1000);

}

function displayUpdatedemo(fileNo) {

		stop=1;
		json = (function () {
			var json = null;
			$.ajax({
					'async': false,
					'global': false,
					'url': "../RocSpeakRafayet/data/temporal-features-"+fileNo+"",
					//'url': "../RocSpeakRafayet/data/average-features-"+fileNo+"",
					'dataType': "json",
					'success': function (data) {
							json = data;
					}
			});
			return json;
		})(); 
		
		json_loud = (function () {
			var json_loud = null;
			$.ajax({
					'async': false,
					'global': false,
					//'url': "../RocSpeakRafayet/data/temporal-features-"+fileNo+"",
					'url': "../RocSpeakRafayet/data/average-features-"+fileNo+"",
					'dataType': "json",
					'success': function (data) {
							json_loud = data;
					}
			});
			return json_loud;
		})(); 
		
		for(i=0;i<json.length-1;i+=2){
			//console.log(json[i].movement);
			chart.dataProvider.shift();
			day++;
			chart.dataProvider.push({
				time: day,
				smile: (json[i].smile+json[i+1].smile)/2,
				movement: (json[i].movement+json[i+1].movement)/2,
				Loudness: json_loud[0].Loudness
			});
			
		}
		//chart.validateData();
		stop=0;

    }


</script>
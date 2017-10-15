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
<title><?php echo $pageTitle; ?></title>

<meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>

<link rel="stylesheet" href="css/style.css" />
<style>
#status {
  width: 100%;
  color: #999999;
  text-align: center;
  position:fixed;
  bottom:0px;
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
<script src="js/TryItPage3.js"></script>
<!-- Load the polyfill to switch-hit between Chrome and Firefox -->
<script src="js/adapter.js"></script>
<script src="https://www.amcharts.com/lib/amcharts.js" type="text/javascript"></script> 
</head>
<body>

<?php include "include/nav.php"; ?>
  

<script type="text/javascript">
var baseDataKey = "<?php echo $dataKey; ?>";
var isPrivateModeOn = <?php echo $isPrivateModeOn; ?>;
setTimeout(initialize, 1);
</script>



<div id="videoContainer" style="background:#000000;position:fixed; left:0;width:70%;text-align:center">
  <video width="100" height="40" id="localVideo" autoplay="autoplay" muted="true"/></video>
</div>
<div id="chartdiv" style="width: 30%; position: absolute; height: 30%; bottom:2%; right:0%"></div>
<div id="images" style="position:fixed ; width:20%;height:30%; bottom: 50%; right:10%">
	<img src="picMove.gif" alt="Move" id="movePic" width="350px" style="visibility:hidden">	
	<img src="picSmile.gif" alt="Smile" id="smilePic" style="visibility:hidden">
	<img src="picLoud.gif" alt="Louder" id= "loudPic"style="visibility:hidden">
	
	
</div>
<div id= "textdiv" style="position:fixed ; width:20%;height:30%; bottom: 40%; right:10%"> </div>

<form action="" style="width: 30%; position: absolute;top:8%; right:0">
<div style="background-color: #FF0000; color:#FFFFFF">
<input type="checkbox" id="Movement" name="vehicle" value="Movement" checked="true" onclick="check()">Movement<br>
</div>
<div style="background-color: #1FFF00; color:#FFFFFF" >
<input type="checkbox" id="Smile" name="vehicle" value="Smile" checked="true" onclick="check()">Smile<br>
</div>
<div style="background-color: #0000FF; color:#FFFFFF">
<input type="checkbox" id="Loudness" name="vehicle" value="Loudness" checked="true" onclick="check()">Loudness
</div>
</form>
<div id="status">
  <input type="button" class="btn btn-default btn-lg" value="Start Recording" id="start_button" onclick="startRecordingAfterActive()" disabled/>
  <input type="button" class="btn btn-default btn-lg" id="stop_button" value="Stop Recording" onclick="stopRecordingOnHangup()" disabled />
</div>
<?php echo $flatuiJSImport; ?>
</body>
</html>

<script type = "text/javascript">
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
    for (day = 0; day < 20; day++) {
        /*var newDate = new Date(firstDate);
        newDate.setDate(newDate.getDate() + day);

        var visits = Math.round(Math.random() * 40) - 20;

        chartData.push({
            date: newDate,
            visits: visits
        });*/
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
	/*if(document.getElementById('Movement').checked==false)chart.removeGraph(graph1);
	else chart.addGraph(graph1);
	if(document.getElementById('Smile').checked==false)chart.removeGraph(graph2);
	else chart.addGraph(graph2);
	if(document.getElementById('Loudness').checked==false)chart.removeGraph(graph3);
	else chart.addGraph(graph3);*/
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
	// categoryAxis.maxSeries = 20;
    categoryAxis.dashLength = 1;
    categoryAxis.gridAlpha = 0.15;
    categoryAxis.axisColor = "#DADADA";
	categoryAxis.labelsEnabled= false;
	//categoryAxis.maximum=100;
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
    graph1.hideBulletsCount = 20; // this makes the chart to hide bullets when there are more than 50 series in selection
    chart.addGraph(graph1);
	//if(document.getElementById('Movement').checked==true)chart.addGraph(graph);
	
	// smile 
     graph2 = new AmCharts.AmGraph();
	 graph2.type="smoothedLine";
    graph2.title = "red line";
    graph2.valueField = "smile";
    graph2.bullet = "round";
    graph2.bulletBorderColor = "#FFFFFF";
    graph2.bulletBorderThickness = 1;
    graph2.lineThickness = 2;
    graph2.lineColor = "#00FF00";
    graph2.negativeLineColor = "#0352b5";
    graph2.hideBulletsCount = 20; // this makes the chart to hide bullets when there are more than 50 series in selection
    chart.addGraph(graph2);
	//if(document.getElementById('Smile').checked==true)chart.addGraph(graph);
	
	//Loudness
	 graph3 = new AmCharts.AmGraph();
	 graph3.type="smoothedLine";
    graph3.title = "red line";
    graph3.valueField = "Loudness";
    graph3.bullet = "bubble";
    graph3.bulletBorderColor = "#FFFFFF";
    graph3.bulletBorderThickness = 1;
    graph3.lineThickness = 2;
    graph3.lineColor = "#0000FF";
    graph3.negativeLineColor = "#0352b5";
    graph3.hideBulletsCount = 20; // this makes the chart to hide bullets when there are more than 50 series in selection
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
    
    // set up the chart to update every second
    /*setInterval(function () {
        // normally you would load new datapoints here,
        // but we will just generate some random values
        // and remove the value from the beginning so that
        // we get nice sliding graph feeling
        
        // remove datapoint from the beginning
        chart.dataProvider.shift();
        
        // add new one at the end
        day++;
        var newDate = new Date(firstDate);
        newDate.setDate(newDate.getDate() + day);
        var visits = Math.round(Math.random() * 40) - 20;
        chart.dataProvider.push({
            date: newDate,
            visits: visits
        });
        chart.validateData();
    }, 1000);*/
});

function keepGoing(){
	keepGoingTimer=setInterval(function(){
		if(stop==0){
			chart.dataProvider.shift();
			day++;
			if(json[json.length-1].smile>0)json[json.length-1].smile-=0.2;
			if(json[json.length-1].movement>0)json[json.length-1].movement-=0.2;
			if(json[json.length-1].Loudness>0)json_loud[0].Loudness-=0.2;
			chart.dataProvider.push({
				time: day,
				smile: json[json.length-1].smile,
				movement: json[json.length-1].movement,
				Loudness: json_loud[0].Loudness
			});
			//console.log("in keepGoing "+chart.dataProvider[30].movement +" "+day);
			chart.validateData();
		}
		if(stopButton.disabled==true){
			clearInterval(keepGoingTimer);
			stop=1;
		}
		checkInterval+=1;
		if(checkInterval>=3){
			checkInterval=0;
			var movecount=0;
			var smilecount=0;
			var loudcount=0;

			for(i=0;i<30;i++){
				movecount+=chart.dataProvider[i].movement;
				smilecount+=chart.dataProvider[i].smile;
				loudcount+=chart.dataProvider[i].Loudness;
			}
			//console.log(" dataprovider = "+chart.dataProvider.length);
			//console.log("Movecount = "+movecount+" smilecount = "+smilecount+" loudcount = "+loudcount);
			if(movecount<30){
				document.getElementById("movePic").style.visibility="visible";
			}
			else {
				document.getElementById("movePic").style.visibility="hidden";
			}
			if(smilecount<15){
			
				document.getElementById("smilePic").style.visibility="visible";
			}
			else {
				document.getElementById("smilePic").style.visibility="hidden";
			}
			if(loudcount<30){
				document.getElementById("loudPic").style.visibility="visible";
			}
			else {
				document.getElementById("loudPic").style.visibility="hidden";
			}
		}
	
	},500);

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
			
		}chart.validateData();
		stop=0;

    }

</script>
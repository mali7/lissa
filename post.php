<?php 
include "include/vars.php";
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
if (!empty($_GET["debug"])) $dataKey = "debug_".$dataKey;
if (!empty($_GET["private"])) $isPrivateModeOn = "true";
else $isPrivateModeOn = "false";
$keyNumber=$_GET['keyNumber'];
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
body
{
    font-size:12px;
    color:#000000;
    background-color:#ffffff;
    font-family:verdana,helvetica,arial,sans-serif;
}
#chartdiv {
	width		: 100%;
	height		: 200px;
	font-size	: 11px;
}	

</style>

<script src="https://cwilso.github.io/AudioContext-MonkeyPatch/AudioContextMonkeyPatch.js"></script>
<script src="js/RecordRTC_TryIt_New.js"></script>
<script src="js/channel.js"></script>
<script src="amcharts/serial.js"></script>


<script src="amcharts.js"></script>
<script src="pie.js"></script>
<script src="amcharts/theme/none.js"></script>

<script src="js/TryItPageLissa.js"></script>
<!-- Load the polyfill to switch-hit between Chrome and Firefox -->
<script src="js/adapter.js"></script>
<script src="https://www.amcharts.com/lib/amcharts.js" type="text/javascript"></script> 

<script type="text/javascript" src="https://www.amcharts.com/lib/3/amcharts.js"></script>

<script type="text/javascript" src="https://www.amcharts.com/lib/3/pie.js"></script>

<script type="text/javascript" src="https://www.amcharts.com/lib/3/themes/none.js"></script>
<script type="text/javascript" src="https://www.amcharts.com/lib/3/serial.js"></script>

<title><?php echo $pageTitle; ?></title>
<?php //include "include/nav.php"; ?>
  <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>
<link rel="stylesheet" href="css/style.css" />

<div id="images" style="position:absolute ; width:10%;height:30%; bottom: 70%; right:50%">
	<img src="logo.png"  >
</div>

<table border="0" style="width:100% ;  margin-top:100px; margin-left:10px;">
  <tr>
    <td>
		<h6>Reminder</h6>
		<h6 style="font-size:15px">A reminder is when an icon flashes, prompting you<br> to adjust your behaviour in that domain.</h6>
		<div id="chartdiv" style="width: 35%; height: 30% ; position: absolute;   left:0% "></div>
	</td>
    <td>
		<h6 style="width: 33%; height:30% ; position: absolute;  left:30%; top: 104px">Perfect Streaks</h6><br><br>
		<h6 style="font-size:15px ; position: absolute;  left:30%; top: 142px">A perfect streak is the period of time during your<br> session when your behaviour didn't need adjusting</h6>
		<br>
		<div id="chartdiv1" style="width: 33%; height:30% ; position: absolute;  left:30%"></div>
	</td>	
	<td>
		<h6 id="RtF1" style="width: 33%; height:30% ; position: absolute;  left:66% ; top: 104px">Response to Feedback</h6><br><br>
		
		<h6 style="font-size:15px ; position: absolute;  left:66%; top: 142px">Shown below is the average time it takes for you to process a behaviour reminder and adjust accordingly </h6>
		<br>
		<div id="chartdiv4" style="width: 33%; height:30% ; position: absolute;  left:66%"></div>
	</td>
  </tr>


</table>
<div style="position:absolute ; width:70%;height:30%; top: 55%; left:1%">
	<h6>Enter your previous key </h6>
	<input type = "text" value="" id="keyNumber2">
	<input type = "submit" class="btn btn-primary btn-lg"  value = "submit" onclick="getkeyNumber2()">
</div>

<table id="table2" style="width:100% ;  margin-top:300px; margin-left:10px; visibility:hidden">
  <tr>
    <td>
		<h6>Reminder</h6>
		<h6 style="font-size:15px">A reminder is when an icon flashes, prompting you<br> to adjust your behaviour in that domain.</h6>
		<div id="chartdiv2" style="width: 33%; height: 30% ; position: absolute;   left:0% "></div>
	</td>
    <td>
		<h6 style="width: 33%; height:30% ; position: absolute;  left:30%; top: 500px">Perfect Streaks</h6><br><br>
		<h6 style="font-size:15px ; position: absolute;  left:30%; top: 547px">A perfect streak is the period of time during your<br> session when your behaviour didn't need adjusting</h6>
		<br>
		<div id="chartdiv3" style="width: 33%; height:30% ; position: absolute;  left:30%"></div>
	</td>
	<td>
		<h6 id="RtF1" style="width: 33%; height:30% ; position: absolute;  left:66% ; top: 500px">Response to Feedback</h6><br><br>
		<h6 style="font-size:15px ; position: absolute;  left:66%; top: 547px">Shown below is the average time it takes for you to process a behaviour reminder and adjust accordingly </h6>
		<br>
		<div id="chartdiv5" style="width: 33%; height:30% ; position: absolute;  left:66%"></div>
	</td>	
  </tr>

</table>

</head>
<script>
var keyNumber = "<?php echo $keyNumber; ?>";
var postvalues = "<?php 
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/post".$keyNumber.".txt";
	$filetoread = fopen ($fileName, "r");
	echo fread($filetoread,filesize($fileName));
	fclose($filetoread);
 ?>";
console.log(" "+keyNumber+" "+ postvalues+ " - "+postvalues.split(" ")[4]);

var chart1;
var chart2;
var keyNumber2;



setTimeout(function(){
	var chart = AmCharts.makeChart("chartdiv", {
		"type": "pie",
		//"theme": "none",
		//"pathToImages": "C:/inetpub/wwwroot/RocSpeakRafayet/",
		"dataProvider": [{
			"title": "Eye Contact",
			"value": parseInt(postvalues.split(" ")[4]),
			"colorF": "#FF00FF"
		}, {
			"title": "Volume",
			"value": parseInt(postvalues.split(" ")[5]),
			"colorF": "#FFFF00"
		},{
			"title": "smile",
			"value": parseInt(postvalues.split(" ")[6]),
			"colorF": "#FF00FF"
		},{
			"title": "Body\nMovement",
			"value": parseInt(postvalues.split(" ")[7]),
			"colorF": "#FF00FF"
		}],
			"titleField": "title",
			"valueField": "value",
			"labelRadius": 5,
			"fillColorsField":"colorF",
			
			"radius": "42%",
			"innerRadius": "60%",
			"labelText": "[[title]]"
	});

	var chart1 = AmCharts.makeChart("chartdiv1", {
		"type": "serial",
		"theme": "none",  
		"handDrawn":false,
		"handDrawScatter":6,
		"legend": {
			"useGraphSettings": true,
			"markerSize":0,
			"valueWidth":0,
			"verticalGap":0
		},
		"dataProvider": [{
			"Title": "Eye Contact",
			"value": parseInt(postvalues.split(" ")[0]),
			"colorF": "#FF0000"
		}, {
			"Title": "Volume",
			"value": parseInt(postvalues.split(" ")[1]),
			"colorF": "#FF7700"
		}, {
			"Title": "Smile",
			"value": parseInt(postvalues.split(" ")[2]),
			"colorF": "#FFAA00"
		}, {
			"Title": "Body\nMovement",
			"value": parseInt(postvalues.split(" ")[3]),
			"colorF": "#FFFF00"
		}],
		"valueAxes": [{
			"minorGridAlpha": 0.08,
			"minorGridEnabled": true,
			"position": "top",
			"axisAlpha":0
		}],
		"startDuration": 1,
		"graphs": [{
			"balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b></span>",
		//	"title": "Title",
			"type": "column",
			"fillAlphas": 0.8,
			"fillColorsField":"colorF",
			"valueField": ["value"]
		}],
		"rotate": true,
		"categoryField": "Title",
		"categoryAxis": {
		"gridPosition": "start"
		}
	});
	var chart1 = AmCharts.makeChart("chartdiv4", {
		"type": "serial",
		"theme": "none",  
		"handDrawn":false,
		"handDrawScatter":6,
		"legend": {
			"useGraphSettings": true,
			"markerSize":0,
			"valueWidth":0,
			"verticalGap":0
		},
		"dataProvider": [{
			"Title": "Eye Contact",
			"value": parseInt(postvalues.split(" ")[8]),
			"colorF": "#FF0000"
		}, {
			"Title": "Volume",
			"value": parseInt(postvalues.split(" ")[9]),
			"colorF": "#FF7700"
		}, {
			"Title": "Smile",
			"value": parseInt(postvalues.split(" ")[10]),
			"colorF": "#FFAA00"
		}, {
			"Title": "Body Movement",
			"value": parseInt(postvalues.split(" ")[11]),
			"colorF": "#FFFF00"
		}],
		"valueAxes": [{
			"minorGridAlpha": 0.08,
			"minorGridEnabled": true,
			"position": "top",
			"axisAlpha":0
		}],
		"startDuration": 1,
		"graphs": [{
			"balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b></span>",
		//	"title": "Title",
			"type": "column",
			"fillAlphas": 0.8,
			 "fillColorsField":"colorF",
			"valueField": "value"
		}],
		"rotate": false,
		"categoryField": "Title",
		"categoryAxis": {
		"gridPosition": "start"
		}
	});
	var xhr1 = new XMLHttpRequest();
	xhr1.open('GET', "response.php?action=savebackup&keyNumber="+keyNumber+"&postvalues="+postvalues, true);
	xhr1.send();
},500);

function getkeyNumber2(){
	keyNumber2=parseInt(document.getElementById("keyNumber2").value);
	console.log(keyNumber2);
	var postvalues2 = "<?php echo $_GET["keyNumber2"]; ?>";
	console.log(postvalues2);
	var xhr1 = new XMLHttpRequest();
	xhr1.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				console.log("Post: "+this.responseText);
				postvalues2=this.responseText;
				if(postvalues2.split(" ")[0]=='0'&& postvalues2.split(" ")[1]=='0'){
					getvaluefromBackup();
				}
			}
		}	
	}
	
	xhr1.open('GET', "response.php?action=readpost&keyNumber="+keyNumber2, true);
	xhr1.send();
	function getvaluefromBackup(){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("Post: "+this.responseText);
					postvalues2=this.responseText;
				}
			}	
		}
		
		xhr1.open('GET', "response.php?action=readpostbackup&keyNumber="+keyNumber2, true);
		xhr1.send();
	}
	setTimeout(function(){
		document.getElementById("table2").style.visibility="visible";
		var chart = AmCharts.makeChart("chartdiv2", {
		"type": "pie",
		"theme": "none",
		"pathToImages": "C:/inetpub/wwwroot/RocSpeakRafayet/",
		"dataProvider": [{
			"title": "Eye Contact",
			"value": parseInt(postvalues2.split(" ")[4])
			
		}, {
			"title": "Volume",
			"value": parseInt(postvalues2.split(" ")[5])
		},{
			"title": "smile",
			"value": parseInt(postvalues2.split(" ")[6])
		},{
			"title": "Body\nMovement",
			"value": parseInt(postvalues2.split(" ")[7])
		}],
			"titleField": "title",
			"valueField": "value",
			"labelRadius": 5,
			
			"radius": "42%",
			"innerRadius": "60%",
			"labelText": "[[title]]"
	});

	var chart1 = AmCharts.makeChart("chartdiv3", {
		"type": "serial",
		"theme": "none",  
		"handDrawn":false,
		"handDrawScatter":6,
		"legend": {
			"useGraphSettings": true,
			"markerSize":0,
			"valueWidth":0,
			"verticalGap":0
		},
		"dataProvider": [{
			"Title": "Eye Contact",
			"value": parseInt(postvalues2.split(" ")[0]),
			"colorF": "#FF0000"
		}, {
			"Title": "Volume",
			"value": parseInt(postvalues2.split(" ")[1]),
			"colorF": "#FF7700"
		}, {
			"Title": "Smile",
			"value": parseInt(postvalues2.split(" ")[2]),
			"colorF": "#FFAA00"
		}, {
			"Title": "Body\nMovement",
			"value": parseInt(postvalues2.split(" ")[3]),
			"colorF": "#FFFF00"
		}],
		"valueAxes": [{
			"minorGridAlpha": 0.08,
			"minorGridEnabled": true,
			"position": "top",
			"axisAlpha":0
		}],
		"startDuration": 1,
		"graphs": [{
			"balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b></span>",
		//	"title": "Title",
			"type": "column",
			"fillAlphas": 0.8,
			"fillColorsField":"colorF",
			"valueField": "value"
		}],
		"rotate": true,
		"categoryField": "Title",
		"categoryAxis": {
		"gridPosition": "start"
		}
	});
	var chart1 = AmCharts.makeChart("chartdiv5", {
		"type": "serial",
		"theme": "none",  
		"handDrawn":false,
		"handDrawScatter":6,
		"legend": {
			"useGraphSettings": true,
			"markerSize":0,
			"valueWidth":0,
			"verticalGap":0
		},
		"dataProvider": [{
			"Title": "Eye Contact",
			"value": parseInt(postvalues2.split(" ")[8]),
			"colorF": "#FF0000"
		}, {
			"Title": "Volume",
			"value": parseInt(postvalues2.split(" ")[9]),
			"colorF": "#FF7700"
		}, {
			"Title": "Smile",
			"value": parseInt(postvalues2.split(" ")[10]),
			"colorF": "#FFAA00"
		}, {
			"Title": "Body Movement",
			"value": parseInt(postvalues2.split(" ")[11]),
			"colorF": "#FFFF00"
		}],
		"valueAxes": [{
			"minorGridAlpha": 0.08,
			"minorGridEnabled": true,
			"position": "top",
			"axisAlpha":0
		}],
		"startDuration": 1,
		"graphs": [{
			"balloonText": "<span style='font-size:13px;'>[[title]] in [[category]]:<b>[[value]]</b></span>",
		//	"title": "Title",
			"type": "column",
			"fillAlphas": 0.8,
			"fillColorsField":"colorF",
			"valueField": "value"
		}],
		"rotate": false,
		"categoryField": "Title",

		"categoryAxis": {
		"gridPosition": "start"
		}
	});
	
	},1000);
}
</script>

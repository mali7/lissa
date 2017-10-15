<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/style.css" />
<style>
#chartdiv {
	width		: 100%;
	height		: 500px;
	font-size	: 11px;
}	
</style>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script src="https://www.amcharts.com/lib/3/gantt.js"></script>
<div style="position:relative">
	<video id = "videocontainer" onplay = "playing()" width=25% height=20% style="text-align:center;" controls>
		<source id = "vsrc" src="502.mp4"  >
	</video>
</div >

<div id="chartdiv" style ="position:absolute; top:0%; left:25% ;width:75%"></div>
<br>
<select onchange= "videoselect()" id = "videoname">
	<option value = "1">Select a Video</option>
	<option value = "341">341</option>
	<option value = "342">342</option>
	<option value = "345">345</option>
	<option value = "347">347</option>
	<option value = "354">354</option>
	<option value = "355">355</option>
	<option value = "432">432</option>
	<option value = "440">440</option>
	<option value = "441">441</option>
	<option value = "448">448</option>
	<option value = "449">449</option>
	<option value = "453">453</option>
	<option value = "454">454</option>
	<option value = "461">461</option>
	<option value = "466">466</option>
	<option value = "481">481</option>
	<option value = "483">483</option>
	<option value = "486">486</option>
	<option value = "491">491</option>
	<option value = "493">493</option>
	<option value = "494">494</option>
	<option value = "496">496</option>
	<option value = "497">497</option>
	<option value = "498">498</option>
	<option value = "502">502</option>
	<option value = "353">353</option>
	<option value = "350">350</option>
	<option value = "271">271</option>
	<option value = "264">264</option>
	<option value = "267">267</option>
	<option value = "270">270</option>

	<option value = "462">462</option>
	<option value = "464">464</option>
	<option value = "433">433</option>
	<option value = "431">431</option>
	<option value = "435">435</option>
	<option value = "426">426</option>
	<option value = "423">423</option>
	<option value = "419">419</option>
	<option value = "424">424</option>
</select>	
<select onchange= "typeselect()" id = "type">
	<option value = "1">Select a type</option>
	<option value = "eye">Eye Contact</option>
	<option value = "volume">Volume</option>
	<option value = "body">Body Movement</option>
	<option value = "smile">Smile</option>
</select>	
<select onchange= "idselect()" id = "id">
	<option value = "1">Select an ID</option>
	<option value = "EMR">Eibhlin (EMR)</option>
	<option value = "Jamiee">Jamiee</option>
	<option value = "Nicole">Nicole</option>
	<option value = "Shelby">Shelby</option>
	<option value = "VB">Vanessa(VB)</option>
	<option value = "Berger">Sarah(Berger)</option>
</select>
<br>	
<select onchange= "roundselect()" id = "round">
	<option value = "100">Select Round Number</option>
	<option value = "0">1</option>
	<option value = "1">2</option>
	<option value = "2">3</option>
	<option value = "3">4</option>
	<option value = "4">5</option>
	<option value = "5">6</option>
</select>
<button type="submit" onclick="get()" > Submit </button><br>
<input type = "text" id = "time" style = "font-size:30px; left:20%; top:80%"></input>
<script type="text/javascript">
//AmCharts.useUTC = true;
var json;
var vidNum;
var type;
var container = document.getElementById("videocontainer");
var time = document.getElementById("time");
var id;
var round;

function videoselect(){
	vidNum = document.getElementById("videoname").value;
	console.log(vidNum);
	container.src = vidNum+".mp4"; 
	container.load();
	document.getElementById("videoname").disabled = true;
}
function typeselect(){
	type = document.getElementById("type").value;
	console.log(type);
	document.getElementById("type").disabled = true;
}
function idselect(){
	id = document.getElementById("id").value;
	console.log(id);
}
function roundselect(){
	round = document.getElementById("round").value;
	console.log(round);
}

var chart = AmCharts.makeChart( "chartdiv", {
	"type": "gantt",
    "theme": "light",
	//"marginRight": 50,
	"period": "mm",
    "dataDateFormat":"MM-HH-SS",
	"balloonDateFormat": "MM:SS",
	"columnWidth": 0.5,
	"mouseWheelZoomEnabled" : true,
	"zoomOutButton" : {
        "backgroundColor": '#000000',
        "backgroundAlpha": 0.15
    },
	"dataProvider":[ {
		"category": "John",
		"segments": [ {
				"start": 3,
				"duration": 2,
				"color": "#7B742C",
				"task": "Task #1"
			}, {
				"duration": 2,
				"color": "#7E585F",
				"task": "Task #2"
			}, {
				"duration": 2,
				"color": "#CF794A",
				"task": "Task #3"
			} ]
		}
	],
	"valueAxis": {
		"type": "date",
		"minPeriod":"mm",
		"minimum": 0,
		"maximum": 600
	},
	
	"brightnessStep": 10,
	"graph": {
		"fillAlphas": 1,
		"balloonText": "<b>[[color]]</b>"
	},
	"rotate": true,
	"categoryField": "category",
	"segmentsField": "segments",
	"colorField": "color",
	"startDate": "2015-01-01",
	"startField": "start",
	"endField": "end",
	"durationField": "duration",
	"chartScrollbar": {},
	"chartCursor": {
		"valueBalloonsEnabled": false,
		"cursorAlpha": 0.1,
		"valueLineBalloonEnabled": true,
		"valueLineEnabled": true,
		"fullWidth": true
	},
    "export": {
    	"enabled": true
     }
} );
var count =0;
function get(){
	console.log("../RocSpeakRafayet/RALabelJson/"+type+""+vidNum+"-"+id+".json");
	if (count==0){chart.dataProvider.pop();}
	count++;
	json = (function () {
		var json = null;
		$.ajax({
				'async': false,
				'global': false,
				'url': "../RocSpeakRafayet/RALabelJson/"+type+""+vidNum+"-"+id+".json",
				'dataType': "json",
				'success': function (data) {
						json = data;
				}
		});
		return json;
	})(); 
	console.log(json[0].category);
	if (json == null){
		time.value = "FILE NOT FOUND";
		
	}
	chart.dataProvider.push({
			category: json[round].category,
			segments: json[round].segments
		});
		
	chart.validateData();
	
}
function playing(){
	setInterval(function(){
		if (container.paused == false){
			console.log(container.currentTime);
			var dt = new Date(container.currentTime);
			//console.log(dt);
			//chart.chartCursor.showCursorAt(dt);
			var min = parseInt(container.currentTime, 10);
			var sec = min%60;
			min = min/60;
			min  = Math.floor(min);
			console.log(min +":" +sec);
			if (sec<10){
				time.value = min +":0" +sec;
			}
			else{
				time.value = min +":" +sec;
			}
			
		}
		
	},1000);
	
}
</script>
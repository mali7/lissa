<?php 
include "include/vars.php";
$dataKey = $_GET["dataKey"];
if (isset($_SESSION["$dataKey-averageFeatures"])) $sessionAverageFeatures = $_SESSION["$dataKey-averageFeatures"];
if (isset($_SESSION["$dataKey-serialChartData"])) $sessionSerialChartData = $_SESSION["$dataKey-serialChartData"];
if (isset($_SESSION["$dataKey-audioAlignmentChartData"])) $sessionAudioAlignmentChartData = $_SESSION["$dataKey-audioAlignmentChartData"];
if (isset($_SESSION["$dataKey-wordProsodyData"])) $sessionWordProsodyData = $_SESSION["$dataKey-wordProsodyData"];
if (isset($_SESSION["$dataKey-mergedVideo"])) $sessionMergedVideo = $_SESSION["$dataKey-mergedVideo"];
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<title><?php echo $pageTitle; ?></title>
<?php echo $flatuiHeaderImport; ?>
</head>

<body>
<?php 
include "include/nav.php";

if (empty($_GET["dataKey"])) {
?>
<div class="jumbotron">
<div class="container">
<h2>Look up feedback from past sessions:</h2>
<form action="feedback.php" method="get">
<div class="form-group">
<div class="input-group input-group-hg">                               
  <input type="text" name="dataKey" class="form-control" placeholder="Session ID" maxlength="100">
  <span class="input-group-btn">
    <button type="submit" class="btn"><span class="fui-search"></span></button>
  </span>
</div>
</div>
  </form>
  </div>
</div>
<div class="container">
<?php } else if (!(file_exists("data/average-features-$dataKey.txt") or isset($sessionAverageFeatures))) { ?>
<div class="jumbotron">
  <div class="container">
  <h2>Invalid Session ID</h2>
  <p>We could not find any feedback associated with the session ID <b>"<?php echo  htmlentities($dataKey); ?>"</b> at this time.<br/>You can try searching again.</p>
  <form action="feedback.php" method="get">
  <div class="form-group">
      <div class="input-group input-group-hg">
          <input type="text" name="dataKey" class="form-control" placeholder="Session ID" maxlength="100">
          <span class="input-group-btn">
            <button type="submit" class="btn"><span class="fui-search"></span></button>
          </span>
      </div>
  </div>
  </form>
  </div>
</div>
<div class="container">
<?php } else { ?>
<style>
#serialChartdiv .amChartsLegend {
background:#f2f2f2;
background:linear-gradient(#f8f8f8,#f2f2f2);
border:solid 1px #d8d8d8;
border-bottom:0;
display:block;
border-radius:3px 3px 0 0;
margin-top:5px;
}
#transcriptLegendDiv {
text-align:left;
width:100%;
font-size: 0.86em;
}
#transcriptLegendDiv span {
padding : 2px 3px;
border-radius: 2px;
cursor: default;
display: inline-block;
}
.barChartdiv {
width:25%;
height:200px;
float:left
}
#overallFeedbackContainer {
clear:both;
}
#videoContainer {
position:relative;
text-align:center;
margin-bottom:15px;
}
.amChartsPeriodSelector {
font-size:14px;
}
.amChartsPeriodSelector input[type=button] {
margin-left:3px;
}
@media(max-width: 480px) {
    .barChartdiv {
    width:100%;
    height:150px;
    }
}
@media(min-width:481px) and (max-width: 979px) {
    .barChartdiv {
    width:50%;
    }
}
@media(min-width: 980px) and (max-width: 1199px) {
    .barChartdiv {
    width:25%;
    }
}
@media(min-width: 1200px) {
    #videoContainer {
    position:fixed;
    margin: 0 15px;
    }
    #videoContainer video {
    width:auto;
    }
}
</style>
<div class="jumbotron">
</div>
<div class="container">
<div class="row">
    <div class="col-lg-4" style="position:relative">
    <div id="videoContainer">
        <video id="sessionVideo" width="640" style="max-width:100%" src="<?php if (isset($sessionMergedVideo)) echo $sessionMergedVideo; else echo "uploads/$dataKey-merge.webm"; ?>"  type="video/webm" controls ></video>
    </div>
    </div>
    
    <div class="col-lg-8">
    <div id="feedbackContainer">
        <div style="position:absolute;z-index:1;">
            <label  class="checkbox" for="playVisibleRegionOnlyCheckbox"><input type="checkbox" id="playVisibleRegionOnlyCheckbox" data-toggle="checkbox"/> Play the region visible in the graph only?</label>
        </div>
        <div id="vidPositionIndicator" style="position:absolute;background:#000000;height:30px;width:4px;margin-top:44px"></div>
        <div style="width:40px;background:#fbfbfb;border:solid 1px #d8d8d8;height:165px;position:absolute;margin-top:118px"></div>
        <div style="width:40px;background:#fbfbfb;border:solid 1px #d8d8d8;height:165px;position:absolute;margin-top:118px;margin-left:40px"></div>
        <div id="serialChartdiv" style="height: 300px;"></div>
        <!--div style="position:absolute;bottom:70px;width:179px;">
            <button id="playVideoButton" class="btn btn-primary btn-lg" onclick="toggleVideoPlay()"><span class="icomoon-play2"></span></button>
            <button id="videoVolumeButton" class="btn btn-primary btn-lg" onclick="toggleVideoVolume()"><span class="icomoon-volume-high"></span></button>
            <input id="videoVolumeSlider" type="range" min="0" max="1" step="0.1" value="1"/>
        </div-->
        <p style="font-size:18px;color:#878586;margin-top:10px;text-align:left;margin-bottom:0;padding-top:5px;background:#f2f2f2;background:linear-gradient(#f8f8f8,#f2f2f2);border:solid 1px #d8d8d8;border-radius:3px 3px 0 0;padding-left:10px">Word Loudness <span id="wordProsodyValue" style="margin-left:40px;"></span></p>
        <div style="position:relative">
            <div id="averageLoudnessLine" style="border-top:dashed 1px red;position:absolute;width:100%;text-align: right;font-size: 12px;line-height: normal;margin-top:4px"><span style="position:relative;bottom:14px;padding-right:5px">Average Loudness = <?php 
            if (isset($sessionAverageFeatures)) {
              $averageFeatures = json_decode($sessionAverageFeatures);
            } else {
              $averageFeatures = json_decode(file_get_contents("data/average-features-$dataKey.txt")); 
            }
            echo round($averageFeatures[0]->Loudness,1); 
            ?></span></div>
        </div>
        <div style="width:100%;height:150px;overflow:hidden">
            <div id="transcriptChartdiv" style="height:150px;position:relative;text-align:left"></div>
            <div id="transcriptChartCursor" style="position:absolute;height:132px;width:1px;background:#000000;margin-top:-150px;pointer-events:none"></div>
        </div>
        <div id="transcriptLegendDiv"></div>
    </div>
    <!--div id="overallFeedbackContainer">
        <h4>Overall Averages</h4>
        <div id="barChartdiv1" class="barChartdiv"></div>
        <div id="barChartdiv2" class="barChartdiv"></div>
        <div id="barChartdiv3" class="barChartdiv"></div>
        <div id="barChartdiv4" class="barChartdiv"></div>
        <div style="clear:both"></div>
    </div-->
    <!--div class="hero-unit">
    <style>
    blockquote {
    text-align:justify;
    border:none;
    padding-left:70px;
    position: relative;
    }
    blockquote:before {
    content: "\201C"; /*Unicode for Left Double Quote*/
    /*Font*/
    font-family: Georgia, serif;
    font-size: 120px;
    font-weight: bold;
    color: #999;
    position: absolute;
    left:0;
    top: 36px;
    }
    </style>
        <h2>Subjective Feedback</h2>
        <h3 style="text-align:left">Feedback 1:</h3>
        <blockquote>
            <p>Feedback here. Example: Don't start with "Thank you for that kind introduction." Start with a bang! Give the audience a startling statistic, an interesting quote, a news headline - something powerful that will get their attention immediately.</p>
        </blockquote>
    </div-->
    </div>
</div>
<hr>
<?php } ?>
    <footer>
    <?php echo $footerContent; ?>
    </footer>
</div>
<!-- /container -->

<?php echo $flatuiJSImport; ?>


<?php if (!empty($_GET["dataKey"]) and (file_exists("data/average-features-$dataKey.txt") or isset($sessionAverageFeatures))) { ?>
<script src="/amstockchart_3.4.5/amcharts.js" type="text/javascript"></script>
<script src="/amstockchart_3.4.5/serial.js" type="text/javascript"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/themes/light.js"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/amstock.js"></script>
<script type="text/javascript">
var minVidTime;
var maxVidTime;
var firstDate = new Date();
firstDate.setHours(0, 0, 0, 0);

var doSetMyVidCurrentTime = true;

var serialChart;
var transcriptChart;
var currentDatetime = firstDate;
var serialChartData = <?php 
if (isset($sessionSerialChartData)) echo $sessionSerialChartData;
else include "data/temporal-features-$dataKey.txt"; 
?>;
var barChartData = <?php 
if (isset($sessionAverageFeatures)) echo $sessionAverageFeatures;
else include "data/average-features-$dataKey.txt"; 
?>;
barChartData[0]["session"] = 0;
var audioAlignmentChartData = <?php 
if (isset($sessionAudioAlignmentChartData)) {
  echo $sessionAudioAlignmentChartData;
} else if (file_exists("C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-alignment-$dataKey.txt")) { 
  include "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-alignment-$dataKey.txt";
} else {
  echo '{"startTime":0,"endTime":1,"phone":[{"speech":"sp","startTime":0,"endTime":1}],"word":[{"speech":"sp","startTime":0,"endTime":1}]}';
}
?>;
var wordProsodyData = <?php
if (isset($sessionWordProsodyData)) {
  echo $sessionWordProsodyData;
} else if (file_exists("data/word-prosody-$dataKey.txt")) { 
  include "data/word-prosody-$dataKey.txt";
} else {
  echo 'null';
}
?>;
var wordLoudnessMax = 0;
if (wordProsodyData) {
  for (var i=0;i<wordProsodyData.length;i++) {
    wordLoudnessMax = Math.max(wordLoudnessMax,wordProsodyData[i]["Loudness"]);
  }
  document.getElementById("averageLoudnessLine").style.marginTop = (4+128.0*barChartData[0]["Loudness"]/wordLoudnessMax)+"px";
}
</script>
<script>
var myVid;
var millisecPerFrame;
var myInterval; 
AmCharts.ready(function () {
    AmCharts.theme = AmCharts.themes.light;
    myVid = document.getElementById("sessionVideo");
    if (myVid.duration) {
        console.log("The video duration has already been set");
        drawAllCharts();
    } else {
        myVid.ondurationchange=function() {
            console.log("The video duration has changed");
            drawAllCharts();
        };
    }
});
window.onresize = function(e) {
    if (transcriptChart) {
      var transcriptCursor = document.getElementById("transcriptChartCursor");
    transcriptCursor.style.marginLeft = 0;
    
    var transcriptChartdiv = document.getElementById("transcriptChartdiv");
    var transcriptChartdivParentWidth = transcriptChartdiv.parentNode.offsetWidth - 6;
    var newTranscriptChartdivWidth = Math.round(transcriptChartdivParentWidth*(1000.0*myVid.duration)/(maxVidTime-minVidTime))+"px";
    
    if (transcriptChart) {
        if (transcriptChartdiv.style.width != newTranscriptChartdivWidth) {
            transcriptChartdiv.style.width = newTranscriptChartdivWidth;
            transcriptChart.validateNow();
        }
    }
    else console.log("transcript chart not made yet");
    
    transcriptChartdiv.style.marginLeft = Math.round(-parseInt(newTranscriptChartdivWidth)*(minVidTime-firstDate)/(1000.0*myVid.duration))+"px";
    }
    else console.log("no transcript chart");
};

var foundIndex;
function drawAllCharts() {
    millisecPerFrame = 1000.0*myVid.duration/serialChartData.length;
    serialChartData = formatSerialData(serialChartData);
    audioAlignmentChartData = formatAlignmentData(audioAlignmentChartData);
    drawTranscriptChart();
    drawSerialPanelsChart();
    //drawBarChart("barChartdiv1", "Smile Intensity","Smile Intensity");
    //drawBarChart("barChartdiv2", "Body Movement","Body Movement");
    //drawBarChart("barChartdiv3", "Loudness","Loudness");
    //drawBarChart("barChartdiv4", "Syllable Duration","Syllable Duration");
    
    myVid.addEventListener("timeupdate", function(){
    
        var vidPositionIndicator = document.getElementById("vidPositionIndicator");
        var scrollbarWidth = serialChartdiv.offsetWidth;
        
        var transcriptCursor = document.getElementById("transcriptChartCursor");
    
        if (document.getElementById("playVisibleRegionOnlyCheckbox").checked) {
            if (myVid.currentTime > (maxVidTime - firstDate)/1000.0) {
                myVid.pause();
                serialChart.chartCursors[0].showCursorAt(maxVidTime);
                vidPositionIndicator.style.marginLeft = Math.round(scrollbarWidth*(maxVidTime-firstDate)/(1000.0*myVid.duration))+"px";
                //onPeriodSelectorChanged();
                
                transcriptCursor.style.marginLeft = (scrollbarWidth-parseFloat(transcriptCursor.style.width))+"px";
            }
            else if (myVid.currentTime < (minVidTime - firstDate)/1000.0) {
                myVid.currentTime = (minVidTime - firstDate)/1000.0;
                vidPositionIndicator.style.marginLeft = Math.round(scrollbarWidth*(minVidTime-firstDate)/(1000.0*myVid.duration))+"px";
                
                transcriptCursor.style.marginLeft = 0;
            }
        } else {
            console.log("not checked playVisibleRegionOnlyCheckbox");
            if (myVid.currentTime >=  myVid.duration) {
                var newMaxDate = new Date(firstDate);
                newMaxDate.setMilliseconds(newMaxDate.getMilliseconds() + (maxVidTime-minVidTime));
                minVidTime = new Date(firstDate);
                maxVidTime = newMaxDate;
                serialChart.zoom(minVidTime, maxVidTime);
                onPeriodSelectorChanged();
                console.log("caught short distance first");
            } else if (myVid.currentTime > (maxVidTime - firstDate)/1000.0 || myVid.currentTime < (minVidTime - firstDate)/1000.0) {
                if (myVid.currentTime + (maxVidTime-minVidTime)/1000.0 > myVid.duration) {
                    var newMinDate = new Date(serialChartData[serialChartData.length-1]["time"]);
                    newMinDate.setMilliseconds(newMinDate.getMilliseconds() - (maxVidTime-minVidTime));
                    minVidTime = newMinDate;
                    maxVidTime = serialChartData[serialChartData.length-1]["time"];
                    doSetMyVidCurrentTime = false;
                    serialChart.zoom(minVidTime, maxVidTime);
                    console.log("caught short distance");
                } else {
                    var newMinDate = new Date(firstDate);
                    newMinDate.setMilliseconds(newMinDate.getMilliseconds() + 1000.0*myVid.currentTime);
                    var newMaxDate = new Date(newMinDate);
                    newMaxDate.setMilliseconds(newMaxDate.getMilliseconds() + (maxVidTime - minVidTime));
                    
                    minVidTime = newMinDate;
                    maxVidTime = newMaxDate;
                    doSetMyVidCurrentTime = false;
                    serialChart.zoom(minVidTime, maxVidTime);
                }
            }
        }
        
        var currentDatetime = new Date(firstDate);
		currentDatetime.setMilliseconds(currentDatetime.getMilliseconds() + 1000.0*myVid.currentTime);
        serialChart.chartCursors[0].showCursorAt(currentDatetime);
        
        vidPositionIndicator.style.marginLeft = Math.min(Math.round(scrollbarWidth*(currentDatetime-firstDate)/(1000.0*myVid.duration)),scrollbarWidth-parseFloat(vidPositionIndicator.style.width))+"px";
        
        transcriptCursor.style.marginLeft = Math.min(Math.round(scrollbarWidth*(currentDatetime-minVidTime)/(maxVidTime-minVidTime)),scrollbarWidth-parseFloat(transcriptCursor.style.width))+"px";
        
        var lastFoundIndex = foundIndex;
        foundIndex = -1;
        
        if (1000.0*(myVid.currentTime) < audioAlignmentChartData["word"][0]["time"] - 1000.0*audioAlignmentChartData["word"][0]["duration"]/2 - firstDate) {
            foundIndex = 0;
            //console.log("foundIndex = 0;");
        } else if (1000.0*(myVid.currentTime) > audioAlignmentChartData["word"][audioAlignmentChartData["word"].length-1]["time"] + 1000.0*audioAlignmentChartData["word"][0]["duration"]/2 - firstDate) {
            foundIndex = wordProsodyData.length-1;
            //console.log("foundIndex = wordProsodyData.length;");
        } else {
            var minIndex = 0;
            var maxIndex = audioAlignmentChartData["word"].length-1;
            var currentIndex=-1;
            while (maxIndex-minIndex > 5) {
                if (currentIndex == Math.round((maxIndex+minIndex)/2)) {
                    foundIndex = currentIndex;
                    //console.log("foundIndex1",foundIndex+1);
                    break;
                }
                currentIndex = Math.round((maxIndex+minIndex)/2);
                //console.log("currentIndex",currentIndex,audioAlignmentChartData["word"][currentIndex]);
                if (audioAlignmentChartData["word"][currentIndex]["time"] - firstDate > 1000.0*(myVid.currentTime + audioAlignmentChartData["word"][currentIndex]["duration"]/2)) {
                    maxIndex = currentIndex;
                } else if (audioAlignmentChartData["word"][currentIndex]["time"] - firstDate < 1000.0*(myVid.currentTime - audioAlignmentChartData["word"][currentIndex]["duration"]/2)) {
                    minIndex = currentIndex;
                } else {
                    foundIndex = currentIndex;
                    //console.log("foundIndex2",foundIndex+1);
                    break;
                }
            }
            if (foundIndex < 0) {
                for (var i=minIndex;i<maxIndex+1;i++) {
                    if ((audioAlignmentChartData["word"][i]["time"] - firstDate < 1000.0*(myVid.currentTime + audioAlignmentChartData["word"][i]["duration"]/2)) && (audioAlignmentChartData["word"][i]["time"] - firstDate > 1000.0*(myVid.currentTime - audioAlignmentChartData["word"][i]["duration"]/2))) {
                        foundIndex = i;
                        //console.log("found i",i+1);
                        break;
                    }
                }
            }
            foundIndex += 1;
        }
        wordSpan = document.getElementById(lastFoundIndex+"titlespan");
        if (wordSpan) {
            wordSpan.style.background = "transparent";
            wordSpan.style.color = "#000000";
            transcriptChart.unhighlightGraph(transcriptChart.getGraphById(foundIndex+"title"));
        }
        var wordSpan = document.getElementById(foundIndex+"titlespan");
        if (wordSpan) {
            wordSpan.style.background = "#2C9FD4";
            wordSpan.style.color = "#ffffff";
            transcriptChart.highlightGraph(transcriptChart.getGraphById(foundIndex+"title"));
        }
        if (wordProsodyData) {
            //console.log("prosody foundIndex",foundIndex);
            document.getElementById("wordProsodyValue").innerHTML = Math.round(10.0*wordProsodyData[foundIndex]["Loudness"])/10.0;
        } else document.getElementById("wordProsodyValue").innerHTML = "0.0";
        
    });
    
    myVid.addEventListener("play", function() {
    /*
        var playVideoButton = document.getElementById("playVideoButton");
    
        playVideoButton.firstElementChild.className = "icomoon-pause2";
    */
        if (myVid.currentTime > (maxVidTime - firstDate)/1000.0) {
            myVid.currentTime = (minVidTime - firstDate)/1000.0;
        }
        else if (myVid.currentTime < (minVidTime - firstDate)/1000.0) myVid.currentTime = (minVidTime - firstDate)/1000.0;        
    });
/*
    myVid.addEventListener("pause", function() {
        var playVideoButton = document.getElementById("playVideoButton");
        playVideoButton.firstElementChild.className = "icomoon-play2";
    });
*/
}
        
function formatSerialData(chartData) {
    for (elem in chartData) {
        var newDate = new Date(firstDate);
		newDate.setMilliseconds(newDate.getMilliseconds() + millisecPerFrame*chartData[elem]["time"]);
        chartData[elem]["time"] = newDate;
    }
    minVidTime = chartData[0]["time"];
    maxVidTime = chartData[chartData.length-1]["time"];
    return chartData;
}

function formatAlignmentData(chartData) {
    var newChartData = new Array();
    newChartData["startTime"] = chartData["startTime"];
    newChartData["endTime"] = chartData["endTime"];
    newChartData["phone"] = new Array();
    newChartData["word"] = new Array();
    newChartData["wordStack"] = new Array();
    newChartData["phoneStack"] = new Array();
    var tiers = new Array("phone","word");
    for (var tier in tiers) {
        var newDate;
        newChartData[tiers[tier]+"Stack"][0] = new Array();
        newChartData[tiers[tier]+"Stack"][0]["session"] = 0;
        newChartData[tiers[tier]+"Stack"][0]["0title"] = chartData[tiers[tier]][0]["startTime"];
        for (var elem in chartData[tiers[tier]]) {
            var midTime = (chartData[tiers[tier]][elem]["startTime"]+chartData[tiers[tier]][elem]["endTime"])/2.0;
            var duration = chartData[tiers[tier]][elem]["endTime"]-chartData[tiers[tier]][elem]["startTime"];
        
            newChartData[tiers[tier]][elem] = new Array();
            newChartData[tiers[tier]][elem]["speech"] = chartData[tiers[tier]][elem]["speech"];
            
            newDate = new Date(firstDate);
            newDate.setMilliseconds(newDate.getMilliseconds() + 1000.0*midTime);
            newChartData[tiers[tier]][elem]["time"] = newDate;
            
            newChartData[tiers[tier]][elem]["duration"] = duration;// in seconds
            
            newChartData[tiers[tier]+"Stack"][0][(elem*1+1)+"title"] = duration;
        }
        var endFillerNumber = chartData[tiers[tier]].length+1;
        console.log("endFillerNumber",endFillerNumber);
        newChartData[tiers[tier]+"Stack"][0][endFillerNumber+"title"] = myVid.duration - chartData[tiers[tier]][endFillerNumber-2]["endTime"];
    }
    console.log("newChartData",newChartData);
    return newChartData;
}     

function drawBarChart(barChartdiv, valueField, title) {
    var chart = AmCharts.makeChart(barChartdiv, {
        "type": "serial",
        "fontFamily": "Lato",
        "titles":[{
            "text": title, 
            "size": 18, 
            "color": "#878586",  
            "alpha": 1, 
            "bold": true
        }],
        "panEventsEnabled": false,
        "dataProvider": barChartData,
        "gridAboveGraphs": true,
        "startDuration": 1,
        "creditsPosition": "bottom-left",
        "graphs": [{
            "title": valueField,
            //"balloonText": "Session [[category]]: <b>[[value]]</b>",
            "balloonText": "<b>[[value]]</b>",
            "fillAlphas": 0.8,
            "lineAlpha": 0.2,
            "type": "column",
            "valueField": valueField,
            "labelText": "[[value]]",
            "fontSize": 24
        }],
        "chartCursor": {
            "categoryBalloonEnabled": false,
            "cursorAlpha": 0,
            "zoomable": false,
            "enabled":false
        },
        "categoryField": "session",
        "numberFormatter": {
            "precision":2, 
            "decimalSeparator":'.', 
            "thousandsSeparator":','
        },
        "categoryAxis": {
            "gridAlpha": 0,
            "labelsEnabled": false
        },
    });
    //console.log("barchart",chart);
}

function drawTranscriptChart() {
var transcriptLegendDiv = document.getElementById("transcriptLegendDiv");
transcriptLegendDiv.onmouseover = function(e) {
    if (e.toElement.id) {
        if (e.toElement.id.indexOf("titlespan") > 0) {
            e.toElement.style.background = "#2C9FD4";
            e.toElement.style.color = "#ffffff";
            transcriptChart.highlightGraph(transcriptChart.getGraphById(e.toElement.id.substr(0,e.toElement.id.length-4)));
            if (wordProsodyData) {
              document.getElementById("wordProsodyValue").innerHTML = Math.round(10.0*wordProsodyData[parseInt(e.toElement.id)]["Loudness"])/10.0;
           } else document.getElementById("wordProsodyValue").innerHTML = "0.0";
        }
    }
};
transcriptLegendDiv.onmouseout = function(e) {
    if (e.fromElement.id) {
        if (e.fromElement.id.indexOf("titlespan") > 0) {
            e.fromElement.style.background = "transparent";
            e.fromElement.style.color = "#000000";
            transcriptChart.unhighlightGraph(transcriptChart.getGraphById(e.fromElement.id.substr(0,e.fromElement.id.length-4)));
            document.getElementById("wordProsodyValue").innerHTML = "";
        }
    }
};
var chartData = audioAlignmentChartData["wordStack"];
var transcriptGraphs = [];
for (elem in chartData[0]) {
    if (elem != "session") {
        var title;
        if (elem == "0title" || elem == (audioAlignmentChartData["word"].length+1)+"title") {
            title = "Pause/Noise";
        } else {
            title = audioAlignmentChartData["word"][parseInt(elem)-1]["speech"];
        }
        var lineColor,visibleInLegend,columnWidth;
        if (title == "sp" || title.substr(0,1)=="{" || title == "Pause/Noise") {
            title = "Pause/Noise";
            lineColor = "#a6a8ad";
            visibleInLegend = false;
            showAllValueLabels = false;
        } else {
            var speech = document.createElement("span");
            speech.innerHTML = title;
            speech.id = elem+"span";
            transcriptLegendDiv.appendChild(speech);

            //title = title.toLowerCase();
            lineColor = "#67b7dc";
            visibleInLegend = true;
            showAllValueLabels = true;
        }
        if (wordProsodyData && wordLoudnessMax > 0) {
            //console.log(parseInt(elem),wordProsodyData[parseInt(elem)]);
            //console.log("audioAlignmentChartData",audioAlignmentChartData ["word"].length,"wordProsodyData",wordProsodyData.length);
            columnWidth = wordProsodyData[parseInt(elem)]["Loudness"]/wordLoudnessMax;
        }
        else columnWidth = 1;
        transcriptGraphs.push({
            "balloonText": "<b style='font-size:18px'>[[title]]</b>",
            "fillAlphas": 0.1,
            "lineColor": lineColor,
            "lineThickness": 3,
            "labelText": "[[title]]",
            "title": title,
            "type": "column",
            "color": "#000000",
            "valueField": elem,
            "id": elem,
            "visibleInLegend": visibleInLegend,
            "columnWidth": columnWidth,
            "pointPosition": "end",
            "showAllValueLabels": showAllValueLabels,
        });
    }
}
transcriptChart = AmCharts.makeChart("transcriptChartdiv", {
/*
    "titles": [{
        "text": "Word Volume",
        "size": 18,
        "color": "#878586",
        "alpha": 1,
        "bold": false,
    }],
    */
    "fontFamily": "Lato",
    "marginTop": -120,
    "type": "serial",
    "pathToImages":"/amstockchart_3.4.5/images/",
    "rotate": true,
    "dataProvider": chartData,
    "autoMargins": false,
    "marginLeft": 0,
    "marginRight": 0,
    "creditsPosition": "top-left",
    "valueAxes": [{
        "stackType": "100%",
        "axisAlpha": 0,
        "gridAlpha": 0,
        "labelsEnabled": false
    }],
/*
    "legend": {
        "divId": "transcriptLegendDiv",
        "autoMargins": false,
        "equalWidths": false,
        "valueAlign": "left",
        "valueWidth": 0,
        "rollOverGraphAlpha": 0.2,
        "markerType": "none",
        "markerSize": 0,
        "markerLabelGap": 0,
        "horizontalGap": 0,
        "markerBorderThickness": 0,
        "spacing": 0,
        "fontSize": 18,
        "rollOverColor": "#CC0000",
        "switchable": false
    },
*/
    "graphs":transcriptGraphs,
    "categoryField": "session",
    "categoryAxis": {
        "axisAlpha": 0,
        "gridAlpha": 0,
        "labelsEnabled": false
    },
});

transcriptChart.addListener("drawn", transcriptChartOnDrawn);

transcriptChart.addListener("rollOverGraphItem",transcriptRollOverGraphItem);
transcriptChart.addListener("rollOutGraphItem",transcriptRollOverGraphItem);
}

function transcriptChartOnDrawn() {
    var transcriptLabels = document.getElementById("transcriptChartdiv").firstElementChild.firstElementChild.firstElementChild.childNodes[12];
    var transcriptBarsChildNodes = document.getElementById("transcriptChartdiv").firstElementChild.firstElementChild.firstElementChild.childNodes[5].firstElementChild.childNodes;
    
    transcriptLabels.setAttribute("transform","translate(0,10)");
    for (var i=0;i<transcriptLabels.childNodes.length;i++) {
        if (transcriptLabels.childNodes[i].childNodes.length > 0 && transcriptLabels.childNodes[i].textContent != "Pause/Noise") {
            
            var wordWidth = transcriptLabels.childNodes[i].getBBox().width;
            var targetWidth = Math.max(transcriptBarsChildNodes[i].getBBox().width - 6,1);
            
            var currentGroupTransform = transcriptLabels.childNodes[i].getAttribute("transform");
            var currentTextTransform = transcriptLabels.childNodes[i].firstElementChild.getAttribute("transform").split(",");
            
            //console.log(currentTextTransform);
            
            var currentTextTransformX = parseInt(currentTextTransform[0].split("(")[1]);
            //console.log(currentTextTransformX);
            var currentTextTransformY = parseInt(currentTextTransform[1]);
            
            transcriptLabels.childNodes[i].setAttribute("transform",currentGroupTransform+" scale("+(targetWidth/wordWidth)+",1)")
            
            
            transcriptLabels.childNodes[i].firstElementChild.setAttribute("transform","translate("+(currentTextTransformX/targetWidth*wordWidth)+","+currentTextTransformY+")");
        }
    }
}

//{type:"rollOverGraphItem", graph:AmGraph, item:GraphDataItem, index:Number, chart:AmChart, event:MouseEvent}
function transcriptRollOverGraphItem(e) {
    //console.log("transcriptRollOverGraphItem",e);
    //console.log(e.target.valueField);
    var speechSpan = document.getElementById(e.target.valueField+"span");
    if (e.type == "rollOverGraphItem") {
        if (wordProsodyData) {
            document.getElementById("wordProsodyValue").innerHTML = Math.round(10.0*wordProsodyData[parseInt(e.graph.id)]["Loudness"])/10.0;
         } else document.getElementById("wordProsodyValue").innerHTML = "0.0";
    } else {
      document.getElementById("wordProsodyValue").innerHTML = "";
    }
    if (speechSpan) {
        if (e.type == "rollOverGraphItem") {
            speechSpan.style.background = "#2C9FD4";
            speechSpan.style.color = "#ffffff";
            e.chart.highlightGraph(e.item.graph);
        } else {
            speechSpan.style.background = "transparent";
            speechSpan.style.color = "#000000";
            e.chart.unhighlightGraph(e.item.graph);
        }
    }
}

function drawSerialPanelsChart() {
    serialChart = new AmCharts.AmStockChart();
    serialChart.pathToImages = "/amstockchart_3.4.5/images/";

    // DATASETS 
    var dataSet1 = new AmCharts.DataSet();
    dataSet1.title = "Facial Data";
    dataSet1.fieldMappings = [{
        fromField: "smile",
        toField: "smile"
    },{
        fromField: "movement",
        toField: "movement"
    }];
    dataSet1.dataProvider = serialChartData;
    dataSet1.categoryField = "time";
    
    // set data sets to the chart
    serialChart.dataSets = [dataSet1];

    
    //.addListener("dataUpdated", function() {serialChart.zoom(serialChartData[0]["time"], serialChartData[Math.min(serialChartData.length-1,300)]["time"]);});
    serialChart.addListener("zoomed", onChartZoomed);

    // PANELS 
    var stockPanel1 = new AmCharts.StockPanel();
    stockPanel1.creditsPosition = "bottom-left";
    stockPanel1.startDuration = 0.5;
    stockPanel1.sequencedAnimation = false;
    stockPanel1.fontFamily = "Lato";

    stockPanel1.numberFormatter = {
        "precision":1, 
        "decimalSeparator":'.', 
        "thousandsSeparator":','
    };
    
    var valueAxis1 = new AmCharts.ValueAxis();
    stockPanel1.addValueAxis(valueAxis1);
    
    var valueAxis2 = new AmCharts.ValueAxis();
    valueAxis2.offset = -40;
    stockPanel1.addValueAxis(valueAxis2);
    
    // graph of first stock panel
    var graph1 = new AmCharts.StockGraph();
    graph1.title = "Smile Intensity (Out of 100)";
    graph1.valueAxis = valueAxis1;
    graph1.valueField = "smile";
    graph1.periodValueText = "[[value.open]]";
    graph1.type = "smoothedLine";
    graph1.lineThickness = 3;
    graph1.fillAlphas = 0.1;
    graph1.useDataSetColors = false;
    stockPanel1.addStockGraph(graph1);
    
    var graph2 = new AmCharts.StockGraph();
    graph2.title = "Movement";
    graph2.valueAxis = valueAxis2;
    graph2.valueField = "movement";
    graph2.periodValueText = "[[value.open]]";
    graph2.type = "smoothedLine";
    graph2.lineThickness = 3;
    graph2.fillAlphas = 0.1;
    graph2.lineColor = "#FCD202";
    graph2.useDataSetColors = false;
    stockPanel1.addStockGraph(graph2);

    // create stock legend
    var stockLegend1 = new AmCharts.StockLegend();
    stockLegend1.color = "#878586";
    stockLegend1.fontSize = 18;
    stockPanel1.stockLegend = stockLegend1;

    // set panels to the chart
    serialChart.panels = [stockPanel1];
    
    // OTHER SETTINGS ////////////////////////////////////
    var sbsettings = new AmCharts.ChartScrollbarSettings();
    sbsettings.height = 30;
    sbsettings.color = "#333";
    sbsettings.dragIconHeight = 34;
    sbsettings.dragIconWidth = 34;
    sbsettings.backgroundColor = "#272930";
    sbsettings.selectedBackgroundColor = "#67b7dc";
    sbsettings.position = "top";
    sbsettings.updateOnReleaseOnly = false;
    serialChart.chartScrollbarSettings = sbsettings;

    // CURSOR
    var cursorSettings = new AmCharts.ChartCursorSettings();
    cursorSettings.valueBalloonsEnabled = false; 
    cursorSettings.cursorPosition = "middle";
    cursorSettings.categoryBalloonDateFormats = [{
                period: 'fff',
                format: 'J:NN:SS.QQQ'
            }, {
                period: 'ss',
                format: 'J:NN:SS'
            }, {
                period: 'mm',
                format: 'J:NN:SS'
            }, {
                period: 'hh',
                format: 'J:NN:SS'
            }, {
                period: 'DD',
                format: 'J:NN:SS'
            }, {
                period: 'WW',
                format: 'J:NN:SS'
            }, {
                period: 'MM',
                format: 'J:NN:SS'
            }, {
                period: 'YYYY',
                format: 'J:NN:SS'
            }];
    serialChart.chartCursorSettings = cursorSettings;

    var legendSettings = new AmCharts.LegendSettings();
    legendSettings.marginLeft = 14;
    legendSettings.marginTop = 10;
    legendSettings.rollOverGraphAlpha = 0.2;
    legendSettings.switchType = "v";
    serialChart.legendSettings = legendSettings;

    // PERIOD SELECTOR ///////////////////////////////////
    var periodSelector = new AmCharts.PeriodSelector();
    periodSelector.addListener("changed",onPeriodSelectorChanged);
    periodSelector.position = "top";
    periodSelector.periodsText = "Zoom: ";
    periodSelector.inputFieldsEnabled = false;
    periodSelector.periods = [{
        period: "ss",
        count: 1,
        label: "1 second"
    }, {
        period: "ss",
        count: 5,
        label: "5 seconds"
    }, {
        period: "ss",
        count: 10,
        label: "10 seconds"
    }, /*{
        period: "ss",
        count: 30,
        label: "30 seconds"
    }, {
        period: "mm",
        count: 1,
        label: "1 minute"
    },*/ {
        period: "MAX",
        label: "Show All"
    }];
    serialChart.periodSelector = periodSelector;

    var valueAxesSettings = new AmCharts.ValueAxesSettings();
    valueAxesSettings.color = "#9c9c9c";
    serialChart.valueAxesSettings = valueAxesSettings;

    var categoryAxesSettings = new AmCharts.CategoryAxesSettings();
    categoryAxesSettings.gridAlpha = 0;
    categoryAxesSettings.color = "#878586";
    categoryAxesSettings.minPeriod = "fff";
    categoryAxesSettings.groupToPeriods = ["fff", "10fff","100fff","500fff","ss", "10ss", "30ss", "mm", "10mm", "30mm", "hh", "DD", "WW", "MM", "YYYY"];
    categoryAxesSettings.dateFormats = [{
                period: 'fff',
                format: 'J:NN:SS'
            }, {
                period: 'ss',
                format: 'J:NN:SS'
            }, {
                period: 'mm',
                format: 'J:NN:SS'
            }, {
                period: 'hh',
                format: 'J:NN:SS'
            }, {
                period: 'DD',
                format: 'J:NN:SS'
            }, {
                period: 'WW',
                format: 'J:NN:SS'
            }, {
                period: 'MM',
                format: 'J:NN:SS'
            }, {
                period: 'YYYY',
                format: 'J:NN:SS'
            }];

    serialChart.categoryAxesSettings = categoryAxesSettings;
    serialChart.write('serialChartdiv'); 
    onPeriodSelectorChanged();
}

function onPeriodSelectorChanged() {
    var amChartsButtons = document.getElementsByClassName("amChartsButton");
    for (var i=0;i<amChartsButtons.length;i++) {
        amChartsButtons[i].className = "amChartsButton btn btn-default btn-sm";
    }
    var amChartsButtonSelecteds = document.getElementsByClassName("amChartsButtonSelected");
    for (var i=0;i<amChartsButtonSelecteds.length;i++) {
        amChartsButtonSelecteds[i].className = "amChartsButtonSelected btn btn-info btn-sm";
    }
}

// event = {type:"zoomed", startDate:startDate, endDate:endDate, period:period, chart:AmStockChart}
function onChartZoomed(event) {
    minVidTime = event.startDate;
    maxVidTime = event.endDate;
    
    if (doSetMyVidCurrentTime) myVid.currentTime = (minVidTime - firstDate)/1000.0;
    else doSetMyVidCurrentTime = true;
    updateSerialChart();
}

function updateSerialChart() {
    onPeriodSelectorChanged();

    var vidPositionIndicator = document.getElementById("vidPositionIndicator");
    
    var scrollbarWidth = serialChartdiv.offsetWidth;
    vidPositionIndicator.style.marginLeft = Math.round(scrollbarWidth*(minVidTime-firstDate)/(1000.0*myVid.duration))+"px";
    
    var transcriptCursor = document.getElementById("transcriptChartCursor");
    transcriptCursor.style.marginLeft = 0;
    
    var transcriptChartdiv = document.getElementById("transcriptChartdiv");
    var transcriptChartdivParentWidth = transcriptChartdiv.parentNode.offsetWidth - 6;
    var newTranscriptChartdivWidth = Math.round(transcriptChartdivParentWidth*(1000.0*myVid.duration)/(maxVidTime-minVidTime))+"px";
    
    if (transcriptChart) {
        if (transcriptChartdiv.style.width != newTranscriptChartdivWidth) {
            transcriptChartdiv.style.width = newTranscriptChartdivWidth;
            transcriptChart.validateNow();
        }
    }
    else console.log("transcript chart not made yet");
    
    transcriptChartdiv.style.marginLeft = Math.round(-parseInt(newTranscriptChartdivWidth)*(minVidTime-firstDate)/(1000.0*myVid.duration))+"px";
}
/*
function toggleVideoPlay() {
    var playVideoButton = document.getElementById("playVideoButton");
    if (myVid.paused) {
        myVid.play();
    } else {
        myVid.pause();
    }
}
*/
window.onresize = function() {
    if (minVidTime) updateSerialChart();
}
</script>
<?php } ?>
</body>

</html>
<!DOCTYPE html>
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
#sliderLabel {
    border: 2px solid black;
    -webkit-border-radius: 7px;
    -moz-border-radius: 7px;
    border-radius: 7px;
    cursor: pointer;
    display: block;
    height: 30px;
    margin: 0px ;
    overflow: hidden;
    position: relative;
    width: 80px;
}
#sliderLabel input {
    display: none;
}
#sliderLabel input:checked + #slider {
    left: 36px;
}
#slider {
    background: #c0c6c3;
    -moz-border-radius: 7px;
    display: block;
    height: 30px;
    left: -4px;
    position: relative;
    top: 0px;
    -moz-transition: left .25s ease-out;
    -webkit-transition: left .25s ease-out;
    transition: left .25s ease-out;
    width: 48px;
    z-index: 1;
}
#sliderOn, #sliderOff {
    color: white;
    display: block;
    font-family: verdana, arial, sans-serif;
    font-size: 14px;
    font-weight: bold;
    line-height: 30px;
    position: absolute;
    text-align: center;
    top: 0px;
    width: 40px;
}
#sliderOn {
    background: #002400;
    background: -moz-linear-gradient(top,  #002400 0%, #008a00 100%);
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#002400), color-stop(100%,#008a00));
    background: -webkit-linear-gradient(top,  #002400 0%,#008a00 100%);
    background: -o-linear-gradient(top,  #002400 0%,#008a00 100%);
    background: -ms-linear-gradient(top,  #002400 0%,#008a00 100%);
    background: linear-gradient(top,  #002400 0%,#008a00 100%);
    left: 0px;
}
#sliderOff {
    background: #870000;
    background: -moz-linear-gradient(top,  #870000 0%, #ff0000 100%);
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#870000), color-stop(100%,#ff0000));
    background: -webkit-linear-gradient(top,  #870000 0%,#ff0000 100%);
    background: -o-linear-gradient(top,  #870000 0%,#ff0000 100%);
    background: -ms-linear-gradient(top,  #870000 0%,#ff0000 100%);
    background: linear-gradient(top,  #870000 0%,#ff0000 100%);
    right: 0px;
}
#chartdiv {
	width		: 100%;
	height		: 150px;
	font-size	: 11px;
}	
</style>
<html lang="en" onkeydown="keydown(event)" onkeyup="keyup(event)">
<div style="position:relative">
	<video id = "videocontainer" onplay = "playing()" width=70% height=60% style="text-align:center" controls>
		<source id = "vsrc" src="1840.mp4"  >
	</video>
</div >
<div align = "left" style ="position:absolute; top:5%; right:7%">
	<h3> instructions: </h3>
			<h4> 1. Select a Video
			<br> 2. Select feedback type
			<br> 3. Type your id in the text box and submit
			<br> 4. Play video and label it.
			<br> 5. Use 'd' and 'k' to turn icons red and green
			<br> 6. After watching whole video press 'done'
			<br> 7. If it turns green then you are done. </h4> 
</div>
<div  align = "left" style ="position:absolute; top:40%; right:7%">

	<select onchange= "videoselect()" id = "videoname">
		<option value = "1">Select a Video</option>
		<option value = "1848">1848</option>
		<option value = "1847">1847</option>
		<option value = "1846">1846</option>
		<option value = "1845">1845</option>
		<option value = "1844">1844</option>
		<option value = "1843">1843</option>
		<option value = "1842">1842</option>
		<option value = "1841">1841</option>
		<option value = "1840">1840</option>
		<option value = "1839">1839</option>
		<option value = "1838">1838</option>
		<option value = "1837">1837</option>
		<option value = "1836">1836</option>
		<option value = "1835">1835</option>
		<option value = "1834">1834</option>
		<option value = "1833">1833</option>
		<option value = "1832">1832</option>
		<option value = "1831">1831</option>
		<option value = "1830">1830</option>
		<option value = "1829">1829</option>
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
		

		<option value = "419">419</option>
		<option value = "424">424</option>
		
		<option value = "Participant2-2-Day5(Webcam)">Participant2-2-Day5(Webcam)</option>
		<option value = "Participant2-1-Day5(Webcam)">Participant2-1-Day5(Webcam)</option>
		<option value = "Participant1-2-Day5(Webcam)">Participant1-2-Day5(Webcam)</option>
		<option value = "Participant1-1-Day5(Webcam)">Participant1-1-Day5(Webcam)</option>
		<option value = "Participant2-2-Day4(Webcam)">Participant2-2-Day4(Webcam)</option>
		<option value = "Participant2-1-Day4(Webcam)">Participant2-1-Day4(Webcam)</option>
		<option value = "Participant1-2-Day4(Webcam)">Participant1-2-Day4(Webcam)</option>
		<option value = "Participant1-1-Day4(Webcam)">Participant1-1-Day4(Webcam)</option>
		<option value = "Participant1-2-Day3(Webcam)">Participant1-2-Day3(Webcam)</option>
		<option value = "Participant1-1-Day3(Webcam)">Participant1-1-Day3(Webcam)</option>
	</select>

	<br>

	<select onchange="typeselect()" id="type">
		<option value = "1">Select feedback type</option>
		<option value = "2">Volume & Eye Contact</option>
		<option value = "3">Smile & Body Movement</option>
	</select>
	<br>
	<input type = "text" id = "RAID"></input>
	<button type="submit" onclick="getID()" > Submit ID</button><br>
	<button id = "donebutton" type="submit" onclick="done()" > Done</button><br>
</div>


		<td>
			
			
		</td>
	
	<br>
	
		

<div id="chartdiv"></div>
<div id="status" style ="position:absolute; top:90%; left:7%">
	<img src="eyeContact.png" alt="eye" id= "eyePic" width="60" hspace="20" height="60" style="visibility:hidden">
	<img src="smile.png" alt="Smile" id="smilePic" width="60" hspace="20" height="60" style="visibility:hidden">
	<img src="volume.png" alt="Louder" id= "loudPic" width="60"hspace="20" height="60" style="visibility:hidden">
	<img src="body.png" alt="Move" id="movePic" width="60" height="60" style="visibility:hidden"><br>
</div>

</html>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script src="https://www.amcharts.com/lib/3/gantt.js"></script>

<script>
var container = document.getElementById("videocontainer");
var vsrc = document.getElementById("vsrc");
var type = document.getElementById("type");
var eyeicon = document.getElementById("eyePic");
var volumeicon = document.getElementById("loudPic");
var smileicon = document.getElementById("smilePic");
var bodyicon = document.getElementById("movePic");
var eyelabel = "";
var smilelabel="";
var bodylabel="";
var volumelabel="";
var video = document.getElementById("videoname");
var keyNumber;
var isddown = 0;
var iskdown = 0;
var timearrayeye = [];
var timearraysmile = [];
var timearraybody = [];
var timearrayvolume = [];
var timearrayeyeindex = 0;
var timearraysmileindex = 0;
var timearraybodyindex = 0;
var timearrayvolumeindex = 0;
var RAid="";
function getID(){
	RAid = document.getElementById("RAID").value;
	console.log(RAid);
	document.getElementById("RAID").disabled = true;
}

function videoselect(){
	console.log(video.value);
	keyNumber = video.value;
	var name  = video.value+ ".mp4"; 
	// name = "D:/Lissa-video/"+video.value+ ".mp4"; 
	console.log(name);
	container.src = name; 
	container.load();
}
function typeselect(){
	console.log(type.value+ " "+container.currentTime+" "+container.seekable.end(0));
	type.disable = true;
	if(type.value==2){
		volumeicon.style.visibility = "visible";
		eyeicon.style.visibility = "visible";
		smileicon.style.visibility = "hidden";
		bodyicon.style.visibility = "hidden";
			
	}
	else if(type.value==3){
		volumeicon.style.visibility = "hidden";
		eyeicon.style.visibility = "hidden";
		smileicon.style.visibility = "visible";
		bodyicon.style.visibility = "visible";
	}
	else{
		smileicon.style.visibility = "hidden";
		bodyicon.style.visibility = "hidden";
		volumeicon.style.visibility = "hidden";
		eyeicon.style.visibility = "hidden";
		
	}
}
function keydown(event){
	console.log(event.which);
	if (isddown == 0){
		if (event.which==68){
			isddown = 1;
			if(type.value==2){
				// d + eye 
				eyeicon.src="eyeContact2.png";
				eyelabel += container.currentTime+"-";
				timearrayeye[timearrayeyeindex] = container.currentTime;
				timearrayeyeindex++;
			}
			if(type.value==3){
				// d + smile 
				smileicon.src = "smile2.png";
				smilelabel += container.currentTime+"-"; 
				timearraysmile[timearraysmileindex] = container.currentTime;
				timearraysmileindex++;
			}
		}
	}
	if(iskdown == 0){
		if (event.which==75){
			iskdown = 1;
			if(type.value==2){
				// k + eye
				volumeicon.src = "volume2.png";
				volumelabel +=container.currentTime+"-";
				timearrayvolume[timearrayvolumeindex] = container.currentTime;
				timearrayvolumeindex++;
			}
			if(type.value==3){
				// d + body 
				bodyicon.src = "body2.png";
				bodylabel += container.currentTime+"-";
				timearraybody[timearraybodyindex] = container.currentTime;
				timearraybodyindex++;
			}
			
		}
	}
	
}
function keyup(event){
	console.log(event.which);
	if(isddown==1){
		if (event.which==68){
			isddown = 0;
			if(type.value==2){
				// d + volume 
				
				eyeicon.src="eyeContact.png";
				eyelabel += container.currentTime+" ";
				timearrayeye[timearrayeyeindex] = container.currentTime;
				timearrayeyeindex++;
				
			}
			if(type.value==3){
				// d + smile 
				smileicon.src = "smile.png";
				smilelabel += container.currentTime+" "; 
				timearraysmile[timearraysmileindex] = container.currentTime;
				timearraysmileindex++;
			}
		}
	}
	if(iskdown ==1){
		if (event.which==75){
			iskdown = 0;
			if(type.value==2){
				// k + eye
				volumeicon.src = "volume.png";
				volumelabel +=container.currentTime+" ";
				timearrayvolume[timearrayvolumeindex] = container.currentTime;
				timearrayvolumeindex++;
			}
			if(type.value==3){
				// d + body 
				bodyicon.src = "body.png";
				bodylabel += container.currentTime+" ";
				timearraybody[timearraybodyindex] = container.currentTime;
				timearraybodyindex++;
			}
			
		}
	}
	
}
function done(){
	console.log("done");
	if((container.seekable.end(0) - container.currentTime )< 1){
		var xhr1 = new XMLHttpRequest();
		xhr1.onreadystatechange = function(){
			if (this.readyState == 4) {
					if (this.status == 200) {
						if(this.responseText == "ok"){
							document.getElementById("donebutton").style.color = "green";
							
						}
					}
			}
			
		}
		xhr1.open('GET', "response.php?action=savelabel&keyNumber="+keyNumber+"&RAid="+RAid+"&type="+type.value+"&eyelabel="+timearrayeye+"&bodylabel="+timearraybody+"&volumelabel="+timearrayvolume+"&smilelabel="+timearraysmile, true);
		xhr1.send();
		videocontainer.pause();
	}
	else{
		alert("Please label/watch whole video then press done");
	}
}
function playing(){
	type.style.visibility = "hidden";
	vsrc.style.visibility = "hidden";
	isddown = 0;
	iskdown = 0;
	console.log(timearrayeye);
	document.getElementById("donebutton").style.color = "red";
	console.log("here"+container.seeked);
	if(timearrayeyeindex> 0){
		console.log("here");
		container.seeked = 0;
		var current = container.currentTime;
		if(current< timearrayeye[timearrayeyeindex-1] && current > timearrayeye[timearrayeyeindex-2]){
			timearrayeye[timearrayeyeindex-1] = 0 ;
			timearrayeye[timearrayeyeindex-2] = 0;
			timearrayeyeindex -=2;
		}
		else if(current< timearrayeye[timearrayeyeindex-1] && current < timearrayeye[timearrayeyeindex-2]){
			var i = 0;
			for(i = 0; i<timearrayeyeindex;i++){
				if(current< timearrayeye[i])break;
			}
			if(i%2 == 1) i-=1;
			var j = i;
			for(j = i;j<timearrayeyeindex;j++){
				timearrayeye[j] = 0;
				
			}
			timearrayeyeindex = i;
		}
	}
	if(timearraysmileindex> 0){
		console.log("here");
		container.seeked = 0;
		var current = container.currentTime;
		if(current< timearraysmile[timearraysmileindex-1] && current > timearraysmile[timearraysmileindex-2]){
			timearraysmile[timearraysmileindex-1] = 0 ;
			timearraysmile[timearraysmileindex-2] = 0;
			timearraysmileindex -=2;
		}
		else if(current< timearraysmile[timearraysmileindex-1] && current < timearraysmile[timearraysmileindex-2]){
			var i = 0;
			for(i = 0; i<timearraysmileindex;i++){
				if(current< timearraysmile[i])break;
			}
			if(i%2 == 1) i-=1;
			var j = i;
			for(j = i;j<timearraysmileindex;j++){
				timearraysmile[j] = 0;
				
			}
			timearraysmileindex = i;
		}
	}
	if(timearrayvolumeindex> 0){
		console.log("here");
		container.seeked = 0;
		var current = container.currentTime;
		if(current< timearrayvolume[timearrayvolumeindex-1] && current > timearrayvolume[timearrayvolumeindex-2]){
			timearrayvolume[timearrayvolumeindex-1] = 0 ;
			timearrayvolume[timearrayvolumeindex-2] = 0;
			timearrayvolumeindex -=2;
		}
		else if(current< timearrayvolume[timearrayvolumeindex-1] && current < timearrayvolume[timearrayvolumeindex-2]){
			var i = 0;
			for(i = 0; i<timearrayvolumeindex;i++){
				if(current< timearrayvolume[i])break;
			}
			if(i%2 == 1) i-=1;
			var j = i;
			for(j = i;j<timearrayvolumeindex;j++){
				timearrayvolume[j] = 0;
				
			}
			timearrayvolumeindex = i;
		}
	}
	if(timearraybodyindex> 0){
		console.log("here");
		container.seeked = 0;
		var current = container.currentTime;
		if(current< timearraybody[timearraybodyindex-1] && current > timearraybody[timearraybodyindex-2]){
			timearraybody[timearraybodyindex-1] = 0 ;
			timearraybody[timearraybodyindex-2] = 0;
			timearraybodyindex -=2;
		}
		else if(current< timearraybody[timearraybodyindex-1] && current < timearraybody[timearraybodyindex-2]){
			var i = 0;
			for(i = 0; i<timearraybodyindex;i++){
				if(current< timearraybody[i])break;
			}
			if(i%2 == 1) i-=1;
			var j = i;
			for(j = i;j<timearraybodyindex;j++){
				timearraybody[j] = 0;
				
			}
			timearraybodyindex = i;
		}
	}
	console.log(timearrayeye);
}
</script>
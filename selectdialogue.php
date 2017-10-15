
<!DOCTYPE html>
<html>
<head>
<title><?php echo $pageTitle; ?></title>

<meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="LISSA/LISSA/css/bootstrap.min.css" rel="stylesheet">
		
<script src="LISSA/LISSA/js/bootstrap.min.js"></script>
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

</style>
<div class="container" >
<br>
<div id= "textdiv" align="justify" style="position:fixed; font-size:30px">On which topics you want to talk about? Please select at least 3.</div><br><br><br>
<div id="images" >
	<div>
		<div id= "textdiv" align="justify" style="position:fixed; font-size:25px">Where are you from</div><br><br>
			
		<label id="sliderLabel">
			<input type="checkbox"  onclick="dialogueSelect(0)" />
			<span id="slider"></span>
			<span id="sliderOn" >Yes</span>
			<span id="sliderOff">No</span>
		</label>
	</div>
	<br><br>
	<div>
		<div id= "textdiv" align="justify" style="position:fixed; font-size:25px">Activities You like to do</div><br><br>
		 	
		<label id="sliderLabel">
			<input type="checkbox"  onclick="dialogueSelect(1)" />
			<span id="slider"></span>
			<span id="sliderOn" >Yes</span>
			<span id="sliderOff">No</span>
		</label>
	</div><br><br>
	<div>
		<div id= "textdiv" align="justify" style="position:fixed; font-size:25px">Family and Friends</div><br><br>
		
		<label id="sliderLabel">
			<input type="checkbox"  onclick="dialogueSelect(2)" />
			<span id="slider"></span>
			<span id="sliderOn" >Yes</span>
			<span id="sliderOff">No</span>
		</label>
	</div><br><br>
	<div>
		<div id= "textdiv" align="justify" style="position:fixed; font-size:25px">Getting with others</div><br><br>
			
		<label id="sliderLabel">
			<input type="checkbox"  onclick="dialogueSelect(3)" />
			<span id="slider"></span>
			<span id="sliderOn" >Yes</span>
			<span id="sliderOff">No</span>
		</label>
	</div><br><br>
	<div>
		<div id= "textdiv" align="justify" style="position:fixed; font-size:25px">Tell me about yourself</div><br><br>
		<label id="sliderLabel">
			<input type="checkbox"  onclick="dialogueSelect(4)" />
			<span id="slider"></span>
			<span id="sliderOn" >Yes</span>
			<span id="sliderOff">No</span>
		</label>
	</div>	
	
	
</div>
<br>
	<button type="button" style="vertical-align:top;" class="btn btn-success" onclick = "speechSubmit()" >Submit</button>
</div>			
<script>
var eyeCount=0;
var smileCount=0;
var volumeCount=0;
var bodyCount=0;
var keyNumber=0;
var x=0;
var count = [0,0,0,0,0];
var value = [0,0,0,0,0];
var text = document.getElementById('speechtext');
var but = document.getElementById('onButton');
function checkon(){
	var xhr1 = new XMLHttpRequest();
	xhr1.onreadystatechange = function() {
	//	console.log("this.status "+this.status);
		if (this.readyState == 4) {
			if (this.status == 200) {
				console.log("this.responseText "+this.responseText+" "+x);
				if(this.responseText== "Yes"){
					but.style.color="green";
				}
				else{
					but.style.color="red";
					x++;
					xhr1.open('GET', "response.php?action=isdateon&keyNumber="+keyNumber, true);
					xhr1.send();
				}
			}
		}
		
	}
	//console.log("here");
	xhr1.open('GET', "response.php?action=isdateon&keyNumber="+keyNumber, true);
	xhr1.send();
}
			
function getkeyNumber(){
	keyNumber = document.getElementById("keyNumber").value;
	console.log(keyNumber);
	document.getElementById("keyNumber").value="";
	checkon();
}
setTimeout(function init(){
	console.log("init");
	var xhr = new XMLHttpRequest();
	xhr.open('GET', "response.php?action=iconcontrol&button=eye&value=hide&keyNumber="+keyNumber, true);
	xhr.send();
},1);
setTimeout(function init(){
	console.log("init");
	var xhr = new XMLHttpRequest();
	xhr.open('GET', "response.php?action=iconcontrol&button=smile&value=hide&keyNumber="+keyNumber, true);
	xhr.send();
},50);
setTimeout(function init(){
	console.log("init");
	var xhr = new XMLHttpRequest();
	xhr.open('GET', "response.php?action=iconcontrol&button=volume&value=hide&keyNumber="+keyNumber, true);
	xhr.send();
},100);
setTimeout(function init(){
	console.log("init");
	var xhr = new XMLHttpRequest();
	xhr.open('GET', "response.php?action=iconcontrol&button=body&value=hide&keyNumber="+keyNumber, true);
	xhr.send();
},150);
// setTimeout(function (){
	// console.log("init");
	// var xhr = new XMLHttpRequest();
	// xhr.open('GET', "response.php?action=dellog&keyNumber="+keyNumber, true);
	// xhr.send();
// },200);
$("#speechtext").keyup(function(e){
	if(e.keyCode == 13) { //Enter keycode
		speechSubmit();
	}
});
function speechSubmit(){
	var xhr = new XMLHttpRequest();
	console.log(value);
	xhr.open('GET', "response.php?action=savedialoguechoice&value="+value+"&keyNumber="+keyNumber, true);
	xhr.send();
	
	setTimeout(function init(){
		window.location="senior.php";
	},1500);
}
function dialogueSelect(id){
	
	count[id]++;
	value[id] = count[id]%2;
	console.log("count = "+count+"\n value ="+value);
	
}

function slideoneye(){
	eyeCount++;
	var xhr = new XMLHttpRequest();
	if(eyeCount%2==1){
		xhr.open('GET', "response.php?action=iconcontrol&button=eye&value=show&keyNumber="+keyNumber, true);
		xhr.send();
	}
	else{
		xhr.open('GET', "response.php?action=iconcontrol&button=eye&value=hide&keyNumber="+keyNumber, true);
		xhr.send();
	}
	
}
function slideonsmile(){
	console.log("slideonsmile");
	smileCount++;
	var xhr = new XMLHttpRequest();
	if(smileCount%2==1){
		xhr.open('GET', "response.php?action=iconcontrol&button=smile&value=show&keyNumber="+keyNumber, true);
		xhr.send();
	}
	else{
		xhr.open('GET', "response.php?action=iconcontrol&button=smile&value=hide&keyNumber="+keyNumber, true);
		xhr.send();
	}
}
function slideonvolume(){
	volumeCount++;
	var xhr = new XMLHttpRequest();
	if(volumeCount%2==1){
		xhr.open('GET', "response.php?action=iconcontrol&button=volume&value=show&keyNumber="+keyNumber, true);
		xhr.send();
	}
	else{
		xhr.open('GET', "response.php?action=iconcontrol&button=volume&value=hide&keyNumber="+keyNumber, true);
		xhr.send();
	}
}
function slideonbody(){
	bodyCount++;
	var xhr = new XMLHttpRequest();
	if(bodyCount%2==1){
		xhr.open('GET', "response.php?action=iconcontrol&button=body&value=show&keyNumber="+keyNumber, true);
		xhr.send();
	}
	else{
		xhr.open('GET', "response.php?action=iconcontrol&button=body&value=hide&keyNumber="+keyNumber, true);
		xhr.send();
	}
}

</script>
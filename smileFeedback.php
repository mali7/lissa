<?php 
include "include/vars.php";
$session=$_GET['session'];
$keyNumber=$_GET['keyNumber'];
$result = $_GET['result'];
$speechNum=$_GET['speechNum'];
$value=$_GET['value'];
$user=$_GET['user'];
?>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="css/style.css" />
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


</head>
<?php echo $flatuiHeaderImport; ?>
<link rel="stylesheet" href="css/style.css" />
<body>

<div id="videoContainer" style="background:#FFFFFF;position:absolute; left:99.9%;width:10%;text-align:center">
  <video width=5% height="10" style="display: none;" id="localVideo" autoplay="autoplay" muted="true"/></video>

   <script language="JavaScript" type="text/javascript" src="https://vhss-d.oddcast.com/vhost_embed_functions_v2.php?acc=4792750&js=1"></script><script language="JavaScript" type="text/javascript">AC_VHost_Embed(4792750,window.screen.availHeight*0.5,window.screen.availWidth*0.5,'FFFFFF',1,1, 2386865, 0,1,0,'80a93b99403d25afe7a8222be35de0a9',9);</script>
<img src="white.jpg"  width=60% hspace=95% vspace=5% height=60% style="align: center; visibility:visible">
  </div>

<img src="Congrats.jpg" id="eyeFeedbackImg" width=30% hspace=5% vspace=5% height=30%  style="align: center; visibility:visible">

<input type="button" class="btn btn-default btn-lg" id="postfeedback" value="Next" onclick="next()" style="width:290px;  background-color:#c78737;visibility:hidden"  />
<!-- <br><input type="button" hspace=5% vspace=5% class="btn btn-default btn-lg" id="textButton"  style="right:100px; background-color:#000000"  />
-->
<div id= "textdiv" style="position:fixed; font-size:30px; width:50%;height:30%; bottom: 5%; right:25%"> </div>
</body>
</html>
<script>
var session = "<?php echo $session; ?>";
var keyNumber = "<?php echo $keyNumber; ?>";
var result = "<?php echo $result; ?>";
var speechNum= "<?php echo $speechNum; ?>";
var value= "<?php echo $value; ?>";
var user= "<?php echo $user; ?>";
function next(){
	window.location="contentFeedback.php?session="+session+"&keyNumber="+keyNumber+"&result="+result+"&speechNum="+speechNum+"&value="+value+"&user="+user;
}
function showImg(val){
	console.log(val);
	var eyeImg = document.getElementById("eyeFeedbackImg");
	var audio = new Audio("Ding.mp3"); 
	var showspeech = document.getElementById("textdiv");
	if(val == "1"){
		eyeImg.src = "improved-smiling.gif";
		setTimeout(function(){
			audio.play();
			
		},1000);
		showspeech.textContent = "You smiled more frequently. Keep it up.";
		setTimeout(function(){
			sayText("You smiled more frequently. Keep it up.",1,1,3);
			
		},4000);
	}
	else if(val == "2"){
		eyeImg.src = "improved-smiling.gif";
		setTimeout(function(){
			audio.play();
			
		},1000);
		showspeech.textContent = "You smiled frequently with a genuine smile. Keep it up.";
		setTimeout(function(){
			sayText("You smiled frequently with a genuine smile. Keep it up.",1,1,3);
			
		},4000);
	}
	else{
		eyeImg.src = "poor-smiling.gif";
		if (result.length>0){
			var smileinResult = parseInt(result[2]);
			smileinResult = smileinResult+1;
			result = result[0]+result[1]+""+smileinResult+""+result[3];
			console.log("new ressult="+result);
		}
		if (result[1]=="1"){
			showspeech.textContent = "Try smiling more and using your whole face to smile, including your eyes";
			setTimeout(function(){
				sayText("Try smiling more and using your whole face to smile, including your eyes",1,1,3);
				
			},4000);
		}
		else if (result[1]=="2"){
			showspeech.textContent = "Like I mentioned before, try smiling more.";
			setTimeout(function(){
				sayText("Like I mentioned before, try smiling more.",1,1,3);
				
			},4000);
		}
		else{
			showspeech.textContent = "Smiling is very important in helping us engage with others; try to smile as you talk with me. ";
			setTimeout(function(){
				sayText("Smiling is very important in helping us engage with others; try to smile as you talk with me. ",1,1,3);
				
			},4000);
		}
		
	}
	setTimeout(function(){
		document.getElementById("postfeedback").style.visibility= "visible";
	},8000);
}
function vh_talkEnded(){
	setTimeout(function(){
		next();
	},2000);
}
setTimeout(function(){
	showImg(value.substring(2,3));
	// console.log(session+" "+keyNumber);
	// var xhr1 = new XMLHttpRequest();
	// xhr1.onreadystatechange = function() {
		// if (this.readyState == 4) {
			// if (this.status == 200) {
				// console.log(this.responseText);
				// var value = this.responseText.split("\n");
				// var sessionNum = session -1;
				// value = value [0];
				// console.log(value);
				// showImg(value.substring(2,3));
			// }
		// }
	// }
	// xhr1.open('GET', "response.php?action=seniorReadoutput&keyNumber="+keyNumber, true);
	// xhr1.send();
	
},1000);
</script>

<?php 
include "include/vars.php";
$session=$_GET['session'];
$keyNumber=$_GET['keyNumber'];
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
<div id="" style="position: absolute; top:50% ;left:10%" >
<div id="title" style="position:fixed; font-size:35px; color:brown; width:80%;height:30%;top:5%"> </div><br>
<div id= "textdiv" align="justify" style="position:fixed; font-size:30px; width:80%;height:30%;top:12%"> </div><br><br><br>

<input type="button" class="btn btn-default btn-lg" id="EmailMe" value="Email Me" onclick="email()" style="width:290px;  background-color:#c78737 ; visibility:hidden" />

<br><input id="emailAddress" type="text" style="visibility:hidden">
<input type="button" class="btn btn-default btn-lg" id="send" value="send" onclick="sendEmail()" style="width:290px;  background-color:#c78737 ; visibility:hidden" />

</div>
<div id="buttondiv" style="position: absolute; left:10% ; top:60%">
<input type="button" class="btn btn-default btn-lg" id="postfeedback" value="Next" onclick="next()" style="width:290px;  background-color:#c78737 ; visibility:hidden" />
<div>

</body>
</html>
<script>
var session = "<?php echo $session; ?>";
var keyNumber = "<?php echo $keyNumber; ?>";
var user = "<?php echo $user; ?>";
var eye = ["eye contact","weren't making much eye contact", "making eye contact","make a conscious effort to make eye contact with others by starting with people like the check-out cashier at the grocery store, or the receptionist at your doctor's office"];
var vol = ["speaking voice", "spoke softly", "varying the pitch of your voice","recording your speech on your phone or computer and listening for the changes in the pitch of your voice, then practicing changing the pitch to vary it from time to time"];
var content = ["keeping the conversation positive", "spoke about negative topics", "keeping the conversation positive","practice casual conversation with people you encounter during your day and keep the conversation focused on positive topics, remind yourself to smile as a cue to come back to something positive"];
var smile = ["smiling", "didn't smile much", "smiling often","smiling using your whole face in the mirror several times a day"];
var rank = [1,1,1,1];
var sum = [0,0,0,0];
var sumRank = 4;
var say;
var sayHTML;
var strengthText, improveText, suggestText;
var showspeech = document.getElementById("textdiv");
var title = document.getElementById("title");
var improveDone=0;
var suggestDone=0;
var nitems = 0;
function vh_talkEnded(){
	setTimeout(function(){
		next();
	},5000);
}

function next(){
	//window.print();
	if(improveDone==0 && suggestDone == 0){
		improveDone = 1;
		document.getElementById("postfeedback").style.visibility= "hidden";
		showImprove();
	}
	else if (improveDone == 1 && suggestDone == 0){
		document.getElementById("postfeedback").style.visibility= "hidden";
		showSuggest();
		suggestDone = 1;
	}
	else if(improveDone == 1 && suggestDone ==1){
		document.getElementById("postfeedback").style.visibility= "hidden";
		showPrintPage();
	}
}
function showPrintPage(){
	title.textContent = "";
	showspeech.style.fontSize="20px";
	showspeech.innerHTML = strengthText+""+improveText+""+suggestText;
	//document.getElementById("postfeedback").style.visibility= "visible";
	window.print();
	document.getElementById("postfeedback").style.top= "80%";
	
	//document.getElementById("postfeedback").value= "Print";
}
function sendEmail(){
	var email;
	email = document.getElementById("emailAddress").value;
	console.log(email);
	window.open('mailto:email');
}
function email(){
	document.getElementById("emailAddress").style.visibility="visible";
	document.getElementById("send").style.visibility="visible";
}
function showSuggest(){
	sayHTML= "<h4>Suggestions</h4>";
	document.getElementById("postfeedback").value= "Print Summary";
	document.getElementById("buttondiv").style.top = "80%";
	document.getElementById("buttondiv").style.left = "80%";
	nitems = 0;
	var temp = 4- sumRank;
	say = "I encourage you to continue making changes in how you engage with others by practicing ";
	sayHTML += "I encourage you to continue making changes in how you engage with others by practicing ";
	if(rank[0]==0){
		say+= eye[2]+", ";
		temp -=1;
		sayHTML+="<li>"+ eye[2]+", and</li>";
		nitems = 1;
	}
	if(rank[1]==0){
		say += vol[2]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ vol[2]+", and</li>";
		nitems = 1;
	}
	if(rank[2]==0){
		say += smile[2]+ ", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ smile[2]+", and</li>";
		nitems = 1;
	}
	if(rank[3]==0){
		say += content[2]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ content[2]+", and</li>";
		nitems = 1;
	}
	say = say.substring(0,say.length-2);
	sayHTML = sayHTML.substring(0,sayHTML.length-10)+".</li>";
	say += ". You can practice on your own by ";
	sayHTML += "You can practice on your own by ";
	
	temp = 4- sumRank;
	nitems = 0;
	if(rank[0]==0){
		say+= eye[3]+", ";
		temp -=1;
		sayHTML+="<li>"+ eye[3]+", and</li>";
		nitems = 1;
	}
	if(rank[1]==0){
		say += vol[3]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ vol[3]+", and</li>";
		nitems = 1;
	}
	if(rank[2]==0){
		say += smile[3]+ ", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ smile[3]+", and</li>";
		nitems = 1;
	}
	if(rank[3]==0){
		say += content[3]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ content[2]+", and</li>";
		nitems = 1;
	}
	say = say.substring(0,say.length-2);
	say += ". To summarize, I would suggest you work on";
	sayHTML = sayHTML.substring(0,sayHTML.length-10)+".</li>";
	sayHTML += "To summarize, I would suggest you work on";
	temp = 4- sumRank;
	nitems = 0;
	if(rank[0]==0){
		say+= eye[0]+", ";
		temp -=1;
		sayHTML+="<li>"+ eye[0]+", and</li>";
		nitems = 1;
	}
	if(rank[1]==0){
		say += vol[0]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ vol[0]+", and</li>";
		nitems = 1;
	}
	if(rank[2]==0){
		say += smile[0]+ ", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ smile[0]+", and</li>";
		nitems = 1;
	}
	if(rank[3]==0){
		say += content[0]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ content[0]+", and</li>";
		nitems = 1;
	}
	say = say.substring(0,say.length-2)+".";
	sayHTML = sayHTML.substring(0,sayHTML.length-10)+".</li>";
	showspeech.innerHTML = sayHTML;
	console.log(say);
	suggestText=sayHTML;
	setTimeout(function(){
		document.getElementById("postfeedback").style.visibility= "visible";
		//document.getElementById("EmailMe").style.visibility= "visible";
		sayText(say,1,1,3);
	},3000);
}
function showImprove(){
	sayHTML = "<h4>Areas You Need to Improve</h4>";
	console.log(sayHTML);
	nitems = 0;
	say = "When you started our conversation, you ";
	sayHTML += "When you started our conversation, you ";
	console.log(sayHTML);
	var temp = 4-sumRank;
	if(rank[0]==0){
		temp -=1;
		say+= eye[1]+", ";
		sayHTML+="<li>"+ eye[1]+", and</li>";
		nitems = 1;
	}
	if(rank[1]==0){
		say += vol[1]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ vol[1]+", and</li>";
		nitems = 1;
	}
	if(rank[2]==0){
		say += smile[1]+ ", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ smile[1]+", and</li>";
		nitems = 1;
	}
	if(rank[3]==0){
		say += content[1]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ content[1]+", and</li>";
		nitems = 1;
	}
	say = say.substring(0,say.length-2);
	say+= ". I gave you feedback on how you engaged with me and you made positive changes.";
	sayHTML = sayHTML.substring(0,sayHTML.length-10)+".</li>";
	sayHTML += "I gave you feedback on how you engaged with me and you made positive changes.";
	showspeech.innerHTML = sayHTML;
	console.log(sayHTML);
	improveText = sayHTML;
	setTimeout(function(){
		document.getElementById("postfeedback").style.visibility= "visible";
		sayText(say,1,1,3);
	},3000);
}
function showStrength(){
	sayHTML = "<h4>Your Strength</h4>";
	sayHTML +="You engaged in an entire conversation with me and you did well with ";
	say ="You engaged in an entire conversation with me and you did well with ";
	var temp = sumRank;
	if(rank[0]==1){
		temp -=1;
		say+= eye[0]+", ";
		sayHTML+="<li>"+ eye[0]+", and</li>";
		nitems =1;
	}
	if(rank[1]==1){
		say += vol[0]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+ vol[0]+", and</li>";
		nitems =1;
	}
	if(rank[2]==1){
		say += smile[0]+ ", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML +="<li>"+  smile[0]+", and</li>";
		nitems =1;
	}
	if(rank[3]==1){
		say += content[0]+", ";
		temp -=1;
		if(temp != 0 && nitems !=0){
			sayHTML = sayHTML.substring(0,sayHTML.length-8) ;
			sayHTML +="</li>";
		}
		sayHTML += "<li>"+ content[0]+", and</li>";
		nitems = 0;
	}
	say = say.substring(0,say.length-2) +".";
	sayHTML = sayHTML.substring(0,sayHTML.length-10) +".";
	showspeech.innerHTML = sayHTML;
	console.log(say);
	strengthText = sayHTML;
	setTimeout(function(){
		document.getElementById("postfeedback").style.visibility= "visible";
		sayText(say,1,1,3);
	},3000);
}

function arrayMin(arr) {
  var len = arr.length, min = Infinity;
  while (len--) {
    if (arr[len] < min) {
      min = arr[len];
    }
  }
  return min;
};

setTimeout(function(){
	console.log(session+" "+keyNumber);
	var xhr1 = new XMLHttpRequest();
	xhr1.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				console.log(this.responseText);
				var s = this.responseText.split(" ");
				var i =0;
				for(i = 0; i<s.length-1;i++){
					var str = s[i];
					if(str.length>=4){
						console.log(str);
						sum[0] += parseInt(str[0]);
						sum[1] += parseInt(str[1]);
						sum[2] += parseInt(str[2]);
						sum[3] += parseInt(str[3]);
					}
				}
				console.log(sum);
				var min = arrayMin(sum);
				console.log(min);
				for(i=0;i<4;i++){
					if(sum[i]==min){
						rank[i]=0;
						sumRank -=1;
						sum[i]=1000;
						break;
					}
				}
				var min2 =arrayMin(sum);
				for(i=0;i<4;i++){
					if(sum[i]==min2 && (min2 - min)< 3 ){
						rank[i]=0;
						sumRank -=1;
						sum[i]=1000;
						break;
					}
				}
				console.log(rank);
				console.log(sum);
				showStrength();
			}
		}
	}
	xhr1.open('GET', "response.php?action=seniorReadoutputFinal&keyNumber="+keyNumber+"&user="+user, true);
	xhr1.send();
	
},1000);
</script>

<?php 
include "include/vars.php";
$session=$_GET['session'];
$keyNumber=$_GET['keyNumber'];
$result = $_GET['result'];
$speechNum=$_GET['speechNum'];
$user = $_GET['user'];
$dataKey = $_GET['dataKey'];
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
<img src="Congrats.jpg"  width=60% hspace=5% vspace=5% height=60% style="align: center; visibility:visible">
<input type="button" class="btn btn-default btn-lg" id="postfeedback" value="Next" onclick="next()" style="width:290px;  background-color:#c78737"  />
</body>
</html>
<script>
var keyNumber = "<?php echo $keyNumber; ?>";
var session = "<?php echo $session; ?>";
var result = "<?php echo $result; ?>";
var speechNum= "<?php echo $speechNum; ?>";
var user= "<?php echo $user; ?>";
var dataKey= "<?php echo $dataKey; ?>";
var filefound = false;
var timer=0;


setTimeout(function(){
	checkForDefault();
	var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (this.readyState == 4) {
					if (this.status == 200) {
						console.log("result: "+this.responseText);
						if(this.responseText.length>=2){
							filefound = true;
							next();
						}
						
					}
				}	
			}
	xhr.open('GET', "response.php?action=seniorProcess&keyNumber="+keyNumber+"&dataKey="+dataKey+"&user="+user, true);
	xhr.send();
	
},500);


						
						
// setTimeout(function(){
	// checkForDefault();
	// var xhr = new XMLHttpRequest();
			// xhr.onreadystatechange = function() {
				// if (this.readyState == 4) {
					// if (this.status == 200) {
						// console.log("key: "+this.responseText);
						// if(this.responseText.length>=2){
							// filefound = true;
							// result = this.responseText;
							// console.log("result ="+ result );
							// //next();
						// }
						// else{
							// console.log("checking for feedback file");
							// xhr.open('GET', "response.php?action=findDoneFeedback&user="+user+"", true);
							// xhr.send();
						// }
					// }
				// }	
			// }
	// xhr.open('GET', "response.php?action=findDoneFeedback&user="+user+"", true);
	// xhr.send();
	
// },500);
function checkForDefault(){
	setInterval(function(){
		timer++;
		if (timer > 300 && filefound==false){
			next();
		}
	},1000);
}
function next(){
	window.location="eyeFeedback.php?session="+session+"&keyNumber="+keyNumber+"&result="+result+"&speechNum="+speechNum+"&user="+user;
}
</script>

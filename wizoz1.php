<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>L.I.S.S.A Wizard of Oz</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="LISSA/LISSA/css/bootstrap.min.css" rel="stylesheet">
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<script src="LISSA/LISSA/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="navbar navbar-default navbar-static-top">
		  <div class="container">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">L.I.S.S.A Wizard of Oz</a>
		    </div>
		    <!--
				  <div class="col-md-3">
				    <input id="keyNumber" type="text"  placeholder="Key">
				  </div>
				  <button onclick="getkeyNumber()" type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
			-->
		  </div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-6">		
					
				    <input id="keyNumber" type="text"  placeholder="Key">
				  
				  <button onclick="getkeyNumber()" id="keyButton" type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></button>
			
				
					<h3>Set Expression</h3>
					<div class="btn-group" style="margin-top:5px;margin-bottom:5px;" role="group" aria-label="lalala">
						<button type="button" class="btn btn-info" onclick = "setExpression(0)" >neutral</button>
						<button type="button" class="btn btn-info" onclick = "setExpression(8)" >thinking</button>
						<button type="button" class="btn btn-info" onclick = "setExpression(7)" >surprised</button>
						<button type="button" class="btn btn-success" onclick = "setExpression(1)" >happy</button>
						<button type="button" class="btn btn-success" onclick = "setExpression(2)" >very happy</button>
					</div><br/>
					<div class="btn-group" style="margin-top:5px;margin-bottom:5px;" role="group" aria-label="...">
						<button type="button" class="btn btn-primary" onclick = "setExpression(5)" >afraid</button>
						<button type="button" class="btn btn-primary" onclick = "setExpression(3)" >sad</button> 
						<button type="button" class="btn btn-primary" onclick = "setExpression(9)" >blush</button>
						<button type="button" class="btn btn-danger" onclick = "setExpression(6)" >disgusted</button>  
						<button type="button" class="btn btn-danger" onclick = "setExpression(4)" >angry</button> 
					</div>
					<h3>Speech </h3>
						<textarea rows="4" cols="60" id="speechtext"></textarea>
					<button type="button" style="vertical-align:top;" class="btn btn-success" onclick = "speechSubmit()" >Send</button>
				</div>
				<div class="col-md-6">
					<h3>Predefined</h3>
					  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingOne">
					      <h4 class="panel-title">Greetings</h4>
					    </div>
					    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Nice to meet you<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">Yes</h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingThree">
					      <h4 class="panel-title">No</h4>
					    </div>
					    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingFour">
					      <h4 class="panel-title">Questions</h4>
					    </div>
					    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Hi, I am Lissa. How are you?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					</div>
					</div>
				</div><!-- /.container -->
		</div>
		<script type="text/javascript">
			var text = document.getElementById('speechtext');
			var lastButton=0;
			var keyNumber;
			
			function getkeyNumber(){
				keyNumber = document.getElementById("keyNumber").value;
				console.log(keyNumber);
				document.getElementById("keyNumber").value="";
				document.getElementById("keyNumber").disabled = "disabled";
				document.getElementById("keyButton").disabled = "disabled";
				
			}
			
			function speechSubmit(){
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=savespeech&value="+text.value+"&keyNumber="+keyNumber, true);
				xhr.send();
				console.log(text.value);
				console.log("hay="+keyNumber);
				text.value="";
			}
			
			$(".list-group-item").click(function() {
				var say = $(this).text();
				//var sayIndex= say.indexOf('1');
				var splitList=['1','2'];
				say = say.split(/[0-9]/)[0];
				console.log(say);
				var timesUsed = parseInt($(this).children().text(), 10);
				timesUsed = timesUsed || 0
				++timesUsed;
				$(this).children().text(timesUsed);
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
				xhr.send();
			});
			
			function setExpression(expressionId){
				var say="Exp"+expressionId;
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
				xhr.send();
			}
			function defaultButton(buttonId){
				console.log(document.getElementById('1').value);
				var say=document.getElementById(buttonId.toString()).value;
				console.log(say);
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
				xhr.send();
			}
		</script>
	</body>
</html>
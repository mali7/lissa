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
		<script src="js/bootstrap.min.js"></script>
		
		<link href="LISSA/LISSA/css/bootstrap.min.css" rel="stylesheet">
		
		<script src="LISSA/LISSA/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="navbar navbar-default navbar-static-top">
		  <div class="container">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">L.I.S.S.A Wizard of Oz</a>
		    </div>
		 <!--
				  <button  id="onButton" type="submit" class="btn btn-default"><span class="glyphicons glyphicons-user-conversation"></span></button>
			-->
		  </div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-6">
						<button  type="submit" class="btn btn-default"><span id ="onButton"class="glyphicon glyphicon-facetime-video" style="color:red"></span></button>
			
					<input id="keyNumber" type="text"  placeholder="Key">
				  
				  <button onclick="getkeyNumber()" id="keyButton" type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></button>
				  <button onclick="clearSpeech()" id="keyButton" type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> clear</button>
			
					<h3>Set Expression</h3>
					<div class="btn-group" style="margin-top:5px;margin-bottom:5px;" role="group" aria-label="lalala">
						<button type="button" class="btn btn-info" onclick = "setExpression(0)" >neutral</button>
						<button type="button" class="btn btn-info" onclick = "setExpression(8)" >thinking</button>
						<!--
						<button type="button" class="btn btn-info" onclick = "setExpression(7)" >surprised</button>
						-->
						<button type="button" class="btn btn-success" onclick = "setExpression(1)" >happy</button>
						<!--
						<button type="button" class="btn btn-success" onclick = "setExpression(2)" >very happy</button>
						-->
					</div><br/>
					<div class="btn-group" style="margin-top:5px;margin-bottom:5px;" role="group" aria-label="...">
						<button type="button" class="btn btn-primary" onclick = "setExpression(5)" >NOPE</button>
						<button type="button" class="btn btn-primary" onclick = "setExpression(3)" >Hard NOD</button> 
						<button type="button" class="btn btn-primary" onclick = "setExpression(9)" >blush</button>
						<!--
						<button type="button" class="btn btn-danger" onclick = "setExpression(6)" >disgusted</button>
-->						
						<button type="button" class="btn btn-danger" onclick = "setExpression(4)" >NOD</button> 
					</div>
					<h3>Check Dialogue Group</h3>
					<div class="btn-group" style="margin-top:5px;margin-bottom:5px;" role="group" aria-label="lalala">
						<button type="button" class="btn btn-primary" onclick = "CheckDialogue()" >Click to check allowed dialogue</button>
						<br/>
						<button type="button" id="dialogue1" class="btn btn-info" onclick = "CheckDialogue(1)" >Where are you from</button><br/>
						<button type="button" id="dialogue2" class="btn btn-info" onclick = "CheckDialogue(1)" >Activities You like to do</button><br/>
						
						<button type="button" id="dialogue3" class="btn btn-info" onclick = "CheckDialogue(2)" >Family and Friends</button><br/>
						<button type="button" id="dialogue4" class="btn btn-info" onclick = "CheckDialogue(3)" >Getting with Others</button><br/>
						<button type="button" id="dialogue5" class="btn btn-info" onclick = "CheckDialogue(4)" >Tell me about yourself</button> 
					</div>
					 
					<h4>Speech</h4>
						<textarea  rows="3" cols="60" id="speechtext" name="speechtext"></textarea>
					<button type="button" style="vertical-align:top;" class="btn btn-success" onclick = "speechSubmit()" >Send</button>
					<h4>Feedback</h4>
						<textarea  rows="1" cols="60" id="feedback" name="feedback"></textarea>
					<button type="button" style="vertical-align:top;" class="btn btn-success" onclick = "feedbackSubmit()" >Send</button>
					<h3>Quick Replies</h3>
					  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseEnd" aria-expanded="true" aria-controls="collapseEnd" class="panel-heading" role="tab" id="headingEnd">
					      <h4 class="panel-title">End conversation</h4>
					    </div>
					    <div id="collapseEnd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEnd">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">endone<span class="badge"></span></a>
							<a href="#" class="list-group-item">reset<span class="badge"></span></a>
							<a href="#" class="list-group-item">endthree<span class="badge"></span></a>
							<a href="#" class="list-group-item">endfour<span class="badge"></span></a>
							<a href="#" class="list-group-item">endfive<span class="badge"></span></a>
							<a href="#" class="list-group-item">endsix<span class="badge"></span></a>
							<a href="#" class="list-group-item">endfinal<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  
					  
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="true" aria-controls="collapse1" class="panel-heading" role="tab" id="heading1">
					      <h4 class="panel-title">Evasive Answers</h4>
					    </div>
					    <div id="collapse1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading1">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">That might be a little too personal for me. As a computer program, I am still trying to figure my stuff out.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Whatever, tell me more about you…<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">We were discussing you, not me.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I cannot think of anything else to say about that.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I would	 rather not talk about that... Lets talk about something more fun!<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse0" aria-expanded="true" aria-controls="collapse0" class="panel-heading" role="tab" id="heading0">
					      <h4 class="panel-title">Repeat</h4>
					    </div>
					    <div id="collapse0" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading0">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Say that again?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I am not sure I understand you fully.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I'm sorry. Could you repeat that?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I am sorry. I forgot we already talked about that.<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2" class="panel-heading" role="tab" id="heading2">
					      <h4 class="panel-title">Encouraging Answers</h4>
					    </div>
					    <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
					      <div class="list-group">
							<a href="#" class="list-group-item">That's funny, but lets get back to talking about you.<span class="badge"></span></a>

							<a href="#" class="list-group-item">oh that's sweet<span class="badge"></span></a>

							<a href="#" class="list-group-item">sorry to interrupt you. Can you say that again.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">That is interesting!<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I understand<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Really? wow!<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">That's so true!<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="true" aria-controls="collapse3" class="panel-heading" role="tab" id="heading3">
					      <h4 class="panel-title">Prompts (when they stop)</h4>
					    </div>
					    <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Come on, don't be shy… tell me more about it!<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Go on...<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Tell me more!<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Tell me more about that.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Can you give me an example?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse4" aria-expanded="true" aria-controls="collapse4" class="panel-heading" role="tab" id="heading4">
					      <h4 class="panel-title">Why</h4>
					    </div>
					    <div id="collapse4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading4">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Why?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Why do you say that?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Really? Why?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Why not?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseEnd" aria-expanded="true" aria-controls="collapseEnd" class="panel-heading" role="tab" id="headingEnd">
					      <h4 class="panel-title">Ending phrases</h4>
					    </div>
					    <div id="collapseEnd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEnd">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Oh my god! I lost track of the time... how about you look over the feedback and I will see you in a few minutes! Please click on the stop button to end this conversation. Bye!<span class="badge"></span></a>
					  
							<a href="#" class="list-group-item">That sounds reasonable. Listen, I think we need to finish for today, but it has been great knowing you! Good luck with the second round of dates! Please click on the stop button to end this conversation. Bye!<span class="badge"></span></a>
							</div>
					    </div>
					  </div>
					</div>
				</div>
				<div class="col-md-6">
				<button  type="submit" class="btn btn-default" placeholder="Start Chat" onclick="SaveTime()" >Start Chat <span id ="startChat"class="glyphicon glyphicon-earphone" style="color:red"></span></button>
			
					<h3>First Chat</h3>
					  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingOne">
					      <h4 class="panel-title">Introduction & Getting to know you(Must)</h4>
					    </div>
					    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi, I am Lissa. I am a computer character. I am here to help you practice talking about yourself when you meet new people in your community, so we will have a conversation focused on you. This will be more helpful if you give longer answers.<span class="badge"></span></a>
					        <a href="#" class="list-group-item">The people who programmed me have spoken with adults who have recently moved to a senior living community.<span class="badge"></span></a>
							<a href="#" class="list-group-item">I may sound choppy, but I am still able to have a conversation with you.<span class="badge"></span></a>
							<a href="#" class="list-group-item">During the conversation, I will try to help you talk with me in a way that will be good practice when you are meeting new people. To do that, I will give you feedback during breaks in our conversation. I will show you a picture on the screen and tell you some areas to work on as well. Try not to take the feedback personally; I just want to help.<span class="badge"></span></a>
							<a href="#" class="list-group-item">My feedback will focus on eye contact, speaking voice, smiling, and staying positive. <span class="badge"></span></a>
							<a href="#" class="list-group-item">Now that we’ve gotten through the basics, please tell me about yourself. I’m looking forward to getting to know you better.<span class="badge"></span></a>
					        <a href="#" class="list-group-item">Tell me a bit about your day today. For example, what did you have for breakfast?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Speaking of food, what is your favorite flavor of ice cream?<span class="badge"></span></a>
							<a href="#" class="list-group-item">And do you have a favorite food? What is it and why do you like it?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How did you get here today? Did someone drive you or did you take the bus?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Let's pause here so I can give you feedback.<span class="badge"></span></a>
							
							</div>
					    </div>
					  </div>
					  
					  
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">Where Are You From</h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Where are you from?<span class="badge"></span></a>
							<a href="#" class="list-group-item">That's a nice area.<span class="badge"></span></a>
							<a href="#" class="list-group-item">It's nice to meet a Rochester native.<span class="badge"></span></a>
							<a href="#" class="list-group-item">Can you tell me more about where you're from?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How did you the weather there?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Makes sense.<span class="badge"></span></a>
							<a href="#" class="list-group-item">I hear what you are saying.<span class="badge"></span></a>
							<a href="#" class="list-group-item">Can you tell me what you liked and didn't like about the weather?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How did you end up in Rochester?<span class="badge"></span></a>
							<a href="#" class="list-group-item">I'm sorry to hear that.<span class="badge"></span></a>
							<a href="#" class="list-group-item">That makes sense.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I understand.<span class="badge"></span></a>
							<a href="#" class="list-group-item">Let's pause here so I can give you feedback.<span class="badge"></span></a>
							</div>
					    </div>
					  </div>
					  
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseRoc" aria-expanded="true" aria-controls="collapseRoc" class="panel-heading" role="tab" id="headingRoc">
					      <h4 class="panel-title">Activities You Like to Do</h4>
					    </div>
					    <div id="collapseRoc" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingRoc">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Do you have any hobbies or anything in particular you like to do for fun? <span class="badge"></span></a>
							<a href="#" class="list-group-item">That makes sense.<span class="badge"></span></a>
							<a href="#" class="list-group-item">Me too, I also enjoy those activities. <span class="badge"></span></a>
							<a href="#" class="list-group-item">I'm sorry to hear that. How do you spend your days?<span class="badge"></span></a>
							<a href="#" class="list-group-item">tell me more about what do you do in your free time?<span class="badge"></span></a>
							<a href="#" class="list-group-item">I used to play tennis regularly, but with my back, I haven't been able to these days. Luckily love to read and they have a great library here, so I'm not usually bored. Do you like to read?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What other things do you enjoy?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What kind of things do you like to read?  <span class="badge"></span></a>
							<a href="#" class="list-group-item">What are you currently reading? <span class="badge"></span></a>
							<a href="#" class="list-group-item">I haven't read that one yet. What's it about? <span class="badge"></span></a>
							<a href="#" class="list-group-item">I'm looking for something new to read. Are there any particular books you would recommend?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Thanks for the recommendation.<span class="badge"></span></a>
							<a href="#" class="list-group-item">What kinds of things do you like to do in your neighborhood, like going to coffee shops, the theater, or the movies?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Let's pause here so I can give you feedback.<span class="badge"></span></a>
					      	
							</div>
					    </div>
					  </div>
					  
					</div>
					<h3>Second Chat</h3>
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingThree">
					      <h4 class="panel-title">Family and Friends + Getting with others</h4>
					    </div>
					    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Now I’d like to learn about your family and friends. Do you live by yourself or with others?<span class="badge"></span></a>
							<a href="#" class="list-group-item">I understand. How is it for you living alone?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How long have you been married?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How long have you lived there?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Do you have children or grandchildren?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Sounds wonderful. Tell me about them.<span class="badge"></span></a>
							<a href="#" class="list-group-item">How often do you get to see them?<span class="badge"></span></a>
							<a href="#" class="list-group-item">I understand. What are things do you do to be around other people?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Do you use facebook or skype to keep in touch with family and friends who are farther away?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What do you like best about it?<span class="badge"></span></a>
							<a href="#" class="list-group-item">How else do you keep in touch with friends and family?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Tell me about your friends.<span class="badge"></span></a>
							<a href="#" class="list-group-item">I’m glad to hear you have friends in your life.<span class="badge"></span></a>
							<a href="#" class="list-group-item">Can you tell me more? Is there something you want to change?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Let's pause here so I can give you feedback.<span class="badge"></span></a>
							
							<a href="#" class="list-group-item">What do you usually do for holidays, like Thanksgiving?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What's the best part?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Are there other holidays you prefer?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Have you been to any weddings recently, or other family gatherings?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Sounds nice.<span class="badge"></span></a>
							<a href="#" class="list-group-item">What about talking to people on the phone? <span class="badge"></span></a>
							<a href="#" class="list-group-item">Thinking about other people in your life, do you have a primary care physician, like your family doctor, or the doctor you see when you get sick?<span class="badge"></span></a>
							<a href="#" class="list-group-item">Do you feel comfortable talking with your doctor?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What makes you feel comfortable?<span class="badge"></span></a>
							<a href="#" class="list-group-item">where do you go when you get sick?<span class="badge"></span></a>
							
							<a href="#" class="list-group-item">Let's pause here so I can give you feedback.<span class="badge"></span></a>
					      	
							</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingFour">
					      <h4 class="panel-title">Tell me about yourself</h4>
					    </div>
					    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">What do you think are your best qualities – the things you like best about yourself?<span class="badge"></span></a>
							<a href="#" class="list-group-item">What are some areas you want to grow in – things you would like to change about yourself?<span class="badge"></span></a>
							
							<a href="#" class="list-group-item">Tell me about your hopes and wishes for the future.<span class="badge"></span></a>
								
							</div>
					    </div>
					  </div>
					</div>
					</div>
				</div><!-- /.container -->
		</div>
		<script type="text/javascript">
			var text = document.getElementById('speechtext');
			var feedback = document.getElementById('feedback');
			var but = document.getElementById('onButton');
			var originalKey;
			var lastButton=0;
			var keyNumber;
			var x=0;
			function CheckDialogue(){
				var xhr1 = new XMLHttpRequest();
				xhr1.onreadystatechange = function() {
					if (this.readyState == 4) {
						if (this.status == 200) {
							console.log(this.responseText);
							var x = this.responseText.split(",");
							for (var i=1; i<=5;i++ ){
								var name = "dialogue"+i;
								if(x[i-1]==1){
									document.getElementById(name).className ="btn btn-success";
								}
								else{
									document.getElementById(name).className ="btn btn-danger";
								}
							}
						}
					}
					
				}
				
				xhr1.open('GET', "response.php?action=readdialoguechoice&keyNumber="+keyNumber, true);
				xhr1.send();
			}
			function SaveTime(){
				if(but.style.color=="green"){
					var xhr1 = new XMLHttpRequest();
					xhr1.open('GET', "response.php?action=saveTime&keyNumber="+keyNumber, true);
					xhr1.send();
					document.getElementById('startChat').style.color="green";
				}
			}
			function checkon(){
			//console.log("here1");
				var xhr1 = new XMLHttpRequest();
				xhr1.onreadystatechange = function() {
				//	console.log("this.status "+this.status);
					if (this.readyState == 4) {
						if (this.status == 200) {
							//console.log("this.responseText "+this.responseText+" "+x);
							if(this.responseText== "Yes"){
								but.style.color="green";
							}
							else{
								but.style.color="red";
								document.getElementById('startChat').style.color="red";
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
				originalKey = keyNumber;
				document.getElementById("keyNumber").value=keyNumber;
				//document.getElementById("keyNumber").disabled=true;
				document.getElementById("feedback").disabled=false;
				checkon();
				
			}
			
			function speechSubmit(){
				console.log("inside speech submit");
				//var text = $("#speechtext");
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=savespeech&value="+text.value+"&keyNumber="+keyNumber, true);
				xhr.send();
				console.log(text.value);
				text.value="";
			}
			function feedbackSubmit(){
				console.log("inside feedback submit");
				//var text = $("#speechtext");
				var xhr = new XMLHttpRequest();
				var keyy = parseInt(keyNumber);
				xhr.open('GET', "response.php?action=savefeedback&value="+feedback.value+"&keyNumber="+keyy, true);
				xhr.send();
				console.log(feedback.value);
				feedback.value="";	
				//feedback.disabled=true;
			}
			$("#feedback").keyup(function(e){
				if(e.keyCode == 13) { //Enter keycode
					feedbackSubmit();
			 	}
			});
			$("#speechtext").keyup(function(e){
				if(e.keyCode == 13) { //Enter keycode
					speechSubmit();
			 	}
			});
			
			$(".list-group-item").click(function() {
				var say = $(this).text();
				var splitList=['1','2'];
				say = say.split(/[0-9]/)[0];
				console.log(say);
				var timesUsed = parseInt($(this).children().text(), 10);
				timesUsed = timesUsed || 0
				++timesUsed;
				$(this).children().text(timesUsed);
				var xhr = new XMLHttpRequest();
				var flag =0;
				if (say == "endone"){
					keyNumber = parseInt(originalKey)+1;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 1;
				}
				if (say == "endtwo"){
					keyNumber = parseInt(originalKey)+2;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 2;
				}
				if (say == "endthree"){
					keyNumber = parseInt(originalKey)+3;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 3;
				}
				if (say == "endfour"){
					keyNumber = parseInt(originalKey)+4;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 4;
				}
				if (say == "endfive"){
					keyNumber = parseInt(originalKey)+5;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 5;
				}
				if (say == "endsix"){
					keyNumber = parseInt(originalKey)+6;
					document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 6;
				}
				if (say == "endfinal"){
					//keyNumber = parseInt(originalKey)+7;
					//document.getElementById("keyNumber").value=keyNumber;
					feedback.disabled=false;
					flag = 0;
				}
				if(flag >=1){
					
					var keyy = parseInt(keyNumber) - flag;
					flag = 0;
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyy, true);
					xhr.send();
				}
				else {
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
					xhr.send();
				}
				
			});
	
			function setExpression(expressionId){
				if(expressionId==4){
					var say="nod";
					var xhr = new XMLHttpRequest();
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
					xhr.send();
				}
				else if(expressionId==5){
					var say="nop";
					var xhr = new XMLHttpRequest();
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
					xhr.send();
				}
				else if(expressionId==3){
					var say="nHp";
					var xhr = new XMLHttpRequest();
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
					xhr.send();
				}
				else{
					var say="Exp"+expressionId;
					var xhr = new XMLHttpRequest();
					xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
					xhr.send();
				}
			}
			function clearSpeech(){
				keyNumber = document.getElementById("keyNumber").value;
				var xhr = new XMLHttpRequest();
				xhr.open('GET', "response.php?action=clearSpeech&keyNumber="+keyNumber, true);
				xhr.send();
			}
		</script>
	</body>
</html>
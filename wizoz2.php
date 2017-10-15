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
					 
					<h3>Speech</h3>
						<textarea  rows="4" cols="60" id="speechtext" name="speechtext"></textarea>
					<button type="button" style="vertical-align:top;" class="btn btn-success" onclick = "speechSubmit()" >Send</button>
										<h3>Quick Replies</h3>
					  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
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
					      	<a href="#" class="list-group-item">I’m sorry. Could you repeat that?<span class="badge"></span></a>
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
					      	<a href="#" class="list-group-item">That’s so true!<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="true" aria-controls="collapse3" class="panel-heading" role="tab" id="heading3">
					      <h4 class="panel-title">Prompts (when they stop)</h4>
					    </div>
					    <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Come on, don’t be shy… tell me more about it!<span class="badge"></span></a>
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
					      <h4 class="panel-title">Introduction</h4>
					    </div>
					    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hi I am LISSA. I am an autonomous avatar and my behaviour is driven by artificial intelligence.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I may sound choppy, but I am still able to have a conversation with you.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I am here to help you practice talking about yourself, so we will have a conversation focused on you. This will be more helpful, if you give longer answers.<span class="badge"></span></a>
							<a href="#" class="list-group-item">During the conversation, the system will try its best to prompt you on your eye contact, volume, body movements, and smiling.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">If the eye icon flashes red, it means you can try making more eye contact.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">If the smiley face flashes red, perhaps you could try smiling more.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">If the speaker icon flashes red, then pay attention to your voice. You might need to speak up or you might need to quiet down.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">If the shaking person icon flashes red, then pay attention to your body. Can you be more animated? Is your posture okay?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">As you make these adjustments, the icon will switch back to green.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Alright, lets get to know each other more. I am a senior comp sci major, how about you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What was your favourite class so far?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Did you find it hard?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I liked Artificial Intelligence! that was my favourite by far! Though obviously, I am a little bit biased on the subject. I really think the material is great and the prof is even better.<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseRoc" aria-expanded="true" aria-controls="collapseRoc" class="panel-heading" role="tab" id="headingRoc">
					      <h4 class="panel-title">Living in City</h4>
					    </div>
					    <div id="collapseRoc" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingRoc">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">So how long have you lived here in Rochester?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Wow! That is longer than I have been anywhere. So what do you like most about this city?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What don’t you like about the city?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Ugh, yeah, that would bother me too. Is there anything you would change?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I’ve never heard of that. Could you tell me more about it?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">If you can’t tell, I haven’t seen much of the city at all. What would we do if you took me on a tour?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">One thing I always wonder about are good places to eat. You might not think it by looking at me, but I think restaurants are just great. I love to watch people enjoy their food. I also love the way that every place has its own unique atmosphere. It does not have to be fancy, I also love those dirty spoon, hole in the wall restaurants that have a really fun and cool vibe. Could you tell me about your favorite place to eat here in Rochester?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">And what is this whole garbage plate thing about?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Tell me more about your free time, do you like watching TV and movies, or are you more of a book reader?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">Movies</h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Yeah I like books too, but I prefer movies... come on! you must have gone to the cinema at least once in your life! what type of movies do you like to watch?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">I also like watching tv and movies. what type of movies do you like to watch?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Have you seen the movie “Guardians of the Galaxy”?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Which part of the movie did you like the most?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">My favorite character in Guardians of the Galaxy is Groot. I think he is very cute! what about you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">what is your favorite movie?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Haven’t seen it. Could you tell me what its about?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Sounds interesting. So why is it your favorite movie?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Perhaps I will see if its on Netflix. Netflix is so much better than going to the movies, right? Do you prefer Netflix or going to the movies?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So talk me through your perfect movie night. Who would you go with?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What would you do after?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So talk me through your perfect night at home watching Netflix? Who would you be watching with? Where would you be watching?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So another thing I like about Netflix is the way you can get full shows. I am a HUGE binge watcher. In fact, sometimes I can go the whole evening watching Friends episodes without even realizing how much time has gone by. Its a little embarassing. <span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Oh no. I could never survive college without Netflix! Do you have another way of watching new shows?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So what kinds of shows do you like to watch? Mysteries, comedies, something else?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">And what’s that about? Don’t worry about spoiling it for me.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Tell me about your favorite character.<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					</div>
					<h3>Second Chat</h3>
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingThree">
					      <h4 class="panel-title">Introduction - Home</h4>
					    </div>
					    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">Hello again, its nice to see you. We are going to pick up our conversation where we left off. While we talk, the system will continue giving you feedback in the same way it gave you feedback before.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So I know we talked a bit about Rochester before. Have you thought about what city you’d want to move to next?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Huh? Why is it special to you?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">And tell me more about the kind of home you would want live in?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">So what if money was not an issue and you could live anywhere in the world. Where would you go?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">That sounds so cool. And what would your dream home be like?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What I love about stories of rich peoples homes is that they always have some kind of crazy room. Like a horse room, a Lego room, or a room for their hundreds of guitars. It really gives you a sense of what they are into and what is special to them. Like me. I would really love a room filled with video game systems. Not just the newest ones, but every single video game system ever made from the Atari right to the newest Xbox. And there would be a separate TV set for every sytem so I would not even have to worry about plugging things in.<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What do you think your crazy room would be?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Wow, you must be really into that. So now that I know a little bit about you, I am getting curious, where did you grow up?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Ive never been there, what do you think is the biggest difference between your hometown and living here?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Tell me, what do you miss about your hometown?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">What do you like better here?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">Do you stay in touch with any of your friends from home?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					  <div class="panel panel-info">
					    <div style="cursor:pointer" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseOne" class="panel-heading" role="tab" id="headingFour">
					      <h4 class="panel-title">Career Plans</h4>
					    </div>
					    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
					      <div class="list-group">
					      	<a href="#" class="list-group-item">So with this whole major thing: What are your plans after you graduate?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">That sounds great. And what is your dream job?<span class="badge"></span></a>
					      	<a href="#" class="list-group-item">For me, my dream job would be as a programmer for some small startup company. I think it would be especially fun if I could do it with a bunch of friends I already knew from college. I think it would be great if the people you work with are also people you really enjoy spending time with. But maybe it could also be bad if the only people you hang out with after work are the same guys that you got sick of during the day. What are your thoughts about work friends?<span class="badge"></span></a>
								</div>
					    </div>
					  </div>
					</div>
					</div>
				</div><!-- /.container -->
		</div>
		<script type="text/javascript">
			var text = document.getElementById('speechtext');
			var but = document.getElementById('onButton');
			
			var lastButton=0;
			var keyNumber;
			var x=0;
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
							console.log("this.responseText "+this.responseText+" "+x);
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
				document.getElementById("keyNumber").value="";
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
				xhr.open('GET', "response.php?action=savespeech&value="+say+"&keyNumber="+keyNumber, true);
				xhr.send();
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
		</script>
	</body>
</html>
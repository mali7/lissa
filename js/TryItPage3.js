var startButton, stopButton;
var localVideo;
var localStream;
var xmlhttp;
var isVideoMuted = false;
var isAudioMuted = false;

var recorder;
var splitRecorder;
var splitAudioRecording, splitVideoRecording;
var splitCount;
var splitTimer;
var processRecordingCount=1;
var processRecordingRealTimer;
var checkGetDataRealTimer;
var checkGetDataCount=1;
var firstTimePR=0;
var firstTimeCGD=0;
var x=0;
var processDoneArray=[];
var processDoneArrayCount=0;
var CheckArrayCount=0;
var audioRecording, videoRecording;
var recTimer;
var datebegin=0;

var speechRunnign = 0;
var isdown = 0;
var showspeech;


var dataKey;
var pendingUploads;
var sessionCount = 0;
var myVideoFrameCount;
var myAudioLength;
var myAudioSampleRate;
var myVideoFrameRateMultiplier;

var final_transcript;
var recognition;
var speechRecognitionIsOn = false;
var checkGetDataTimer;
var analysisProgressMessage;

// These vars are constant
var MAX_SLICE_SIZE = 1024 * 1024; // 1MB chunk sizes.
var MAX_ALLOWED_UPLOAD_ERRORS = 500;
// End constants

function initialize() {
  localVideo = document.getElementById('localVideo');
  startButton = document.getElementById('start_button');
  //document.getElementById('start_button').disabled=false;
  stopButton = document.getElementById("stop_button");
  showspeech = document.getElementById("textdiv");
  
  localVideo.addEventListener('loadedmetadata', function(){window.onresize();});
  if (!('webkitSpeechRecognition' in window)) {
      console.log("need to use chrome for speech recognition");
    } else {
      recognition = new webkitSpeechRecognition();
      recognition.continuous = true;
      recognition.interimResults = true;
      recognition.lang = "en-US";

      recognition.onstart = function() {
        console.log("started recognition");
        var delayLightbox = document.getElementById("delayLightbox");
        if (delayLightbox) {
            delayLightbox.addEventListener("webkitAnimationEnd",function() {
                console.log("animation ended");
                deleteDelayLightbox();
               // recTimer = setTimeout(function(){stopRecordingOnHangup()},120000);

                stopButton.disabled = false;
                stopButton.className = "btn btn-primary btn-lg";
            });
            delayLightbox.style.webkitAnimation = "fadeout 0.25s";
        }
      };
      recognition.onresult = function(event) {
        console.log("onresult",event);
      };
      recognition.onerror = function(event) {
        console.log("onerror",event);
        if (speechRecognitionIsOn){
            recognition.start();
            console.log("restart recognition after error");
        }
      };
      recognition.onend = function() {
        console.log("ended recognition");
        console.log("final_transcript",final_transcript);
		showspeech.textContent = final_transcript;
        if (speechRecognitionIsOn){
            recognition.start();
            console.log("restart recognition");
        }
      };
      recognition.onresult = function(event) {
        var interim_transcript = '';
        //console.log("speech recognition output: event.results",event.results);

        for (var i = event.resultIndex; i < event.results.length; ++i) {
          if (event.results[i].isFinal) {
            var currentWord = event.results[i][0].transcript;
            final_transcript += event.results[i][0].transcript;
          } else {
            interim_transcript += event.results[i][0].transcript;
          }
        }
        console.log("final_transcript",final_transcript,"interim_transcript",interim_transcript);
    };
  }

 doGetUserMedia();
}
function findkey(){
	console.log("Findkey");
	var keylabel = document.getElementById('keylabel');
	var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (this.readyState == 4) {
					if (this.status == 200) {
						console.log("key: "+this.responseText);
						keylabel.value = "Key = "+this.responseText;
					   
						// console.log(k[k.length -2]);
						// keylabel.value=k[k.length -2];
						// k=parseInt(k[k.length -2]);
						// k++;
					}
				}	
			}
	xhr.open('GET', "response.php?action=readkey", true);
	xhr.send();
}
function doGetUserMedia() {
    var infoMessage = document.createElement("h3");
    infoMessage.innerHTML = "";//'Get automated feedback on public speaking!<br/>Click "allow" on the pop-up to allow our site to access your microphone and camera.<br/>(Tip: Refresh the page if clicking "allow" doesn\'t do anything.)';
    infoMessage.style.textAlign = "center";
    infoMessage.style.position = "relative";
    infoMessage.style.color = "#ffffff";
    infoMessage.style.top = "30%";
    
    console.log(parseInt(infoMessage.offsetHeight));


    var delayLightbox = document.getElementById("delayLightbox");
    if (!delayLightbox) {
      makeLightbox(infoMessage,"delayLightbox");
    } else {
      insertLightbox(infoMessage,"delayLightbox");
    }
    
    delayLightbox = document.getElementById("delayLightbox");
    delayLightbox.style.width="100%";
    delayLightbox.style.height = "100%";
    delayLightbox.style.boxSizing = "border-box";
    delayLightbox.style.bottom = 0;
    delayLightbox.style.maxHeight = "100%";
    delayLightbox.style.background = "#3498DB";
    delayLightbox.style.webkitAnimation = "fadein 0.25s";

  var mediaConstraints = {"audio": true, "video": true};
  // Call into getUserMedia via the polyfill (adapter.js).
  try {
    getUserMedia(mediaConstraints, onUserMediaSuccess,
                 onUserMediaError);
    console.log('Requested access to local media with mediaConstraints:\n' +
                '  \'' + JSON.stringify(mediaConstraints) + '\'');
  } catch (e) {
    alert('getUserMedia() failed. Is this a WebRTC capable browser?');
    console.log('getUserMedia failed with exception: ' + e.message);
  }
}

function onUserMediaSuccess(stream) {
  console.log('User has granted access to local media.');
  // Call the polyfill wrapper to attach the media stream to this element.
  attachMediaStream(localVideo, stream);
  localVideo.style.opacity = 1;
  localStream = stream;
  
  var delayLightbox = document.getElementById("delayLightbox");
  if (delayLightbox) {
    delayLightbox.addEventListener("webkitAnimationEnd",function() {
        console.log("animation ended");
        deleteDelayLightbox();
        startButton.disabled = false;
        startButton.className = "btn btn-primary btn-lg";
    });
    delayLightbox.style.webkitAnimation = "fadeout 0.25s";
  }
}

function onUserMediaError(error) {
  console.log('Failed to get access to local media. Error code was ' +
              error.code);
  alert('Failed to get access to local media. Error code was ' +
        error.code + '.');
}

function enterFullScreen() {
  container.webkitRequestFullScreen();
}

// Set the video diplaying in the center of window.
window.onresize = function(){
  var aspectRatio;
  if (localVideo) {
      if (localVideo.style.opacity === '1') {
        aspectRatio = localVideo.videoWidth/localVideo.videoHeight;
      } else {
        return;
      }

      var navbarHeight = parseFloat(document.getElementsByClassName("navbar-fixed-top")[0].offsetHeight);
      //var statusBarHeight = parseFloat(document.getElementById("status").offsetHeight);
      //console.log("navbarHeight",navbarHeight,"statusBarHeight",statusBarHeight);
      var containerDiv = document.getElementById('videoContainer');
      var localVideoHeight = Math.min(window.innerHeight-navbarHeight,window.innerWidth/aspectRatio);
      localVideo.style.height = localVideoHeight + 'px';
      localVideo.style.width = Math.min(window.innerWidth,localVideoHeight*aspectRatio) + 'px';
      containerDiv.style.height = (window.innerHeight-navbarHeight) + 'px';
      containerDiv.style.marginTop = navbarHeight+"px";
      localVideo.style.marginTop = ((window.innerHeight-navbarHeight-localVideoHeight)/2) + "px";
  } else console.log("no local video yet for resize");
};

//=====================================================
var recording;
function startRecordingAfterActive() {
	
    pendingUploads = 0;
    sessionCount += 1;
    analysisProgressMessage = "";
    dataKey = baseDataKey+"_"+sessionCount;
    startButton.disabled = true;
    //startButton.value = "Now Recording...";
    startButton.className = "btn btn-default btn-lg";
	stopButton.disabled = false;
	stopButton.className = "btn btn-default btn-lg";
    // var infoMessage = document.createElement("h3");
    // infoMessage.innerHTML = 'Click "allow" on the pop-up to allow our site to access your microphone for speech recognition.';
    // infoMessage.style.textAlign = "center";
    // infoMessage.style.position = "relative";
    // infoMessage.style.color = "#ffffff";
    // infoMessage.style.top = "40%";
    
    // console.log(parseInt(infoMessage.offsetHeight));
    
    // var delayLightbox = document.getElementById("delayLightbox");
    // if (!delayLightbox) {
      // makeLightbox(infoMessage,"delayLightbox");
    // } else {
      // insertLightbox(infoMessage,"delayLightbox");
    // }
    
    // delayLightbox = document.getElementById("delayLightbox");
    // delayLightbox.style.width="100%";
    // delayLightbox.style.height = "100%";
    // delayLightbox.style.boxSizing = "border-box";
    // delayLightbox.style.bottom = 0;
    // delayLightbox.style.maxHeight = "100%";
    // delayLightbox.style.background = "#3498DB";
    // delayLightbox.style.animation = "fadein 0.25s";
    // delayLightbox.style.webkitAnimation = "fadein 0.25s";
    
    //recorder = new MRecordRTC();
    //recorder.addStream(localStream);
    //recorder.startRecording();
   // test();	    
    window.onbeforeunload =function(){
        return "Your audio and video is being saved. Please don't close this window so that this process will not be interrupted.";
    };
	console.log("split video record starting");
	splitCount=0;
	processRecordingCount=1;
	firstTimePR=0;
	firstTimeCGD=0;
	checkGetDataCount=1;
	recording=0;
	processDoneArrayCount=0;
	CheckArrayCount=0;
	keepGoing();
    splitRecord();
	if(datebegin==1)
		startDate();
	//setTimeout(processRecordingRealTime(),1000);
	//setTimeout(checkGetDataRealTime(),2000);
    //start speech recognition
    final_transcript = '';
	//speechRecognitionIsOn=false;
    speechRecognitionIsOn = true;
    //recognition.start();
}

function keydown(event){
	console.log("key value"+event.which);
	
	if(isdown == 0){
		isdown = 1;
		if(speechRunnign == 0){
			speechRunnign = 1;
			final_transcript = '';
			recognition.start();
			showspeech.textContent = "Speech Recognition is ON";
		}
		else{
			speechRunnign = 0;
			recognition.stop();
			console.log("Final transcript = "+final_transcript);
			showspeech.textContent = final_transcript;
			
		}
	}
}
function keyup(event){
	//console.log("key value"+event.which);
	
	isdown = 0;
}

function doPostAnalysis(){

}
function mergeVideos()
{
	//var cmd="copy /b"+" "+dataKey+"split1.wav";
	//cmd="copy /b "+cmd;
	var wavdone=0;
	var cmd= dataKey+"split1.wav";
	for(i=2;i<splitCount;i++)
	{
		cmd= cmd+"\+"+dataKey+"split"+i+".wav";
	}
	var cmdWebm= dataKey+"split1.webm";
	for(i=2;i<splitCount;i++)
	{
		cmdWebm= cmdWebm+"\+"+dataKey+"split"+i+".webm";
	}
	//cmd=cmd+" "+dataKey+"output.wav";
	//console.log(cmd);
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				console.log("response = "+this.responseText);
				wavdone+=1;
				if(wavdone==2){
					doPostAnalysis();
				}
				if(wavdone==1){
					xhr.open('GET', "response.php?action=mergeWebm&command="+cmdWebm+"&dataKey="+dataKey+"", true);
					xhr.send();
				}
			}
		}
	}
	xhr.open('GET', "response.php?action=mergeWav2&command="+cmd+"&dataKey="+dataKey+"", true);
	xhr.send();
	
	
}
function displayDataRealTime(displayValue)
{
	console.log("In displayDataRealTime  "+displayValue+" splitCount= "+splitCount);
	displayUpdatedemo(dataKey+"split"+displayValue+".txt");
}
function checkGetDataRealTime()
{
		checkGetDataRealTimer=setInterval(function(){
		//console.log("in.....................checkgetdatarealtime");
		if(checkGetDataCount>=splitCount-1 && stopButton.disabled==true)clearInterval(checkGetDataRealTimer);
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					//console.log("Check response text "+this.responseText);
					var responseToProceedcheck=dataKey+"split"+checkGetDataCount+"checkTrue";
					var responseNotToProceedcheck=dataKey+"split"+checkGetDataCount+"checkNotTrue";
					if(this.responseText==responseToProceedcheck){
						displayDataRealTime();
						if (checkGetDataCount<splitCount-1){
							//console.log("...............Done checking file = "+checkGetDataCount+" splitCount = "+splitCount);
							checkGetDataCount+=2;
							var Key=dataKey.toString()+"split"+checkGetDataCount+"";
							
							xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
							xhr.send();
						}
					}
					else if(this.responseText==responseNotToProceedcheck)
					{
						if(processRecordingCount-checkGetDataCount>2)checkGetDataCount=processRecordingCount;
						var Key=dataKey.toString()+"split"+checkGetDataCount+"";
						//console.log("........checking file......... "+Key);
						xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
						xhr.send();
					}
				} else {
				console.log("Failed while sending request to process data.");
				insertLightboxMessage('Please continue to wait as we analyze your data.');
				}
			}
		};

		if (firstTimeCGD==0 && splitCount>1){
			firstTimeCGD=1;
			var Key=dataKey.toString()+"split"+checkGetDataCount+"";
			//console.log("........checking file......... "+Key);
			xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
			xhr.send();
		}
	},50);
}
function checkGetDataRealTime2()
{
		checkGetDataRealTimer=setInterval(function(){
		//console.log("in.....................checkgetdatarealtime");
		if(checkGetDataCount>=splitCount && stopButton.disabled==true)clearInterval(checkGetDataRealTimer);
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("Check response text "+this.responseText);
					var responseToProceedcheck=dataKey+"split"+checkGetDataCount+"checkTrue";
					var responseNotToProceedcheck=dataKey+"split"+checkGetDataCount+"checkNotTrue";
					if(this.responseText==responseToProceedcheck){
						displayDataRealTime(checkGetDataCount);
						if (checkGetDataCount<=processDoneArray[processDoneArrayCount-1]){
							//console.log("...............Done checking file = "+checkGetDataCount+" splitCount = "+splitCount);
							checkGetDataCount=processDoneArray[CheckArrayCount];
							CheckArrayCount++;
							var Key=dataKey.toString()+"split"+checkGetDataCount+"";
							
							xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
							xhr.send();
						}
					}
					else if(this.responseText==responseNotToProceedcheck)
					{
						if(CheckArrayCount>processDoneArrayCount){
							CheckArrayCount=processDoneArrayCount;
						}
						if((processRecordingCount-checkGetDataCount>=2)||(CheckArrayCount<processDoneArrayCount-1)){
							checkGetDataCount=processDoneArray[CheckArrayCount];
							CheckArrayCount++;
						}
						//console.log("Checking file again"+ checkGetDataCount);
						var Key=dataKey.toString()+"split"+checkGetDataCount+"";
						console.log("........checking file......... "+Key+" CheckArrayCount "+CheckArrayCount+" processDoneArrayCount= "+processDoneArrayCount);
						xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
						xhr.send();
					}
				} else {
				console.log("Failed while sending request to process data.");
				insertLightboxMessage('Please continue to wait as we analyze your data.');
				}
			}
		};

		if (firstTimeCGD==0 && splitCount>1){
			firstTimeCGD=1;
			var Key=dataKey.toString()+"split"+checkGetDataCount+"";
			//console.log("........checking file......... "+Key);
			xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+Key+"&private="+isPrivateModeOn, true);
			xhr.send();
		}
	},100);
}

function processRecordingRealTime()
{
	processRecordingRealTimer=setInterval(function(){
		//console.log("in processRecordingRealTime, processRecordingCount="+processRecordingCount+" splitCount="+splitCount);
		if(processRecordingCount ==(splitCount-1))
		{
			//console.log("just for check");
			clearInterval(processRecordingRealTimer);
		}
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					//console.log("ran analysis for: "+this.responseText);
					var responseToProceed=dataKey+"split"+processRecordingCount+"ProcessingTrue";
					var responseNotToProceed=dataKey+"split"+processRecordingCount+"ProcessingNotTrue";
					//console.log("Options are "+responseToProceed+" or "+responseNotToProceed);
					if(this.responseText==responseToProceed){
						if(firstTimeCGD==0)checkGetDataRealTime();
						
					//	console.log("Just checking processRecordingCount="+processRecordingCount+" splitCount="+splitCount);
						if (processRecordingCount<splitCount-1){
							processRecordingCount+=2;
							var Key=dataKey.toString()+"split"+processRecordingCount+"";
							//console.log("................................processeing file "+Key);
							xhr.open('GET', "response.php?action=process&dataKey="+Key, true);
							xhr.send();
						}
					}
					else if(this.responseText==responseNotToProceed)
					{
						var Key=dataKey.toString()+"split"+processRecordingCount+"";
						console.log("Again............................processeing file "+Key);
						xhr.open('GET', "response.php?action=process&dataKey="+Key, true);
						xhr.send();
					}
				} else {
				//console.log("Failed while sending request to process data.");
				insertLightboxMessage('Please continue to wait as we analyze your data.');
				}
			} else {
			//console.log("processRecording()","readyState",this.readyState,"status",this.status);
			}
		};

		if (firstTimePR==0 && splitCount>1){
			firstTimePR=1;
			var Key=dataKey.toString()+"split"+processRecordingCount+"";
			//console.log("................................processeing file "+Key);
			xhr.open('GET', "response.php?action=process&dataKey="+Key, true);
			xhr.send();
		}
	},100);
}

function processRecordingRealTime2()
{
	processRecordingRealTimer=setInterval(function(){
		//console.log("in processRecordingRealTime, processRecordingCount="+processRecordingCount+" splitCount="+splitCount);
		if(processRecordingCount >=(splitCount-1) && stopButton.disabled==true)
		{
			//console.log("just for check");
			clearInterval(processRecordingRealTimer);
		}
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("ran analysis for: "+this.responseText);
					var responseToProceed="ProcessingTrue";
					var responseNotToProceed="ProcessingNotTrue";
					//console.log("Options are "+responseToProceed+" or "+responseNotToProceed);
					if(this.responseText!=responseNotToProceed){
						if(firstTimeCGD==0)checkGetDataRealTime2();
						//console.log("Process responseText= "+this.responseText);
						processDoneArray[processDoneArrayCount]=parseInt(this.responseText,10) + processRecordingCount;
						processDoneArrayCount++;
					//	console.log("Just checking processRecordingCount="+processRecordingCount+" splitCount="+splitCount);
						if (processRecordingCount<splitCount){
							var nextvid=parseInt(this.responseText,10) + processRecordingCount;
							processRecordingCount=nextvid+1;
							var Key1=dataKey.toString()+"split"+processRecordingCount+"";
							var Key2=dataKey.toString()+"split"+(processRecordingCount+1)+"";
							var Key3=dataKey.toString()+"split"+(processRecordingCount+2)+"";
							var Key4=dataKey.toString()+"split"+(processRecordingCount+3)+"";
							console.log("................................processeing file "+Key1);
							xhr.open('GET', "response.php?action=process2&dataKey1="+Key1+"&dataKey2="+Key2+"&dataKey3="+Key3+"&dataKey4="+Key4, true);
							xhr.send();
						}
					}
					else if(this.responseText==responseNotToProceed)
					{
						var Key1=dataKey.toString()+"split"+processRecordingCount+"";
						var Key2=dataKey.toString()+"split"+(processRecordingCount+1)+"";
						var Key3=dataKey.toString()+"split"+(processRecordingCount+2)+"";
						var Key4=dataKey.toString()+"split"+(processRecordingCount+3)+"";
						//if(processRecordingCount <=(splitCount-1) ){
							console.log("Again................................processeing file "+Key1);
							xhr.open('GET', "response.php?action=process2&dataKey1="+Key1+"&dataKey2="+Key2+"&dataKey3="+Key3+"&dataKey4="+Key4, true);
							xhr.send();
						//}
					}
				} else {
				//console.log("Failed while sending request to process data.");
				insertLightboxMessage('Please continue to wait as we analyze your data.');
				}
			} else {
			//console.log("processRecording()","readyState",this.readyState,"status",this.status);
			}
		};

		if (firstTimePR==0 && splitCount>1){
			firstTimePR=1;
			var Key1=dataKey.toString()+"split"+processRecordingCount+"";
			var Key2=dataKey.toString()+"split"+(processRecordingCount+1)+"";
			var Key3=dataKey.toString()+"split"+(processRecordingCount+2)+"";
			var Key4=dataKey.toString()+"split"+(processRecordingCount+3)+"";
			//console.log("................................processeing file "+Key1);
			xhr.open('GET', "response.php?action=process2&dataKey1="+Key1+"&dataKey2="+Key2+"&dataKey3="+Key3+"&dataKey4="+Key4, true);
			xhr.send();
		}
	},100);
}
function splitRecord(){
/////////small video
//while(1)

     splitTimer=setInterval(function(){
			//console.log("splitCount..........."+splitCount+" recording="+recording);
            if(recording==1){
                    //stop 
                    //recording=0;
					
                    splitRecorder.stopRecording(function(blobURL, type){
                        if (type=="audio") {
                            splitAudioRecording = new MyRecording(blobURL, type);
                        } else if (type=="video") {
                            splitVideoRecording = new MyRecording(blobURL,type);
                        }
                    });
					recording=0;
                    var blobs = splitRecorder.getBlob();

                    splitAudioRecording.blob = blobs.audio;
                    splitVideoRecording.blob = blobs.video;

                    splitAudioRecording.filename = dataKey+"split"+splitCount+".wav";
                    splitVideoRecording.filename = dataKey+"split"+splitCount+".webm";
					
					//splitAudioRecording.filename = dataKey+".wav";
                    //splitVideoRecording.filename = dataKey+".webm";

                    //console.log("From Split............video blob size:"+splitAudioRecording.blob.size);
                   // console.log("From Split............audio blob size:"+splitVideoRecording.blob.size);
					
                    if (splitAudioRecording.blob.size > 0 && splitVideoRecording.blob.size > 0) {
                      //console.log("You are able to record audio and video!"+dataKey+" "+splitCount);
                    }
					
                    splitRecorder = null;
					if(firstTimePR==0)processRecordingRealTime2();
                    
                    pendingUploads += 2;
                    splitVideoRecording.startUploading2();
                    splitAudioRecording.startUploading2();
					recording=0;
					//console.log("1.here recording="+recording);
                    
            }
            if(recording==0){
                    //start 
					//console.log("2.here recording="+recording);
                    splitRecorder=new MRecordRTC();
                    splitRecorder.addStream(localStream);
                    splitRecorder.startRecording();
                    recording=1;
                    splitCount++;
            }
    }, 1000);

}


function stopRecordingOnHangup() {
    clearTimeout(recTimer);
	clearInterval(splitTimer);
	//splitRecorder.stopRecording();
	splitRecorder=null;
    startButton.value = "Start";
    stopButton.disabled = true;
    stopButton.className = "btn btn-default btn-lg";
	startButton.disabled = false;
	startButton.value = "Start ";
	startButton.className = "btn btn-primary btn-lg";
	mergeVideos();
	/*
    var lightbox = document.getElementById("myLightbox");

    var infoMessage = document.createElement("p");
    infoMessage.innerHTML = '<b style="color:red;">Please DO NOT  close the window while the uploads are still going.</b>  Uploads may take a long time for those with slow internet connections.<br/>Sending video and audio to server for processing...';
    
    if (!lightbox) {
      makeLightbox(infoMessage,"myLightbox");
    }
	*/
	speechRecognitionIsOn = false;
   /* setTimeout(function() {
        recorder.stopRecording(function(blobURL, type){
            if (type=="audio") {
                audioRecording = new MyRecording(blobURL, type);
            } else if (type=="video") {
                videoRecording = new MyRecording(blobURL,type);
            }
        });
        speechRecognitionIsOn = false;
        recognition.stop();
        
        setTimeout(function() {
            var blobs = recorder.getBlob();

            audioRecording.blob = blobs.audio;
            videoRecording.blob = blobs.video;
            
            audioRecording.filename = dataKey+".wav";
            videoRecording.filename = dataKey+".webm";

            console.log("video blob size:"+videoRecording.blob.size);
            console.log("audio blob size:"+audioRecording.blob.size);

            if (videoRecording.blob.size > 0 && audioRecording.blob.size > 0) {
              console.log("You are able to record audio and video!");
            }
        
            recorder = null;
            pendingUploads = 2;
            var startTime = new Date();
            console.log("hi there");
            videoRecording.startUploading();
            audioRecording.startUploading();
            var endTime = new Date();
            // time difference in ms
            var timeDiff = endTime - startTime;
            console.log("Time for uploading "+ timeDiff);
        
       
        }, 3000);
    }, 1000);
	*/
    
}
//=====================================================
function MyRecording(blobURL, type){
    this.blobURL = blobURL;
    this.type = type;
    this.uploadFilePartsCount = 0;
    this.lastFileSlice = 0; 
    this.fileUploadErrors = 0;
}

MyRecording.prototype.toURL = function() {
    return this.blobURL;
};

MyRecording.prototype.startUploading2= function(){
	this.uploadFileToServer2(this.blob.slice(0,this.blob.size,this.blob.type));
	/*
     if (this.blob.size > MAX_SLICE_SIZE) {
      this.uploadFileToServer(this.blob.slice(0,MAX_SLICE_SIZE,this.blob.type));
    } else {
      this.uploadFileToServer(this.blob.slice(0,this.blob.size,this.blob.type));
    }
	*/
};
MyRecording.prototype.uploadFileToServer2= function(blob_slice){
  var formData = new FormData();
  formData.append('blob', blob_slice, this.filename);
    
    
  var request = new XMLHttpRequest();
  request.onreadystatechange = function () {
    if (this.readyState == 4) {
      if (this.status == 200) {
        //recorder.uploadFileToServerCallback(this.responseText);
		//console.log("Done Uploading PendingUploads = "+ pendingUploads);
		pendingUploads-=1;
      } else {
        console.log("Error message: "+this.responseText);
        recorder.uploadFileToServerErrorCallback();
      }
    } else {
      //console.log("uploadFileToServer2()","readyState",this.readyState,"status",this.status);
    }
  };

  request.open('POST', "response.php?action=upload");
  request.send(formData);
}
MyRecording.prototype.startUploading = function() {
    var fileProgressBar, filePercentageCalc, fileProgress;
    
    filePercentageCalc = document.getElementById(this.type+"-percentageCalc");
    if (filePercentageCalc) {
        console.log("need to delete");
        fileProgress = filePercentageCalc.parentNode;
        fileProgress.parentNode.removeChild(fileProgress);
    }

    fileProgressBar= document.createElement("progress");
    fileProgressBar.id = this.type+"-progressBar";
    fileProgressBar.max = this.blob.size ;
    fileProgressBar.value = 0;

    filePercentageCalc = document.createElement("p");
    filePercentageCalc.innerHTML = "0% of "+this.type+" uploaded";
    filePercentageCalc.id = this.type+"-percentageCalc";
    
    fileProgress = document.createElement("div");
    fileProgress.appendChild(fileProgressBar);
    fileProgress.appendChild(filePercentageCalc);

    var lightbox = document.getElementById("myLightbox");

    insertLightbox(fileProgress,"myLightbox");

    if (this.blob.size > MAX_SLICE_SIZE) {
      this.uploadFileToServer(this.blob.slice(0,MAX_SLICE_SIZE,this.blob.type));
    } else {
      this.uploadFileToServer(this.blob.slice(0,this.blob.size,this.blob.type));
    }
}

MyRecording.prototype.uploadFileToServer = function(blob_slice) {
  console.log("lastFileSlice: "+this.lastFileSlice);

  var formData = new FormData();
  formData.append('blob', blob_slice, this.filename);
    
    
  var request = new XMLHttpRequest();
  var progressBar, percentageCalc;

  progressBar = document.getElementById(this.type+"-progressBar");
  percentageCalc = document.getElementById(this.type+"-percentageCalc");
    
  var recorder = this;
/*
  request.upload.addEventListener("progress", function(evt) {
    if (evt.lengthComputable) {
      progressBar.value = evt.loaded+recorder.lastFileSlice;
      percentageCalc.innerHTML = Math.min(Math.round(100*(evt.loaded+recorder.lastFileSlice) / recorder.blob.size),100) + "% of "+recorder.type+" uploaded";
      percentageCalc.title = percentageCalc.innerHTML;
    }
  }, false);
*/
  request.onreadystatechange = function () {
    if (this.readyState == 4) {
      if (this.status == 200) {
        recorder.uploadFileToServerCallback(this.responseText);
      } else {
        console.log("Error message: "+this.responseText);
        recorder.uploadFileToServerErrorCallback();
      }
    } else {
      console.log("uploadFileToServer()","readyState",this.readyState,"status",this.status);
    }
  };

  request.open('POST', "response.php?action=upload");
  request.send(formData);
  
  console.log("this.uploadFilePartsCount",this.uploadFilePartsCount);

  this.uploadFilePartsCount += 1;
  this.lastFileSlice += blob_slice.size;
}

MyRecording.prototype.uploadFileToServerCallback = function(message) {
  this.fileUploadErrors = 0;

  console.log(this.uploadFilePartsCount+" upload result: "+message);

  if (this.blob.size - this.lastFileSlice > MAX_SLICE_SIZE) {
    this.uploadFileToServer(this.blob.slice(this.lastFileSlice,this.lastFileSlice+MAX_SLICE_SIZE,"video/webm"));
  } else if (this.blob.size - this.lastFileSlice <= MAX_SLICE_SIZE && this.blob.size - this.lastFileSlice > 0) {
    this.uploadFileToServer(this.blob.slice(this.lastFileSlice,this.blob.size));
  } else {
    pendingUploads -= 1;
    if (pendingUploads <= 0) {
        if ( final_transcript.trim().length > 0) {
            sendTranscript();
        } else {
            console.log("cannot send transcript since it is blank");
            //processRecording();
        }
    }
  }
}

MyRecording.prototype.uploadFileToServerErrorCallback = function() {
  console.log(this.type+" upload error! number: "+this.fileUploadErrors);

  if (this.lastFileSlice > 0 && this.fileUploadErrors < MAX_ALLOWED_UPLOAD_ERRORS) {
    console.log("try to upload again");
    this.uploadFilePartsCount -= 1;
    if (this.lastFileSlice%MAX_SLICE_SIZE > 0) {
      this.lastFileSlice -= this.lastFileSlice%MAX_SLICE_SIZE;
      this.uploadFileToServer(this.blob.slice(this.lastFileSlice,this.blob.size));
    } else {
      this.lastFileSlice -= MAX_SLICE_SIZE;
      this.uploadFileToServer(this.blob.slice(this.lastFileSlice,this.lastFileSlice+MAX_SLICE_SIZE));
    }
    this.fileUploadErrors += 1;
  } else {
    console.log("Too many errors or invalid "+this.type+" slice number: "+this.lastFileSlice);
  }
}

function sendTranscript() {
    //send transcript to server
    insertLightboxMessage("Sending transcript from speech recognition to server...");
    var formData = new FormData();
    console.log("will send transcript to server:",final_transcript);
    formData.append('transcript', final_transcript);
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (this.readyState == 4) {
          if (this.status == 200) {
            console.log("successful sendTranscript()",this.responseText);
          } else {
            console.log("sendTranscript() Error message: "+this.responseText);
          }
          setTimeout(checkGetAlignment(),3000);
        } else {
          console.log("sendTranscript()","readyState",this.readyState,"status",this.status);
        }
    };
    request.open('POST', "response.php?action=uploadtranscript&dataKey="+dataKey);
    request.send(formData);
}

// check if the forced alignment result files exist
function checkGetAlignment() {
  if (analysisProgressMessage != "Checking if forced alignment of transcript to audio is done...") {
    insertLightboxMessage("Checking if forced alignment of transcript to audio is done...");
    analysisProgressMessage = "Checking if forced alignment of transcript to audio is done...";
  }
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
	    console.log("finished checking "+dataKey+" alignment: "+this.responseText);
        if (this.responseText=="true") {
            formatTranscript();
        }
		else setTimeout(checkGetAlignment(),3000);
      } else {
        console.log("could not check for "+dataKey+" data");  
        setTimeout(checkGetAlignment(),3000);
      }
    } else {
      console.log("checkGetAlignment()","readyState",this.readyState,"status",this.status);
    }
  };
  xhr.open('GET', "response.php?action=checkgetalignment&dataKey="+dataKey, true);
  xhr.send();
}

function formatTranscript() {
    insertLightboxMessage("Formatting transcript...");
    //send transcript to server
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (this.readyState == 4) {
          if (this.status == 200) {
            console.log("formatTranscript() success:",this.responseText);
            //setTimeout(processRecording(),3000);
			processRecording();
          } else {
            console.log("formatTranscript() Error message: ",this.responseText);
          }
        } else {
          console.log("formatTranscript()","readyState",this.readyState,"status",this.status);
        }
    };
    console.log("formatTranscript() dataKey",dataKey);
    request.open('GET', "response.php?action=formatforcealign&dataKey="+dataKey, true);
    request.send();
}

// use ffmpeg to convert the files, then run the analysis algorithms

var count=0;
function processRecording() {
	count++;
	console.log("......count  of processecording()..."+count+"split count "+splitCount);
  console.log("processRecording()",myVideoFrameCount);//mfung
  insertLightboxMessage("Running analysis on audio and video files...");
  var lightbox;
  videoProgress = document.getElementById("video-progressBar");
  audioProgress = document.getElementById("audio-progressBar");
  /*
  if (videoProgress) {
	  videoProgress.parentNode.removeChild(videoProgress);
	  audioProgress.parentNode.removeChild(audioProgress);
	  insertLightboxMessage('All uploads complete!<br/>Now analyzing data...');
  }
  */
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
        console.log("ran analysis for: "+this.responseText);
      } else {
        console.log("Failed while sending request to process data.");
        insertLightboxMessage('Please continue to wait as we analyze your data.');
      }
      //checkGetDataTimer = setTimeout(checkGetData(),3000);
    } else {
      console.log("processRecording()","readyState",this.readyState,"status",this.status);
    }
  };
  
  if (x<splitCount)x++;
  var Key=dataKey.toString()+"split"+x+"";
  console.log("................................processeing file "+Key);
  xhr.open('GET', "response.php?action=process&dataKey="+Key, true);
  xhr.send();
  checkGetDataTimer = setTimeout(checkGetData(),3000);
}

// check if the data files exist
function checkGetData() {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
	    console.log("finished checking "+dataKey+" data: "+this.responseText);
        if (this.responseText=="true") {
            clearTimeout(checkGetDataTimer);
            //setTimeout(formatRecording(),1000);
            setTimeout(function() {
                displayAnalysisCompletionMessage();
                var startButton = document.getElementById("start_button");
				
                startButton.disabled = false;
                startButton.value = "Start Recording";
                startButton.className = "btn btn-primary btn-lg";
                window.onbeforeunload =function(){};
            },1000);
        } else {
            if (this.responseText != analysisProgressMessage) {
                analysisProgressMessage = this.responseText;
                //insertLightboxMessage(analysisProgressMessage);
            }
            checkGetDataTimer = setTimeout(checkGetData(),3000);
        }
      } else {
        console.log("could not check for "+dataKey+" data");  
        checkGetDataTimer = setTimeout(checkGetData(),3000);
      }
    } else {
      //console.log("checkGetData()","readyState",this.readyState,"status",this.status);
    }
  };
  xhr.open('GET', "response.php?action=checkformatteddata&dataKey="+dataKey+"&private="+isPrivateModeOn, true);
  xhr.send();
}

function displayAnalysisCompletionMessage() {
  audioRecording = null;
  videoRecording = null;
  var lightbox = document.getElementById('myLightbox');
  
  if (isPrivateModeOn) insertLightboxMessage('<b style="color:red;">Processing and analysis done! You can view your <a href="turkfeedback.php?dataKey='+dataKey+'" target="_blank">feedback here</a>.</b> Since private mode is on, your data has been deleted from the server, and your feedback will be unavailable once you leave this site.');

  else {
      insertLightboxMessage('<b style="color:red;">Processing and analysis done! Please first view your <a href="turkfeedback.php?dataKey='+dataKey+'" target="_blank">feedback here. </a>. </b> Save the record ID below to refer back to this session:');

      dataKeyText = document.createElement("input");
      dataKeyText.className = "form-control";
      dataKeyText.type = "text";
      dataKeyText.readonly = true;
      dataKeyText.value = dataKey;
      dataKeyText.title = dataKey;
      dataKeyText.id = "dataKeyText";
      dataKeyText.onfocus = function() {this.select();};
      dataKeyText.onmouseup = function(e) {e.preventDefault();};

      lightbox.appendChild(dataKeyText );
  }
  var close = document.getElementById("lightboxClose");
  if (!close) {
    close = document.createElement('span');
    close.className = 'closebutton';
    close.innerHTML = "&times;";
    close.onclick = deleteLightbox;
    close.id = "lightboxClose";

    lightbox.insertBefore(close,lightbox.firstChild);
  }
}

//=====================================================
function makeLightbox(item,lightboxId) {
  var lightbox = document.createElement('div');
  lightbox.id = lightboxId;
  lightbox.appendChild(item);
  document.body.appendChild(lightbox);
}

function insertLightboxMessage(message) {
  lightbox = document.getElementById('myLightbox');
  messageElem = document.createElement('p');
  messageElem.innerHTML = message;
  lightbox.appendChild(messageElem);
}

function insertLightbox(item,lightboxId) {
  var lightbox = document.getElementById(lightboxId);
  lightbox.appendChild(item);
}

function deleteLightbox() {
  var lightbox = document.getElementById("myLightbox");
  if (lightbox!=null) {
    lightbox.parentNode.removeChild(lightbox);
  }
}
function deleteDelayLightbox() {
  var lightbox = document.getElementById("delayLightbox");
  if (lightbox!=null) {
    lightbox.parentNode.removeChild(lightbox);
  }
}
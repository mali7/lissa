var startButton, stopButton;
var localVideo;
var localStream;
var xmlhttp;
var isVideoMuted = false;
var isAudioMuted = false;

var recorder;
var audioRecording, videoRecording;
var recTimer;

//var videoTimesMillisecs = [];

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
var MAX_ALLOWED_UPLOAD_ERRORS = 50;
// End constants

function initialize() {
  localVideo = document.getElementById('localVideo');
  startButton = document.getElementById("start_button");
  stopButton = document.getElementById("stop_button");
  //localVideo.addEventListener('loadedmetadata', function(){window.onresize();});
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
                recTimer = setTimeout(function(){stopRecordingOnHangup()},120000);

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

function doGetUserMedia() {
    var infoMessage = document.createElement("h3");
    infoMessage.innerHTML = 'Get automated feedback on public speaking!<br/>Click "allow" on the pop-up to access your microphone and camera.<br>You <i>must</i> be using the Google Chrome browser.<br>(Tip: Refresh the page if clicking "allow" doesn\'t do anything.)';
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
    delayLightbox.style.background = "#5FA292";
    delayLightbox.style.webkitAnimation = "fadein 0.25s";
    delayLightbox.style.position = "fixed";

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
/*
// Set the video diplaying in the center of window.
window.onresize = function(){
  var aspectRatio;
  if (localVideo) {
      if (localVideo.style.opacity === '1') {
        aspectRatio = localVideo.videoWidth/localVideo.videoHeight;
      } else {
        return;
      }

      var navbarHeight = parseFloat(document.getElementsByClassName("navbar-static-top")[0].offsetHeight);
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
*/
//=====================================================

function startRecordingAfterActive() {
    pendingUploads = 0;
    sessionCount += 1;
    analysisProgressMessage = "";
    dataKey = baseDataKey+"_"+sessionCount;
    //document.getElementById("dataKeyText").innerHTML = "<br>Your Session ID:<br>" + dataKey;
    document.getElementById("dataKeyText").innerHTML = "<br>Your Session ID:<br><a target=\"_blank\" href=\""+currentFeedbackPage+".php?dataKey="+dataKey+"\" >" + dataKey + "</a>";
    startButton.disabled = true;
    startButton.value = "Now Recording...";
    startButton.className = "btn btn-default btn-lg";

    $("#start_button").hide();
    $("#stop_button").show();

    var infoMessage = document.createElement("h3");
    infoMessage.innerHTML = 'Click "allow" on the pop-up to allow our site to access your microphone for speech recognition.';
    infoMessage.style.textAlign = "center";
    infoMessage.style.position = "relative";
    infoMessage.style.color = "#ffffff";
    infoMessage.style.top = "40%";
    
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
    delayLightbox.style.background = "rgb(95, 162, 146)";
    delayLightbox.style.animation = "fadein 0.25s";
    delayLightbox.style.webkitAnimation = "fadein 0.25s";
    
    recorder = new MRecordRTC();
    recorder.addStream(localStream);
    recorder.startRecording();
    window.onbeforeunload =function(){
        return "Your audio and video is being saved. Please don't close this window so that this process will not be interrupted.";
    };
        //start speech recognition
    final_transcript = '';
    speechRecognitionIsOn = true;
    recognition.start();
}

var uploadPercent = 0;
var finished = false;
function setProgressBar(percent) {
    $("#progressbar").attr("aria-valuenow", percent);
    $("#progressbar").attr("style", "width: " + percent + "%;");
    $("#progressbar").html(percent + "%");
}

function getProgressPercent() {
    return parseInt($("#progressbar").html());
}

function progressing() {
    var curPercent = getProgressPercent();
    if (!finished && curPercent < 83) {
        setProgressBar(curPercent + 1);
        //setTimeout(progressing, 1000);
        setTimeout(progressing, 2000);
    }
    else if (!finished && curPercent >= 83) {
        //setTimeout(progressing, 1000);
        setTimeout(progressing, 2000);
    }
    else if (finished && curPercent < 100) {
        setProgressBar(curPercent + 5);
        setTimeout(progressing, 100);
    }
    else if (finished && curPercent >= 100) {
        $("#progresstext").html("Complete <br> Your Session ID:<br>"+dataKey);

        $("#progressbarDiv").animate({width: '0%', marginLeft: '50%', marginRight: '50%'}, 600, function() {
          $("#progressbarDiv").hide();
          //$("#viewfbDiv").fadeIn(600);
          //$("#viewfeedback").removeAttr("disabled");
        });

        setTimeout(function(){
          window.location.href=currentFeedbackPage+".php?dataKey="+dataKey;
        },1500);

    }
}

function stopRecordingOnHangup() {
    clearTimeout(recTimer);
    startButton.value = "Start Recording";
    stopButton.disabled = true;
    stopButton.className = "btn btn-default btn-lg";
    var lightbox = document.getElementById("myLightbox");

    var infoMessage = document.createElement("p");
    infoMessage.innerHTML = '<b style="color:red;">Please DO NOT  close the window while the uploads are still going.</b>  Uploads may take a long time for those with slow internet connections.<br/>Sending video and audio to server for processing...';
    
    

    $("#localVideo").hide();
    $("#resultDiv").show();
    $("#status").hide();

    /*
    document.getElementById('tips1').style.display="block";
    document.getElementById('tips1').style.opacity="1";
    */
    
    var tips = $(".tips");
    var tipsnum = tips.length;
    tips.eq(0).show();
    var nextTipsID = 1;
    var preTipsID = 0;

    setInterval(function() {
      tips.eq(preTipsID).fadeOut(1000);
      setTimeout(function(){
        tips.eq(nextTipsID).fadeIn(1000);
        preTipsID = nextTipsID;
        nextTipsID = (nextTipsID + 1) % tipsnum;
      },1100);
    }, 8000);
    
    if (!lightbox) {
      makeLightbox(infoMessage,"myLightbox");
    }
    
    document.getElementById("myLightbox").style.display = "none";

    setTimeout(function() {
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
            $("#progresstext").html("Uploading data...");
            progressing();
            videoRecording.startUploading();         
            audioRecording.startUploading();
        }, 3000);
    }, 1000);
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

  request.upload.addEventListener("progress", function(evt) {
    if (evt.lengthComputable) {
      progressBar.value = evt.loaded+recorder.lastFileSlice;
      percentageCalc.innerHTML = Math.min(Math.round(100*(evt.loaded+recorder.lastFileSlice) / recorder.blob.size),100) + "% of "+recorder.type+" uploaded";
      percentageCalc.title = percentageCalc.innerHTML;
    }
  }, false);

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

  request.open('POST', "responseToast.php?action=upload");
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
		
		console.log("I am done Uploading");
        if ( final_transcript.trim().length > 0) {
		    //if (videoTimesMillisecs.length > 0) {
            sendTranscriptAndVideoTimes();
        } else {
            console.log("cannot send transcript or video times since it is blank");
            setTimeout(processRecording(),2000);
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

function sendTranscriptAndVideoTimes() {
    //send transcript to server
    //insertLightboxMessage("Sending transcript from speech recognition to server...");
    var formData = new FormData();
	final_transcript = final_transcript.trim();
	if ( final_transcript.length > 0) {
		console.log("will send transcript to server:",final_transcript);
		formData.append('transcript', final_transcript);
	}
	//console.log("will send video times to server: frames ",videoTimesMillisecs.length);
	//formData.append('videoTimesMillisecs', videoTimesMillisecs.toString());
	
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (this.readyState == 4) {
          if (this.status == 200) {
            console.log("successful sendTranscriptAndVideoTimes()",this.responseText);
          } else {
            console.log("sendTranscriptAndVideoTimes() Error message: "+this.responseText);
          }
          setTimeout(checkGetTranscriptVideoMillis(),3000);
        } else {
          console.log("sendTranscriptAndVideoTimes()","readyState",this.readyState,"status",this.status);
        }
    };
    request.open('POST', "response.php?action=uploadtranscriptandvideotimes&dataKey="+dataKey);
    request.send(formData);
}

// check if the transcript file exists
function checkGetTranscriptVideoMillis() {
  /*
  if (analysisProgressMessage != "Checking if transcript is uploaded...") {
    insertLightboxMessage("Checking if transcript is uploaded...");
    analysisProgressMessage = "Checking if transcript is uploaded...";
  }
  */
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
	    console.log("finished checking "+dataKey+" transcript: "+this.responseText);
        if (this.responseText=="true") {
            processRecording();
        }
		else setTimeout(checkGetTranscriptVideoMillis(),3000);
      } else {
        console.log("could not check for "+dataKey+" data");  
        setTimeout(checkGetTranscriptVideoMillis(),3000);
      }
    } else {
      console.log("checkGetTranscriptVideoMillis()","readyState",this.readyState,"status",this.status);
    }
  };
  xhr.open('GET', "response.php?action=checkgettranscriptvideomillis&dataKey="+dataKey, true);
  xhr.send();
}
/*
function createHITfromUploadsPage() {
  var passwd = prompt("Password : ");

  if(passwd == "rochci") {
    $("#uploadsCreateHIT").remove();
    $.ajax({
      type: "POST",
      url: "turkcalls.php",
      data: { action: "createHIT",
          datakey: dataKey },
      cache: false,
      success: function(result){
        HITId = result;
      }
    });
  }
}
*/
// use ffmpeg to convert the files, then run the analysis algorithms
function processRecording23() {
  console.log("processRecording()",myVideoFrameCount);//mfung
  insertLightboxMessage("Running analysis on audio and video files...");
  var lightbox;
  videoProgress = document.getElementById("video-progressBar");
  audioProgress = document.getElementById("audio-progressBar");
  if (videoProgress) {
	  videoProgress.parentNode.removeChild(videoProgress);
	  audioProgress.parentNode.removeChild(audioProgress);
	  insertLightboxMessage('All uploads complete!<br/>Now analyzing data...');
    $("#progresstext").html("Analyzing data...");
    //$("#banner").append("<button class='amChartsButtonSelected btn btn-info btn-sm' id='uploadsCreateHIT' style='width:300px;' onclick=createHITfromUploadsPage()>Get Personal Feedback From Others</button>");
  }
  
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
  xhr.open('GET', "responseToast.php?action=process&dataKey="+dataKey, true);
  xhr.send();
  checkGetDataTimer = setTimeout(checkGetData(),3000);
}

// check if the data files exist
function checkGetData() {
  var xhr = new XMLHttpRequest();
  console.log("inside checkGetData = "+this.responseText);
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
                if (startButton) {
                  startButton.disabled = false;
                  startButton.value = "Start Recording";
                  startButton.className = "btn btn-primary btn-lg";
                }
                window.onbeforeunload =function(){};
            },1000);
        } else {
            if (this.responseText != analysisProgressMessage) {
                analysisProgressMessage = this.responseText;
                insertLightboxMessage(analysisProgressMessage);
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
  console.log("I am being called");
  xhr.open('GET', "responseToast.php?action=checkformatteddata&dataKey="+dataKey+"&private="+isPrivateModeOn, true);
  xhr.send();
}



function displayAnalysisCompletionMessage() {
  audioRecording = null;
  videoRecording = null;
  var lightbox = document.getElementById('myLightbox');
  
  if (isPrivateModeOn) insertLightboxMessage('<b style="color:red;">Processing and analysis done! You can view your <a href="'+currentFeedbackPage+'.php?dataKey='+dataKey+'" target="_blank">feedback here</a>.</b> Since private mode is on, your data has been deleted from the server, and your feedback will be unavailable once you leave this site.');

  else {
      insertLightboxMessage('<b style="color:red;">Processing and analysis done! Please first view your <a href="'+currentFeedbackPage+'.php?dataKey='+dataKey+'" target="_blank">feedback here. </a>. </b> Save the record ID below to refer back to this session:');

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
  finished = true;
  //console.log("fin...");
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
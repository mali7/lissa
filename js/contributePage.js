var startButton, stopButton;
var localVideo;
var localStream;
var xmlhttp;
var isVideoMuted = false;
var isAudioMuted = false;

var recorder;
var audioRecording, videoRecording;
var recTimer;

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
  localVideo.addEventListener('loadedmetadata', function(){window.onresize();});
  if (!('webkitSpeechRecognition' in window)) {
      console.log("need to use chrome for speech recognition");
    } else {
      recognition = new webkitSpeechRecognition();
      console.log(recognition);
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

        for (var i = event.resultIndex; i < event.results.length; ++i) {
          if (event.results[i].isFinal) {
            var currentWord = event.results[i][0].transcript;
            final_transcript += event.results[i][0].transcript;
            /*
            if (parseInt(currentWord)>0) {
                console.log("currentWord is numeric",currentWord);
            } else {
                console.log("currentWord not numeric",currentWord);
            }
            */
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
    infoMessage.innerHTML = 'Get a video recording of yourself!<br/>To begin click "allow" on the pop-up to allow our site to access your microphone and camera.<br/>(Tip: Refresh the page if clicking "allow" doesn\'t do anything.)';
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

function startRecordingAfterActive() {
    pendingUploads = 0;
    sessionCount += 1;
    analysisProgressMessage = "";
    dataKey = baseDataKey+"_"+sessionCount;
    startButton.disabled = true;
    startButton.value = "Now Recording...";
    startButton.className = "btn btn-default btn-lg";
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
    delayLightbox.style.background = "#3498DB";
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

function stopRecordingOnHangup() {
    clearTimeout(recTimer);
    startButton.value = "Start Recording";
    stopButton.disabled = true;
    stopButton.className = "btn btn-default btn-lg";
    var lightbox = document.getElementById("myLightbox");

    var infoMessage = document.createElement("p");
    infoMessage.innerHTML = '<b style="color:red;">Please DO NOT  close the window while the uploads are still going.</b>  Uploads may take a long time for those with slow internet connections.<br/>Uploading video and audio to server...';
    
    if (!lightbox) {
      makeLightbox(infoMessage,"myLightbox");
    }
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

  request.open('POST', "contributeResponse.php?action=upload");
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
            processRecording();
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
          setTimeout(processRecording(),3000);
        } else {
          console.log("sendTranscript()","readyState",this.readyState,"status",this.status);
        }
    };
    request.open('POST', "contributeResponse.php?action=uploadtranscript&dataKey="+dataKey);
    request.send(formData);
}

// use ffmpeg to convert the files, then run the analysis algorithms
function processRecording() {
  console.log("processRecording()",myVideoFrameCount);//mfung
  var lightbox;
  videoProgress = document.getElementById("video-progressBar");
  audioProgress = document.getElementById("audio-progressBar");
  if (videoProgress) {
	  videoProgress.parentNode.removeChild(videoProgress);
	  audioProgress.parentNode.removeChild(audioProgress);
      insertLightboxMessage('All uploads complete!<br/>Now converting videos...');
  }
  
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
        console.log("ran analysis for: "+this.responseText);
      } else {
        console.log("Failed while sending request to process data.");
        insertLightboxMessage('Please continue to wait as we process your video.');
      }
      checkGetDataTimer = setTimeout(checkGetData(),3000);
    } else {
      console.log("processRecording()","readyState",this.readyState,"status",this.status);
    }
  };
  xhr.open('GET', "contributeResponse.php?action=process&dataKey="+dataKey, true);
  xhr.send();
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
            setTimeout(displayAnalysisCompletionMessage(),1000);
        }
		else checkGetDataTimer = setTimeout(checkGetData(),3000);
      } else {
        console.log("could not check for "+dataKey+" data");  
        checkGetDataTimer = setTimeout(checkGetData(),3000);
      }
    } else {
      //console.log("checkGetData()","readyState",this.readyState,"status",this.status);
    }
  };
  xhr.open('GET', "contributeResponse.php?action=checkgetdata&dataKey="+dataKey, true);
  xhr.send();
}

function displayAnalysisCompletionMessage() {
  audioRecording = null;
  videoRecording = null;

  insertLightboxMessage('<b style="color:red;">Video processing done! Please first view your <a href="video.php?dataKey='+dataKey+'" target="_blank">video here</a>. Then, answer the <a href="https://docs.google.com/forms/d/17k-aCXkYm2rkC0mhVdgfqRbawA7p9DUC0bi96QGXw_Q/viewform" target="_blank">questionnaire here</a> based on what you learned from watching your video.</b> Save the record ID below to refer back to this session:');

  var lightbox = document.getElementById('myLightbox');
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
  
  var close = document.getElementById("lightboxClose");
  if (!close) {
    close = document.createElement('span');
    close.className = 'closebutton';
    close.innerHTML = "&times;";
    close.onclick = deleteLightbox;
    close.id = "lightboxClose";

    lightbox.insertBefore(close,lightbox.firstChild);
  }
  
  startButton.disabled = false;
  startButton.value = "Start Recording";
  startButton.className = "btn btn-primary btn-lg";
  window.onbeforeunload =function(){};
}

//=====================================================
function makeLightbox(item,lightboxId) {
  var lightbox = document.createElement('div');
  lightbox.id = lightboxId;
  lightbox.appendChild(item);
  document.body.appendChild(lightbox);
  //console.log(lightboxId);
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
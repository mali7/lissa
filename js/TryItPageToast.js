// Vars not used for this MP4 video conversion app, so set their values.
final_transcript = "";
isPrivateModeOn = false;
//=====================================================
// Get upload form element.
var fileUploadForm = document.forms["fileUploadForm"];

// Update input file name display after selecting a file.
fileUploadForm.uploadBtn.onchange = function () {
  if (this.files.length < 0) {
    fileUploadForm.submit.disabled = true;
    fileUploadForm.submit.className = "btn btn-default";
    fileUploadForm.uploadFile.value = "";
    return false;
  }
  if (this.files[0].type != "video/mp4") {
    fileUploadForm.submit.disabled = true;
    fileUploadForm.submit.className = "btn btn-default";
    fileUploadForm.uploadFile.value = "";
	fileUploadForm.insertBefore(alertWarning("You must upload an MP4 file."), fileUploadForm.firstChild);
	return false;
  }
  fileUploadForm.uploadFile.value = this.files[0].name;
  fileUploadForm.submit.disabled = false;
  fileUploadForm.submit.className = "btn btn-primary";
};

function alertWarning(msg) {
  var alertDiv = document.createElement("div");
  alertDiv.className = "alert alert-warning fade in";  
  alertDiv.innerHTML = '<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>Warning!</strong> '+msg;
  alertDiv.style.position = "absolute";
  alertDiv.style.left = "10px";
  alertDiv.style.right = "10px";
  alertDiv.style.top = ($("#navbar-collapse-01").height() + 10) + "px";
  
  setTimeout(function() {
    $(alertDiv).fadeOut(500, function() {
      alertDiv.remove();
	});
  }, 2500);
  
  return alertDiv;
}
//=====================================================

function mp4onsubmit() {
  console.log("mp4onsubmit");
  
  // Disable additional uploads while uploads are in progress.
  fileUploadForm.submit.disabled = true;
  fileUploadForm.submit.className = "btn btn-default";
  fileUploadForm.uploadBtn.disabled = true;
  $("#uploadBtnDiv").addClass("disabled btn-default");
  $("#uploadBtnDiv").removeClass("btn-primary");
  
  // Get file upload element in form.
  var mp4files = fileUploadForm.uploadBtn.files;  
  
  if (mp4files.length == 0) {
	fileUploadForm.insertBefore(alertWarning("No file selected. Please select a file to upload!"), fileUploadForm.firstChild);
	return false;
  }
  console.log("mp4file0: ",mp4files[0]);
  if (mp4files[0].type != "video/mp4") {
	fileUploadForm.insertBefore(alertWarning("You must upload an MP4 file."), fileUploadForm.firstChild);
	return false;
  }
  
  if (mp4files[0].size == 0) {
    fileUploadForm.insertBefore(alertWarning("Your file size must be greater than zero."), fileUploadForm.firstChild);
	return false;
  }
  
  sessionCount += 1;
  // Get file name without extension, and with all spaces replaced with pluses.
  dataKey = mp4files[0].name.replace(/\s+/g, '_').split(".").shift() + "_" + baseDataKey + "_" + sessionCount;
  console.log("dataKey: ", dataKey);
  
  var infoMessage = document.createElement("p");
  infoMessage.innerHTML = '<b style="color:red;">Please DO NOT  close the window while the uploads are still going.</b>  Uploads may take a long time for those with slow internet connections.<br/>Sending video to server for processing...';
  
  var lightbox = document.getElementById("myLightbox");
  if (!lightbox) {
    makeLightbox(infoMessage,"myLightbox");
  }
  
  // Create MyRecording object. We don't use the blobURL value here.
  videoRecording = new MyRecording("blobURL","video"); 
  videoRecording.filename = dataKey+".mp4";
  
  videoRecording.blob = mp4files[0].slice();

  console.log("video blob size:",videoRecording.blob.size);

  analysisProgressMessage = "";
  pendingUploads = 1;
  videoRecording.startUploading();
}
//=====================================================

function processToast(){
	var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
	console.log("In process Recording "+this.responseText);
  };
  console.log("Starting processing with datakey = "+dataKey)
  xhr.open('GET', "responseToast.php?action=process&extension=mp4&dataKey="+dataKey, true);
  xhr.send();
  checkGetDataTimer = setTimeout(checkGetData(),3000);
	
}
function processRecording() {
  //console.log("processRecording()",myVideoFrameCount);//mfung
  insertLightboxMessage("Running analysis on file...");
  videoProgress = document.getElementById("video-progressBar");
  
  if (videoProgress) {
	  videoProgress.parentNode.removeChild(videoProgress);
  }
  
  insertLightboxMessage('All uploads complete!<br/>Now analyzing data; the results will appear at this link when the analysis is done: <a href="'+currentFeedbackPage+'.php?dataKey='+dataKey+'" target="_blank">feedback here</a>. </b> You can use the record ID below to refer back to this video:');
	  
  dataKeyText = document.createElement("input");
  dataKeyText.className = "form-control";
  dataKeyText.type = "text";
  dataKeyText.readonly = true;
  dataKeyText.value = dataKey;
  dataKeyText.title = dataKey;
  dataKeyText.id = "dataKeyText";
  dataKeyText.onfocus = function() {this.select();};
  dataKeyText.onmouseup = function(e) {e.preventDefault();};
  var lightbox = document.getElementById('myLightbox');
  lightbox.appendChild(dataKeyText );
  
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
	console.log("In process Recording "+this.responseText);
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
  console.log("Starting processing with datakey = "+dataKey)
  xhr.open('GET', "responseToast.php?action=process&extension=mp4&dataKey="+dataKey, true);
  xhr.send();
  checkGetDataTimer = setTimeout(checkGetData(),3000);
}

function displayAnalysisCompletionMessage() {
  videoRecording = null;
  var lightbox = document.getElementById('myLightbox');
  
  insertLightboxMessage('<b style="color:red;">Processing and analysis done! Please first view your <a href="'+currentFeedbackPage+'.php?dataKey='+dataKey+'" target="_blank">feedback here</a>. </b> Save the record ID below to refer back to this video:');

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
  
  fileUploadForm.uploadBtn.disabled = false;
  $("#uploadBtnDiv").removeClass("disabled btn-default");
  $("#uploadBtnDiv").addClass("btn-primary");
}
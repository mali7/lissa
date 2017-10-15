<?php 
session_start();
//====================================================
// Uploading a recorded video or audio file to server
//----------------------------------------------------
if ($_GET['action'] == 'upload') {
  if (!is_dir("uploads/")) mkdir("uploads/");
  if (!is_dir("data/")) mkdir("data/");
  if (isset($_FILES["blob"])) {
    $tempName = $_FILES["blob"]["tmp_name"];
    $destination = "uploads/".$_FILES["blob"]["name"];
    file_put_contents($destination, file_get_contents($tempName,'r'),FILE_APPEND);
  }
}
//====================================================
// Upload the transcript
//----------------------------------------------------
else if ($_GET['action'] == 'uploadtranscriptandvideotimes') {
  $transcript = $_POST['transcript'];
  //$videoTimesMillisecs = $_POST['videoTimesMillisecs'];
  $dataKey = $_GET['dataKey'];
  
  echo "original transcript: ".$transcript."<br><br>";
  if (strlen($transcript) > 0) {
	$transcriptFilename = "data/transcript-google-$dataKey.txt";
    $transcriptFile = fopen($transcriptFilename,"w");
    fwrite($transcriptFile, $transcript);
    fclose($transcriptFile);
  }
  /*
  //echo "videoTimesMillisecs: ".$videoTimesMillisecs."<br><br>";
  $videoMillisFilename = "data/video-times-millis-$dataKey.txt";
  $videoMillisFile = fopen($videoMillisFilename,"w");
  fwrite($videoMillisFile, $videoTimesMillisecs);
  fclose($videoMillisFile);
  */
}
//====================================================
// Checking if transcript alignment files exist
//----------------------------------------------------
else if ($_GET['action'] == 'checkgettranscriptvideomillis') {
  $dataKey = $_GET["dataKey"];
  $transcriptFilename = "data/transcript-google-$dataKey.txt";
  if (file_exists($transcriptFilename)) echo "true";
  //$videoMillisFilename = "data/video-times-millis-$dataKey.txt";
  //if (file_exists($videoMillisFilename)) echo "true";
  else echo "false";
}
//====================================================
// Processing the files
//----------------------------------------------------
else if ($_GET['action'] == 'process') {
  $dataKey = $_GET["dataKey"];
  $extension = $_GET["extension"];
  echo $dataKey;
  
  $audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/";
  $exeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
  $exeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_mar/AVProcessor/bin/Release/";
  //$output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$dataKey.mp4 2>&1");
  $output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$dataKey.wav $audioVideoDir$dataKey.webm 2>&1");
  /*
  if ($extension == "mp4") {
    $output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$dataKey.mp4 2>&1");
  } else {
    $output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$dataKey.wav $audioVideoDir$dataKey.webm 2>&1");
  }
	*/
  echo "\n<br>cd $exeDir & AVProcessor.exe $audioVideoDir$dataKey.wav $audioVideoDir$dataKey.webm 2>&1<br>\n";
  var_dump($output);
}
//====================================================
// Checking if formatted data files exist
//----------------------------------------------------
else if ($_GET['action'] == 'checkformatteddata') {
  $dataKey = $_GET["dataKey"];
  $averageFeaturesFile = "C:/inetpub/wwwroot/RocSpeakRafayet/data/average-features-$dataKey.js";
  $audioVideoFeaturesFile = "data/audio-video-features-$dataKey.js";
  $audioAlignmentFile = "data/formatted-alignment-$dataKey.js";
  $wordProsodyFile = "data/word-prosody-$dataKey.txt";
  $transcriptGoogleFile = "data/transcript-google-$dataKey.txt";
  $transcriptNuanceFile = "data/transcript-nuance-$dataKey.txt";
  $formattedTranscriptFile = "data/formatted-transcript-$dataKey.txt";
  //$videoMillisFile = "data/video-times-millis-$dataKey.txt";
  $voicedAudioIntervalFeatureFile = "data/voiced-audio-interval-features-$dataKey.js";
  if (file_exists($audioVideoFeaturesFile)) {
    echo "true";
    
  } else {
    $analysisProgressFile = "D:/analysis-progress-$dataKey.txt";
    if (file_exists($analysisProgressFile)) echo file_get_contents($analysisProgressFile);
    else echo "Continuing to process data...";
  }
}
?>
<?php 
//====================================================
// Uploading a recorded video or audio file to server
//----------------------------------------------------
if ($_GET['action'] == 'upload') {
  if (!is_dir("uploads/")) mkdir("uploads/");
  if (isset($_FILES["blob"])) {
    $tempName = $_FILES["blob"]["tmp_name"];
    $destination = "uploads/".$_FILES["blob"]["name"];
    file_put_contents($destination, file_get_contents($tempName,'r'),FILE_APPEND);
  }
}
//====================================================
// Processing the files
//----------------------------------------------------
else if ($_GET['action'] == 'process') {
  $dataKey = $_GET["dataKey"];
  echo $dataKey;
  $audioVideoDir = "C:/inetpub/wwwroot/RocSpeak/uploads/";
  
  $output = shell_exec("cd C:/inetpub/wwwroot/Release_standalone/ & ffmpeg -y -i $audioVideoDir$dataKey.wav -i $audioVideoDir$dataKey.webm $audioVideoDir$dataKey-merge.webm 2>&1");
  //var_dump($output);
}
//====================================================
// Checking if raw data files exist
//----------------------------------------------------
else if ($_GET['action'] == 'checkgetdata') {
  $dataKey = $_GET["dataKey"];
  if (file_exists("C:/inetpub/wwwroot/RocSpeak/uploads/$dataKey-merge.webm")) echo "true";
  else echo "false";
}
//====================================================
// Upload the transcript
//----------------------------------------------------
else if ($_GET['action'] == 'uploadtranscript') {
  $transcript = $_POST['transcript'];
  $dataKey = $_GET['dataKey'];
  
  echo "original transcript".$transcript;
  
  $transcriptFilename = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/transcript-$dataKey.txt";
  $transcriptFile= fopen($transcriptFilename,"w");
  fwrite($transcriptFile, $transcript);
  fclose($transcriptFile);
}
?>
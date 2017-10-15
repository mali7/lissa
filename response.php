<?php 
session_start();
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
  $audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/";  
  $audioExeDir = "C:/inetpub/wwwroot/Release_standalone/Audio/";
  $AudioFile = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey.webm"; 
  $VideoFile = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey.wav"; 
  if (file_exists($AudioFile) and file_exists($VideoFile)) {
    echo "ProcessingTrue";
	}
  else echo "ProcessingNotTrue";
  $output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey.wav $audioVideoDir$dataKey.webm 2>&1");
  //var_dump($output);
}

else if ($_GET['action'] == 'process2') {
  $dataKey1 = $_GET["dataKey1"];
  $dataKey2 = $_GET["dataKey2"];
  $dataKey3 = $_GET["dataKey3"];
  $dataKey4 = $_GET["dataKey4"];
  //echo $dataKey;
  $audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/";  
  $audioExeDir = "C:/inetpub/wwwroot/Release_standalone/Audio/";
  $AudioFile1 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey1.webm"; 
  $VideoFile1 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey1.wav"; 
  $AudioFile2 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey2.webm"; 
  $VideoFile2 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey2.wav"; 
  $AudioFile3 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey3.webm"; 
  $VideoFile3 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey3.wav"; 
  $AudioFile4 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey4.webm"; 
  $VideoFile4 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey4.wav"; 
	
	if (file_exists($AudioFile4) and file_exists($VideoFile4)) {
		echo "3";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey4.wav $audioVideoDir$dataKey4.webm 2>&1");
 
	}
	else if (file_exists($AudioFile3) and file_exists($VideoFile3)) {
		echo "2";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey3.wav $audioVideoDir$dataKey3.webm 2>&1");
 
	}
	else if (file_exists($AudioFile2) and file_exists($VideoFile2)) {
		echo "1";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey2.wav $audioVideoDir$dataKey2.webm 2>&1");
 
	}
	else if (file_exists($AudioFile1) and file_exists($VideoFile1)) {
		echo "0";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey1.wav $audioVideoDir$dataKey1.webm 2>&1");
	}
	
	else echo "ProcessingNotTrue";
  //$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey.wav $audioVideoDir$dataKey.webm 2>&1");
  //var_dump($output);
}
//====================================================
// LISSA Processing real time
//----------------------------------------------------


else if ($_GET['action'] == 'process2lissa') {
	
  $dataKey1 = $_GET["dataKey1"];
  $dataKey2 = $_GET["dataKey2"];
  $dataKey3 = $_GET["dataKey3"];
  $dataKey4 = $_GET["dataKey4"];
  //echo $dataKey;
  $audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/";  
  $audioExeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
  $exeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
  $AudioFile1 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey1.webm"; 
  $VideoFile1 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey1.wav"; 
  $AudioFile2 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey2.webm"; 
  $VideoFile2 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey2.wav"; 
  $AudioFile3 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey3.webm"; 
  $VideoFile3 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey3.wav"; 
  $AudioFile4 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey4.webm"; 
  $VideoFile4 = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey4.wav"; 
	
	if (file_exists($AudioFile4) and file_exists($VideoFile4)) {
		echo "3";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey4.wav $audioVideoDir$dataKey4.webm 2>&1");
		//$output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$vid.mp4 2>&1");
	}
	else if (file_exists($AudioFile3) and file_exists($VideoFile3)) {
		echo "2";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey3.wav $audioVideoDir$dataKey3.webm 2>&1");
 
	}
	else if (file_exists($AudioFile2) and file_exists($VideoFile2)) {
		echo "1";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey2.wav $audioVideoDir$dataKey2.webm 2>&1");
 
	}
	else if (file_exists($AudioFile1) and file_exists($VideoFile1)) {
		echo "0";
		$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey1.wav $audioVideoDir$dataKey1.webm 2>&1");
	}
	
	else echo "ProcessingNotTrue";
}
//====================================================
// Wiz of Oz
//====================================================
else if ($_GET ['action']=='savenote'){
	date_default_timezone_set('America/New_York');
	$t = date('Y-m-d h:i:s');
	$value = $_GET["value"];
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/note".$keyNumber.".txt";
	$myfile= fopen ($fileName,"a");
	fwrite($myfile,$t.": ".$value."\n");
	fclose($myfile);
}
else if ($_GET ['action']=='savespeech'){
	$value = $_GET["value"];
	$keyNumber=$_GET["keyNumber"];
	$fileName = "speech".$keyNumber.".txt";
	$myfile= fopen ($fileName,"w");
	fwrite($myfile,$value);
	fclose($myfile);
	$fileName = "speech1".$keyNumber.".txt";
	$myfile= fopen ($fileName,"w");
	fwrite($myfile,$value);
	fclose($myfile);
}
else if ($_GET ['action']=='savefeedback'){
	$value = $_GET["value"];
	$keyNumber=$_GET["keyNumber"];
	$fileName = "seniorFeedback".$keyNumber.".txt";
	$myfile= fopen ($fileName,"w");
	fwrite($myfile,$value);
	fclose($myfile);
}
else if($_GET['action']=='readicon'){
	$keyNumber = $_GET["keyNumber"];
	$logfileName="C:/inetpub/wwwroot/RocSpeakRafayet/Logs/log".$keyNumber.".txt";
	$logfile=fopen($logfileName,'a');
	$logfileName="C:/inetpub/wwwroot/RocSpeakRafayet/Logs/log1".$keyNumber.".txt";
	$logfile1=fopen($logfileName,'a');
	$timecount=$_GET['time'];
	$returnvalue="";
	//$keyNumber=""; //for automated version 
	$fileName = "wizozeye".$keyNumber.".txt";
	if(file_exists($fileName)){
		$returnvalue=$returnvalue."1";
		fwrite($logfile,$timecount." :eye\n");
	}
	else $returnvalue=$returnvalue."0";
	$fileName = "wizozsmile".$keyNumber.".txt";
	if(file_exists($fileName)){
		$returnvalue=$returnvalue."1";
		fwrite($logfile,$timecount." :smile\n");
	}
	else $returnvalue=$returnvalue."0";
	$fileName = "wizozvolume".$keyNumber.".txt";
	if(file_exists($fileName)){
		$returnvalue=$returnvalue."1";
		fwrite($logfile,$timecount." :volume\n");
	}
	else $returnvalue=$returnvalue."0";
	$fileName = "wizozbody".$keyNumber.".txt";
	if(file_exists($fileName)){
		$returnvalue=$returnvalue."1";
		fwrite($logfile,$timecount." :body\n");
	}
	else $returnvalue=$returnvalue."0";
	fwrite($logfile1,":".$returnvalue."\n");
	echo $returnvalue;
}
else if($_GET['action']=='dellog'){
	$keyNumber = $_GET["keyNumber"];
	unlink("C:/inetpub/wwwroot/RocSpeakRafayet/Logs/log".$keyNumber.".txt");
	unlink("C:/inetpub/wwwroot/RocSpeakRafayet/Logs/log1".$keyNumber.".txt");
}

else if($_GET['action']=='readkey'){
	
	$keyfile=fopen("keys.txt",'r');
	$val= fread($keyfile,filesize("keys.txt"));
	echo $val;
	fclose($keyfile);
	$val = intval($val);
	$val = $val +1;
	$keyfile=fopen("keys.txt",'w');
	fwrite($keyfile , $val);
}
else if($_GET['action']=='writekey'){
	$value = $_GET['value'];
	$keyfile=fopen("keys.txt",'a');
	fwrite ($keyfile , "\n".$value);
}
else if($_GET['action']=='iconcontrol'){
	$button=$_GET['button'];
	$value=$_GET['value'];
	$keyNumber=$_GET["keyNumber"];
	if($button=='eye'){
		$fileName = "wizozeye".$keyNumber.".txt";
		if($value=='show'){
			$myfileEYE= fopen ($fileName,"w");
			fwrite($myfileEYE,'1');
			fclose($myfileEYE);
		}
		else{
			unlink($fileName);
		}
	}
	else if($button=='smile'){
		$fileName = "wizozsmile".$keyNumber.".txt";
		if($value=='show'){
			$myfileSMILE= fopen ($fileName,"w");
			fwrite($myfileSMILE,'1');
			fclose($myfileSMILE);
		}
		else{
			unlink($fileName);
		}
	}
	if($button=='volume'){
		$fileName = "wizozvolume".$keyNumber.".txt";
		if($value=='show'){
			$myfileVOLUME= fopen ($fileName,"w");
			fwrite($myfileVOLUME,'1');
			fclose($myfileVOLUME);
		}
		else{
			unlink($fileName);
		}
	}
	if($button=='body'){
		$fileName = "wizozbody".$keyNumber.".txt";
		if($value=='show'){
			$myfileBODY= fopen ($fileName,"w");
			fwrite($myfileBODY,'1');
			fclose($myfileBODY);
		}
		else{
			unlink($fileName);
		}
	}
}

else if ($_GET['action']=='readnote'){
	$myfilepath="note.txt";
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/note".$keyNumber.".txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
	}
}
else if ($_GET['action']=='readspeech'){
	$myfilepath="speech.txt";
	$keyNumber=$_GET["keyNumber"];
	$fileName = "speech".$keyNumber.".txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
		unlink($fileName);
	}
}
else if($_GET['action']=='dateon'){
	date_default_timezone_set('America/New_York');
	$t = date('Y-m-d h:i:s');
	$user = $_GET["user"];
	$day = $_GET["day"];
	$keyNumber=$_GET["keyNumber"];
	$line1 = "(setq *user-id* \"".$user."\")\n";
	$line2 = "(setq *session-number* \"".$day."\")";
	// $fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/sessionInfo.lisp";
	// if(file_exists($fileName)){
		// unlink($fileName);
	// }
	$filetostart=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/sessionInfo.lisp","w");
	$onfile=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/Logs/on".$keyNumber.".txt",'a');
	fwrite ( $onfile, $t);
	fwrite($filetostart,$line1 );
	fwrite($filetostart,$line2 );
	fclose($onfile);
	
}
else if($_GET['action']=='isdateon'){
	$keyNumber=$_GET["keyNumber"];
	$fileName="C:\inetpub\wwwroot\RocSpeakRafayet\Logs\on".$keyNumber.".txt";
	echo $filename;
	if(file_exists($fileName)){
		echo "Yes";
	}
	else{
		echo $keyNumber." Not found";
	}
	fclose($fileName);
}
else if($_GET['action']=='saveTime'){
	$keyNumber=$_GET["keyNumber"];
	date_default_timezone_set('America/New_York');
	$t = localtime(time('Y-m-d h:i:s'),true);
	$t = date('Y-m-d h:i:s');
	$onfile=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/Logs/startTime".$keyNumber.".txt",'a');
	fwrite ( $onfile,  $t."\n");
	fclose($onfile);
}


//====================================================
// post feedback
//---------------------------------------------------

else if ($_GET['action']=='streakandCount'){
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/post".$keyNumber.".txt";
	$streaks = $_GET['streaks'];
	$popcounts = $_GET['popcounts'];
	$responseCount = $_GET['responseCount'];
	
	$filetowrite = fopen ($fileName, "w");
	fwrite($filetowrite,$streaks." ".$popcounts." ".$responseCount);
	fclose($filetowrite);
}

else if ($_GET['action']=='readpost'){
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/post".$keyNumber.".txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
	}
}
else if ($_GET['action']=='readpostbackup'){
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/postbackup".$keyNumber.".txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
	}
}

else if ($_GET['action']=='savebackup'){
	$keyNumber=$_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/Logs/postbackup".$keyNumber.".txt";
	$postvalues = $_GET['postvalues'];
	$filetowrite = fopen ($fileName, "w");
	fwrite($filetowrite,$postvalues);
	fclose($filetowrite);
}

//====================================================
//Process dating videos
//----------------------------------------------------

else if ($_GET['action']=='processvideo'){
	$vid = $_GET["vid"];
	$audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/Aligned/";
	$audioExeDir = "C:/inetpub/wwwroot/Release_standalone/Audio/";
	$exeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
	$output = shell_exec("cd $exeDir & AVProcessor.exe $audioVideoDir$vid.mp4 2>&1");
	echo $output;
	echo "done";
}
else if ($_GET['action']=='processvideo2'){
	$vid = $_GET["vid"];
	$lengthcount = $_GET["lengthcount"];
	$name= "$vid-wmv-$lengthcount";
	$audioVideoDir = "C:/inetpub/wwwroot/RocSpeakRafayet/Aligned/";
	$audioExeDir = "C:/inetpub/wwwroot/Release_standalone/Audio/";
	//rename("$audioVideoDir$vid.wmv-$lengthcount.wmv", "$audioVideoDir$vid-wmv-$lengthcount.wmv");
	$exeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
	$output = shell_exec("cd $audioExeDir & AVProcessor.exe $audioVideoDir$name.wmv $audioVideoDir$name.wmv 2>&1");
	echo $output;
	echo "$audioVideoDir$vid-wmv-$lengthcount.wmv";
}
else if ($_GET['action']=='checkprocessvideo'){
	$name = $_GET["name"];
	$fileName  = "data/average-features-$name.txt"; 
	$fileName2 = "data/audio-video-features-$name.js";
	if(file_exists($fileName) or file_exists($fileName2)){
		echo "done";
	}
}
//=====================================================
//save new labels for videos
//-----------------------------------------------------

else if($_GET['action']=='savelabel'){
	$keyNumber=$_GET["keyNumber"];
	$type = $_GET["type"];
	$smilelabel = $_GET["smilelabel"];
	$eyelabel = $_GET["eyelabel"];
	$volumelabel = $_GET["volumelabel"];
	$bodylabel = $_GET["bodylabel"];
	$RAid = $_GET["RAid"];
	$num = 0;
	date_default_timezone_set('America/New_York');
	$t = localtime(time('Y-m-d h:i:s A'),true);
	$t = date('Y-m-d h:i:s A');
	$start = "-start-";
	
	if($type == '2'){
		$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/RALabels/eye".$keyNumber."-$RAid.txt",'a');
		fwrite ( $file,  $start."\n");
		fwrite ( $file,  $t."\n");
		fwrite ( $file,  $eyelabel."\n");
		fclose($file);	
		$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/RALabels/volume".$keyNumber."-$RAid.txt",'a');
		fwrite ( $file,  $start."\n");
		fwrite ( $file,  $t."\n");
		fwrite ( $file,  $volumelabel."\n");
		fclose($file);
		echo "ok";
	}
	else{
		$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/RALabels/smile".$keyNumber."-$RAid.txt",'a');
		fwrite ( $file,  $start."\n");
		fwrite ( $file,  $t."\n");
		fwrite ( $file,  $smilelabel."\n");
		fclose($file);	
		$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/RALabels/body".$keyNumber."-$RAid.txt",'a');
		fwrite ( $file,  $start."\n");
		fwrite ( $file,  $t."\n");
		fwrite ( $file,  $bodylabel."\n");
		fclose($file);
		echo "ok";
	}
	
}
//====================================================
//Test Lisp
//----------------------------------------------------

else if ($_GET['action']=='submitInstruction'){
	$instruction=$_GET["value"];
	echo "hello";
	$instruction = str_replace("*", " ",$instruction);
	//echo $instruction;
	$lispdir = "C:\Program Files (x86)\clisp-2.49";
	$lispexe = "clisp l.lsp";
	$instruction = "(+ 1 1)";
	//$out1 = proc_open("cd $lispdir & $lispexe 2>&1");
	//$out = shell_exec("$out1 10 2>&1");
	//$out = shell_exec("$out1 13 2>&1");
	//fwrite($out1, "10");
	//echo $out1;
	// $output = implode("\n", "cd $lispdir & $lispexe  l.lsp  2>&1");
	// foreach ($output as $line){
		// echo $line;
	// }
	//$out=shell_exec("$command 2>&1");
	//echo $out;
	$descriptorspec = array(
	   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
	   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
	   2 => array("file", "/tmp/error-output.txt", "a") // stderr is a file to write to
	);

	$cwd = '/tmp';
	$env = array('some_option' => 'aeiou');

	$process = proc_open("cd $lispdir & lispexe", $descriptorspec, $pipes, $cwd, $env);

	if (is_resource($process)) {
		// $pipes now looks like this:
		// 0 => writeable handle connected to child stdin
		// 1 => readable handle connected to child stdout
		// Any error output will be appended to /tmp/error-output.txt

		fwrite($pipes[0], '<?php print_r($_ENV); ?>');
		fclose($pipes[0]);

		echo stream_get_contents($pipes[1]);
		fclose($pipes[1]);

		// It is important that you close any pipes before calling
		// proc_close in order to avoid a deadlock
		$return_value = proc_close($process);

		echo "command returned $return_value\n";
	}
	else{
		echo "nothing ".$process;
	}
}
//============================================================
//       lisp speech save
//------------------------------------------------------------

else if($_GET['action']=='speechsavelisp'){
	$value = $_GET["value"];
	$keyNumber = $_GET["keyNumber"];
	$dataKey = $_GET["dataKey"];
	$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/input.lisp",'a');
	$file1=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/inputlisp.txt",'a');
	$file2=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/lispDialogue$keyNumber.txt",'a');
	$file3=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/seniorParticipantSpeech/lispDialogue$dataKey.txt",'a');
	fwrite ( $file1,  $value."\n");
	fwrite ( $file2,  "Subject: ".$value."\n");
	fwrite ( $file3,  $value."\n");
	fwrite ( $file,  "(defparameter *next-input* \"".$value."\")"."\n");
	
	fclose($file1);
	fclose($file2);
	fclose($file3);
	fclose($file);
	echo $value.$dataKey;
}
else if($_GET['action']=='saveDialogueLisp'){
	$value = $_GET["value"];
	$file=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/lispDialogue.txt",'a');
	fwrite ( $file,  "LISSA: ".$value."\n");
	fclose($file);
	echo $value;
}
//==============================================================
//       lisp read speech
//--------------------------------------------------------------

else if($_GET['action']=='readspeechLisp'){
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/output.txt";
	$lockfileName = "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/lock";
	if(!file_exists($lockfileName)){
		$lock = fopen("C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/lock", 'x');
		fwrite($lock, "1");
		fclose($lock);
		if(file_exists($fileName) and is_readable($fileName)){
			$filetoread = fopen ($fileName, "r");
			echo fread($filetoread,filesize($fileName));
			fclose($filetoread);
		}
		else{
			echo "File unavailable";
		}
		unlink($lockfileName);
	}
	else{
		echo "File Locked";
	}
}
//====================================================
//LISSA Senior Transcript save
//====================================================

else if($_GET['action']=='speechsavesenior'){
	$value = $_GET["value"];
	$keyNumber = $_GET["keyNumber"];
	$file2=fopen("C:/inetpub/wwwroot/RocSpeakRafayet/senior/SeniorDialogue$keyNumber.txt",'a');

	fwrite ( $file2, $value."\n");
	
	fclose($file2);

	echo $value;
}
//====================================================
//LISSA Senior Feedback
//----------------------------------------------------
else if ($_GET['action']=='seniorProcess'){
	// $fileName = $_GET["dataReadyFileNames"];
	$keyNumber = $_GET["keyNumber"];
	$dataKey = $_GET["dataKey"];
	// $range = $_GET["range"];
	// $session = $_GET["session"];
	$command = "java proc $fileName";
	// for($i=0;$i<1000;$i++){
		// $out=shell_exec("cd C:/inetpub/wwwroot/RocSpeakRafayet/ & java procSenior $dataKey $range $keyNumber $session  2>&1");
		// echo $out;
		// echo "cd C:/inetpub/wwwroot/RocSpeakRafayet/ & java procSenior $dataKey $range $keyNumber $session  2>&1";
		// if (strlen($out)>3){
			// break;
		// }
	// }
	
	//////new way with python//////
	

	$dataKey = $_GET["dataKey"];
	$user =  $_GET["user"];
	$out = shell_exec("cd C:/inetpub/wwwroot/RocSpeakRafayet/ & python predictLabelsSenior.py $dataKey $user 2>&1");
	echo $out;
}
//====================================================
//Aging check if Feedback done
//----------------------------------------------------

else if ($_GET['action']=='findDoneFeedback'){
	$user =  $_GET["user"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/Done$user.txt";
		sleep(1);
		if(file_exists($fileName)){
			$filetoread = fopen ($fileName, "r");
			echo fread($filetoread,filesize($fileName));
			fclose($filetoread);
			
		}
		else{
			echo "No";
		}
	
}
//====================================================
//Aging check if upload done
//----------------------------------------------------

else if ($_GET['action']=='findUploadDone'){
	$user =  $_GET["user"];
	$dataKey = $_GET["dataKey"];
	
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/".$dataKey."split1.webm";
		sleep(3);
		if(file_exists($fileName)){
			
			echo "Done";
		}
		else{
			echo "not found";
		}
	
}
//=======================================================
// Lissa senior dialogue choice
//------------------------------------------------------
else if ($_GET['action']=='savedialoguechoice'){
	$keyNumber = $_GET["keyNumber"];
	$value = $_GET["value"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/dialogueChoice.txt";
	unlink($fileName);
	$filetowrite = fopen ($fileName, "a");
	
	fwrite ($filetowrite,$value);
	fclose($filetowrite);
}
else if ($_GET['action']=='readdialoguechoice'){
	$keyNumber = $_GET["keyNumber"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/dialogueChoice.txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
	}
}
//=======================================================
// Read from senior Output
//------------------------------------------------------
else if ($_GET['action']=='seniorReadoutput'){
	$keyNumber = $_GET["keyNumber"];
	$user = $_GET["user"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/$user.txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		fclose($filetoread);
	}
}

else if ($_GET['action']=='clearSpeech'){
	$keyNumber = $_GET["keyNumber"];
	for ($i=$keyNumber;$i<$keyNumber+10; $i+=1){
		$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/speech$i.txt";
		if(file_exists($fileName)){
			unlink($fileName);
		}
	}
	
}
else if ($_GET['action']=='seniorReadoutputFinal'){
	$keyNumber = $_GET["keyNumber"];
	$user = $_GET["user"];
	$fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/$user.txt";
	if(file_exists($fileName)){
		$filetoread = fopen ($fileName, "r");
		echo fread($filetoread,filesize($fileName));
		// echo ("\n");
		fclose($filetoread);
	}
	else{
		echo "1111";
	}
	// for($i = 0; $i<7; $i++){
		
		// $fileName = "C:/inetpub/wwwroot/RocSpeakRafayet/outSenior$keyNumber.txt";
		// if(file_exists($fileName)){
			// $filetoread = fopen ($fileName, "r");
			// echo fread($filetoread,filesize($fileName));
			// echo ("\n");
			// fclose($filetoread);
		// }
		// $keyNumber = $keyNumber -1;
	// }
}
//====================================================
//merging the files
//----------------------------------------------------
else if ($_GET['action']=='mergeWav'){
	$command=$_GET["command"];
	echo $command;
	$audioVideoDir = "C:\inetpub\wwwroot\RocSpeakRafayet\uploads";
	$out=shell_exec("cd $audioVideoDir & $command");
	//$out=shell_exec("cd $audioVideoDir 2>&1");
	echo $out;
	//$out=shell_exec("$command 2>&1");
	//echo $out;
}
else if ($_GET['action']=='mergeWav2'){
	$command=$_GET["command"];
	$dataKey=$_GET["dataKey"];
	//echo $command;
	$space = array(" ");
	$onlyconsonants = str_replace($space, "+", $command);
	echo $onlyconsonants;
	$audioVideoDir = "C:\inetpub\wwwroot\RocSpeakRafayet\uploads";
	$out=shell_exec("cd $audioVideoDir & copy /b $onlyconsonants $dataKey.wav");
	//$out=shell_exec("cd $audioVideoDir 2>&1");
	echo $out;
	//$out=shell_exec("$command 2>&1");
	//echo $out;
}
else if ($_GET['action']=='mergeWebm'){
	$command=$_GET["command"];
	$dataKey=$_GET["dataKey"];
	//echo $command;
	$space = array(" ");
	$onlyconsonants = str_replace($space, "+", $command);
	echo $onlyconsonants;
	$audioVideoDir = "C:\inetpub\wwwroot\RocSpeakRafayet\uploads";
	$out=shell_exec("cd $audioVideoDir & copy /b $onlyconsonants $dataKey.webm");
	//$out=shell_exec("cd $audioVideoDir 2>&1");
	echo $out;
	//$out=shell_exec("$command 2>&1");
	//echo $out;
}
//====================================================
// Checking if formatted data files exist
//----------------------------------------------------
else if ($_GET['action'] == 'checkformatteddata') {
  $dataKey = $_GET["dataKey"];
  echo $dataKey;
  $averageFeaturesFile = "data/average-features-$dataKey.txt"; 
  $temporalFeaturesFile = "data/temporal-features-$dataKey.txt";
  if (file_exists($averageFeaturesFile) and file_exists($temporalFeaturesFile)) {
    echo "checkTrue";
    if ($_GET["private"] == "true") {
    
      $_SESSION["$dataKey-serialChartData"] = file_get_contents("data/temporal-features-$dataKey.txt");
      $_SESSION["$dataKey-averageFeatures"] = file_get_contents("data/average-features-$dataKey.txt");
      $audioAlignmentFile = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-alignment-$dataKey.txt";
      if (file_exists($audioAlignmentFile)) {
        $_SESSION["$dataKey-audioAlignmentChartData"] = file_get_contents($audioAlignmentFile);
        unlink($audioAlignmentFile);
      }
      $wordProsodyFile = "data/word-prosody-$dataKey.txt";
      if (file_exists($wordProsodyFile)) {
        $_SESSION["$dataKey-wordProsodyData"] = file_get_contents($wordProsodyFile);
        unlink($wordProsodyFile);
      }
      if (!is_dir("temp_uploads/")) mkdir("temp_uploads/");
      rename("uploads/$dataKey-merge.webm","temp_uploads/$dataKey-merge.webm");
      $_SESSION["$dataKey-mergedVideo"] = "temp_uploads/$dataKey-merge.webm";
      
      unlink("data/temporal-features-$dataKey.txt");
      unlink("data/average-features-$dataKey.txt");
      unlink("uploads/$dataKey.webm");
      unlink("uploads/$dataKey.wav");
      unlink("C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-transcript-$dataKey.txt");
    }
    unlink("C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey.TextGrid");
    unlink("C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey-11K.wav");
    unlink("uploads/$dataKey.avi");
  }
  else {
	echo "checkNotTrue";
  }
}

//====================================================
// checkformatteddataLissa
//----------------------------------------------------
else if ($_GET['action'] == 'checkformatteddataLissa') {
  $dataKey = $_GET["dataKey"];
  echo $dataKey;
  $averageFeaturesFile = "data/average-features-$dataKey.txt"; 
  $temporalFeaturesFile = "data/audio-video-features-$dataKey.js";
  if (file_exists($averageFeaturesFile) or file_exists($temporalFeaturesFile)) {
    echo "checkTrue";
  }
  else {
	echo "checkNotTrue";
  }
}

//====================================================
// save file name Lissa
//----------------------------------------------------
else if ($_GET['action'] == 'savefilenameLissa') {
  $dataKey = $_GET["dataKey"];
  echo $dataKey;
  $Filename = "data/average-features-$dataKey.txt"; 
  $FiletoWrite = fopen("C:/inetpub/wwwroot/RocSpeakRafayet/dataFileNames.txt", 'a');
  fwrite ( $FiletoWrite, $dataKey."\n");
  fclose($FiletoWrite);
}
//====================================================
// Format the Forced Alignment
//----------------------------------------------------
else if ($_GET['action'] == 'formatforcealign') {
  $dataKey = $_GET['dataKey'];
  
  $formattedAlignmentFilename = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-alignment-$dataKey.txt";
  $rawAudioAlignmentFilename = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey.TextGrid";
  $alignmentFile = fopen($rawAudioAlignmentFilename,"r");
  $speechArray = array();
  if ($alignmentFile and !file_exists($formattedAlignmentFilename)) {
    for ($i=0;$i<3;$i++) {
      // skip TextGrid header
      fgets($alignmentFile);
    }
    $speechArray["startTime"] = floatval(trim(fgets($alignmentFile)));
    $speechArray["endTime"] = floatval(trim(fgets($alignmentFile)));
    for ($i=0;$i<2;$i++) {
      // skip lines
      fgets($alignmentFile);
    }
    while(($line = fgets($alignmentFile)) !== false) {
      $line = trim($line);
      if ($line == "\"IntervalTier\"") {
        $currentTier = substr(trim(fgets($alignmentFile)),1,-1);
        $speechArray[$currentTier] = array();
        for ($i=0;$i<3;$i++) {
          // skip lines
          fgets($alignmentFile);
        }
      } else if (!empty($line)) {
        $tempStartTime = floatval($line);
        $tempEndTime = floatval(trim(fgets($alignmentFile)));
        // tempCurrSpeech is a phone or word
        $tempCurrSpeech = substr(trim(fgets($alignmentFile)),1,-1);
        array_push($speechArray[$currentTier], array("speech"=>$tempCurrSpeech,"startTime"=>$tempStartTime,"endTime"=>$tempEndTime));
      } else {
        echo "invalid textgrid value!";
      }
    }
    fclose($alignmentFile);
    
    $formattedAlignmentFile= fopen($formattedAlignmentFilename,"w");
    fwrite($formattedAlignmentFile, json_encode($speechArray));
    fclose($formattedAlignmentFile);
  } else {
    echo "could not open audio alignment file: $rawAudioAlignmentFilename'";
  }
}
//====================================================
// Upload the transcript
//----------------------------------------------------
else if ($_GET['action'] == 'uploadtranscript') {
  $transcript = $_POST['transcript'];
  $dataKey = $_GET['dataKey'];
  
  echo "original transcript".$transcript;
  
  $formattedTranscriptFilename = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-transcript-$dataKey.txt";
  
  if (!file_exists($formattedTranscriptFilename)) {
    preg_match_all("/[0-9]+|[[:upper:][:lower:]]+/",$transcript,$matches);
    if (count($matches[0]) > 0) {
      echo "<br/>matches: ";
      print_r($matches);
      echo "<br/>";
      for ($i=0;$i<count($matches[0]);$i++) {
         if (is_numeric($matches[0][$i])) $matches[0][$i] = convert_number_to_words($matches[0][$i]);
      }
      $transcript = join(" ",$matches[0]);
    }
    $transcript = strtoupper($transcript);
    
    $formattedTranscriptFile = fopen($formattedTranscriptFilename,"w");
    fwrite($formattedTranscriptFile, $transcript);
    fclose($formattedTranscriptFile);
  }
  
  echo $transcript."<br/><br/>";
  
  if (file_exists("C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey-11K.wav")) {
    $output = shell_exec("C:/cygwin/bin/bash.exe --login -c 'python  /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/align.py /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey-11K.wav /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-transcript-$dataKey.txt /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey.TextGrid'  2>&1");
  } else {
    $output = shell_exec("cd C:/inetpub/wwwroot/Release_standalone/ & ffmpeg -y -i C:/inetpub/wwwroot/RocSpeakRafayet/uploads/$dataKey.wav -ar 11025 C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey-11K.wav & C:/cygwin/bin/bash.exe --login -c 'python  /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/align.py /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey-11K.wav /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/formatted-transcript-$dataKey.txt /cygdrive/c/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey.TextGrid'  2>&1");
  }
  var_dump($output);
}
//====================================================
// Checking if transcript alignment files exist
//----------------------------------------------------
else if ($_GET['action'] == 'checkgetalignment') {
  $dataKey = $_GET["dataKey"];
  $rawAudioAlignmentFilename = "C:/inetpub/wwwroot/Release_standalone/forced_aligner/p2fa/output/$dataKey.TextGrid";
  if (file_exists($rawAudioAlignmentFilename)) echo "true";
  else echo "false";
}

function convert_number_to_words($number) {
    
    $hyphen      = '-';
    $conjunction = ' and ';
    $separator   = ', ';
    $negative    = 'negative ';
    $decimal     = ' point ';
    $dictionary  = array(
        0                   => 'zero',
        1                   => 'one',
        2                   => 'two',
        3                   => 'three',
        4                   => 'four',
        5                   => 'five',
        6                   => 'six',
        7                   => 'seven',
        8                   => 'eight',
        9                   => 'nine',
        10                  => 'ten',
        11                  => 'eleven',
        12                  => 'twelve',
        13                  => 'thirteen',
        14                  => 'fourteen',
        15                  => 'fifteen',
        16                  => 'sixteen',
        17                  => 'seventeen',
        18                  => 'eighteen',
        19                  => 'nineteen',
        20                  => 'twenty',
        30                  => 'thirty',
        40                  => 'fourty',
        50                  => 'fifty',
        60                  => 'sixty',
        70                  => 'seventy',
        80                  => 'eighty',
        90                  => 'ninety',
        100                 => 'hundred',
        1000                => 'thousand',
        1000000             => 'million',
        1000000000          => 'billion',
        1000000000000       => 'trillion',
        1000000000000000    => 'quadrillion',
        1000000000000000000 => 'quintillion'
    );
    
    if (!is_numeric($number)) {
        return false;
    }
    
    if (($number >= 0 && (int) $number < 0) || (int) $number < 0 - PHP_INT_MAX) {
        // overflow
        trigger_error(
            'convert_number_to_words only accepts numbers between -' . PHP_INT_MAX . ' and ' . PHP_INT_MAX,
            E_USER_WARNING
        );
        return false;
    }

    if ($number < 0) {
        return $negative . convert_number_to_words(abs($number));
    }
    
    $string = $fraction = null;
    
    if (strpos($number, '.') !== false) {
        list($number, $fraction) = explode('.', $number);
    }
    
    switch (true) {
        case $number < 21:
            $string = $dictionary[$number];
            break;
        case $number < 100:
            $tens   = ((int) ($number / 10)) * 10;
            $units  = $number % 10;
            $string = $dictionary[$tens];
            if ($units) {
                $string .= $hyphen . $dictionary[$units];
            }
            break;
        case $number < 1000:
            $hundreds  = $number / 100;
            $remainder = $number % 100;
            $string = $dictionary[$hundreds] . ' ' . $dictionary[100];
            if ($remainder) {
                $string .= $conjunction . convert_number_to_words($remainder);
            }
            break;
        default:
            $baseUnit = pow(1000, floor(log($number, 1000)));
            $numBaseUnits = (int) ($number / $baseUnit);
            $remainder = $number % $baseUnit;
            $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit];
            if ($remainder) {
                $string .= $remainder < 100 ? $conjunction : $separator;
                $string .= convert_number_to_words($remainder);
            }
            break;
    }
    
    if (null !== $fraction && is_numeric($fraction)) {
        $string .= $decimal;
        $words = array();
        foreach (str_split((string) $fraction) as $number) {
            $words[] = $dictionary[$number];
        }
        $string .= implode(' ', $words);
    }
    
    return $string;
}
?>
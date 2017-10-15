<?php 
include "include/vars.php";
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
if (!empty($_GET["debug"])) $dataKey = "debug_".$dataKey;
?>
<!DOCTYPE html>
<html>
<head>
<title><?php echo $pageTitle; ?></title>

<meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>

<link rel="stylesheet" href="css/style.css" />
<style>
#status {
  width: 100%;
  color: #999999;
  text-align: center;
  position:fixed;
  bottom:0px;
  padding:5px 0;
}
</style>

<script src="https://cwilso.github.io/AudioContext-MonkeyPatch/AudioContextMonkeyPatch.js"></script>
<script src="js/RecordRTC_TryIt_New.js"></script>
<script src="js/channel.js"></script>
<script src="js/contributePage.js"></script>
<!-- Load the polyfill to switch-hit between Chrome and Firefox -->
<script src="js/adapter.js"></script>
</head>
<body>

<?php include "include/nav.php"; ?>
  

<script type="text/javascript">
var baseDataKey = "<?php echo $dataKey; ?>";
setTimeout(initialize, 1);
</script>

<div id="videoContainer" style="background:#000000;position:fixed;left:0;width:100%;text-align:center">
  <video id="localVideo" autoplay="autoplay" muted="true"/></video>
</div>
<div id="status">
  <input type="button" class="btn btn-default btn-lg" value="Start Recording" id="start_button" onclick="startRecordingAfterActive()" disabled/>
  <input type="button" class="btn btn-default btn-lg" id="stop_button" value="Stop Recording" onclick="stopRecordingOnHangup()" disabled />
</div>

<?php echo $flatuiJSImport; ?>
</body>
</html>
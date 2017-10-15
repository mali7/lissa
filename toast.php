<?php 
include "include/vars.php";
$dataKey = MD5(date('Y-m-d_H:i:s')."_".rand()); 
?>
<!DOCTYPE html>
<html>
<head>
<title><?php echo $pageTitle; ?></title>
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>
<?php echo $flatuiHeaderImport; ?>
<link rel="stylesheet" href="css/style.css" />
<style>
.fileUpload {
  position: relative;
  overflow: hidden;
  margin: 10px;
}
.fileUpload input.upload {
  position: absolute;
  top: 0;
  right: 0;
  margin: 0;
  padding: 0;
  font-size: 20px;
  cursor: pointer;
  opacity: 0;
  filter: alpha(opacity=0);
}
</style>
</head>
<body>
<?php include "include/nav.php"; ?>
<div class="jumbotron">
<div class="container text-center">
<h2>MP4 Upload</h2>
<p>Upload an MP4 file to get comments:</p>
<form id="fileUploadForm" onsubmit="mp4onsubmit(); return false;" class="form-inline">
  <input id="uploadFile" placeholder="Choose File" disabled="disabled" class="form-control" />
  <div id="uploadBtnDiv" class="fileUpload btn btn-primary">
    <span>Select MP4</span>
    <input type="file" class="upload" name="uploadBtn" id="uploadBtn" accept="video/mp4" required>
  </div>
  <input type="submit" value="Upload MP4" name="submit" class="btn btn-default" disabled>
</form>
</div>
</div>

<?php echo $flatuiJSImport; ?>
<script>
var baseDataKey = "<?php echo $dataKey; ?>";
var currentFeedbackPage = "<?php echo $currentFeedbackPage; ?>";
</script>
<script src="js/TryItPageToast2.js"></script>
<script src="js/TryItPageToast.js"></script>
</body>
</html>
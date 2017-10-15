<?php 
include "include/vars.php";
$dataKey = $_GET["dataKey"]; 
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<title><?php echo $pageTitle; ?></title>
<?php echo $flatuiHeaderImport; ?>
</head>

<body>
<?php include "include/nav.php"; ?>

<?php
if (empty($_GET["dataKey"])) {
?>
<div class="jumbotron">
<div class="container">
<h2>Look up videos from past sessions:</h2>
<form action="video.php" method="get">
<div class="form-group">
<div class="input-group input-group-hg">                               
  <input type="text" name="dataKey" class="form-control" placeholder="Session ID" maxlength="100">
  <span class="input-group-btn">
    <button type="submit" class="btn"><span class="fui-search"></span></button>
  </span>
</div>
</div>
</form>
</div>
</div>
<div class="container">
<?php } else if (!file_exists("C:/inetpub/wwwroot/RocSpeak/uploads/$dataKey-merge.webm")) { ?>
<div class="jumbotron">
  <div class="container">
  <h2>Invalid Session ID</h2>
  <p>We could not find any video associated with the session ID <b>"<?php echo  htmlentities($dataKey); ?>"</b> at this time.<br/>You can try searching again.</p>
  <form action="video.php" method="get">
  <div class="form-group">
      <div class="input-group input-group-hg">                               
          <input type="text" name="dataKey" class="form-control" placeholder="Session ID" maxlength="100">
          <span class="input-group-btn">
            <button type="submit" class="btn"><span class="fui-search"></span></button>
          </span>
      </div>
  </div>
  </form>
  </div>
</div>
<div class="container">
<?php } else { ?>
<div class="jumbotron">
</div>
<div class="container">
<div class="row" style="text-align:center">
    <div class="col-lg-12">
        <video id="sessionVideo" width="640" style="max-width:100%" src="<?php echo "uploads/$dataKey-merge.webm"; ?>"  type="video/webm" controls ></video>
    </div>
</div>
<hr>
<?php } ?>
    <footer>
    <?php echo $footerContent; ?>
    </footer>
</div>
<!-- /container -->

<?php echo $flatuiJSImport; ?>
</body>

</html>
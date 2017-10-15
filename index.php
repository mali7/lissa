<?php include "include/vars.php"; ?>
<!DOCTYPE html>
<html>
<head>
<title><?php echo $pageTitle; ?></title>
<?php echo $flatuiHeaderImport; ?>
</head>
<body>

<?php include "include/nav.php"; ?>
  

<div class="jumbotron">

<div class="container">
  <h1>Welcome to ROC Speak!</h1>
  <p>Ubiquitous public speaking practice with automated feedback after each session.</p>
</div>
</div>
<div class="container">
  <h3>About using ROC Speak:</h3>
  <div>
    <ul>
    <li>You must use <strong><a href="https://www.google.com/intl/en/chrome/browser/">Google Chrome</a></strong> to view this site.</li>
    <!--li>Your computer must have at least <strong>4GB of RAM</strong>
    (<a href="http://www.computerhope.com/issues/ch000149.htm" target="_blank">how to check</a>).</li-->
    <li>We currently impose a time limit of <strong>2 minutes</strong> for each recording when using the ROC Speak demo.</li>
    <li>The system takes around <strong>5 minutes</strong> to produce the ROC Speak feedback after every recording session (for a 2 minute long recording).</li>
    <li>In private mode, your data is destroyed after you leave this site, and you cannot look up your feedback afterwards.</li>
    </ul>
  </div>
<a href="demo.php" class="btn btn-hg btn-primary btn-embossed">Try ROC Speak &raquo;</a> &nbsp; &nbsp; &nbsp; <a href="demo.php?private=true">Try ROC Speak in Private Mode &raquo;</a>
<hr>
<footer>
<?php echo $footerContent; ?>
</footer>
</div> <!-- /container -->

<?php echo $flatuiJSImport; ?>
</body>
</html>
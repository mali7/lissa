<?php
session_start();
//$pages = array("about"=>"About","demo"=>"ROC Speak Demo","contribute"=>"Video Only Demo","feedback"=>"Feedback Lookup","video"=>"Video Lookup","help"=>"Help");
$pages = array("demo"=>"ROC Speak Demo","contribute"=>"Video Only Demo","turkfeedback"=>"Feedback Lookup","video"=>"Video Lookup");
$currentPage = explode("/",basename($_SERVER['PHP_SELF']));
$currentPage = $currentPage[count($currentPage)-1];

$pageTitle = explode(".",$currentPage);

if (array_key_exists($pageTitle[0],$pages)) $pageTitle = $pages[$pageTitle[0]]." - ROC Speak";
else $pageTitle = "ROC Speak - MACH Interaction";

$thisYear = date("Y");
$footerContent = "<p><a href=\"/\">&copy; MACH Interaction $thisYear</a></p>";

$flatuiHeaderImport = '
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Loading Bootstrap -->
<link href="/flatui/bootstrap/css/bootstrap.css" rel="stylesheet">
<!-- Loading Flat UI -->
<link href="/flatui/css/flat-ui.css" rel="stylesheet">
<link rel="shortcut icon" href="/flatui/images/favicon.ico">
<!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
<!--[if lt IE 9]>
  <script src="/flatui/js/html5shiv.js"></script>
  <script src="/flatui/js/respond.min.js"></script>
<![endif]-->';

$flatuiJSImport = '
<!-- Load JS here for greater good =============================-->
<script src="/flatui/js/jquery-1.8.3.min.js"></script>
<script src="/flatui/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/flatui/js/jquery.ui.touch-punch.min.js"></script>
<script src="/flatui/js/bootstrap.min.js"></script>
<script src="/flatui/js/bootstrap-select.js"></script>
<script src="/flatui/js/bootstrap-switch.js"></script>
<script src="/flatui/js/flatui-checkbox.js"></script>
<script src="/flatui/js/flatui-radio.js"></script>
<script src="/flatui/js/jquery.tagsinput.js"></script>
<script src="/flatui/js/jquery.placeholder.js"></script>
<script src="/flatui/js/typeahead.js"></script>
<script src="/flatui/js/application.js"></script>'.file_get_contents("C:/inetpub/wwwroot/include/analytics.php");

?>
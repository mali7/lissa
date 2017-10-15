<?php 
include "include/vars.php";
$dataKey = $_GET["dataKey"];
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<title><?php echo $pageTitle; ?></title>
<?php echo $flatuiHeaderImport; ?>
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">

		<script>
			var HITId;
			var HITId1;
			var HITId2;
			var stage;
		</script>
</head>

<script>
	var dataSet1;
	var result;
	
	function isNullOrWhiteSpace(str){
		return str === null || str.match(/^ *$/) !== null;
	}
	
	function showAssignmentsforHIT()
	{
		HITId1 = getId(1);
		HITId2 = getId(2);
		$.ajax({
					type: "POST",
					dataType: "json",
					async: false,
					url: "turkcalls.php",
					data: { 
						action: "getAssignmentsforHIT",
						HITId1: HITId1,
						HITId2: HITId2
						},
					cache: false,
					success: function(data){
						$("#getFeedback").html("");
						result = data[0]; 
						var allTurkComments = "";
						for(var i = 0; i < result.length; i++)
						{
							if(result[i].category == 'F')
							{
								if(!isNullOrWhiteSpace(result[i].timestamp) && !isNullOrWhiteSpace(result[i].comment))
								{
									console.log("Friendliness:",result[i].timestamp,result[i].comment);
									allTurkComments += "\n Friendliness\t"+result[i].timestamp+"\t"+ result[i].comment;
								}
							}
							
							if(result[i].category == 'B')
							{
								if(!isNullOrWhiteSpace(result[i].timestamp) && !isNullOrWhiteSpace(result[i].comment))
								{
									console.log("Body Gestures:",result[i].timestamp,result[i].comment);
									allTurkComments+="\n Body Gestures\t"+result[i].timestamp+"\t"+ result[i].comment;
								}
							}
							
							if(result[i].category == 'V')
							{
								if(!isNullOrWhiteSpace(result[i].timestamp) && !isNullOrWhiteSpace(result[i].comment))
								{
									console.log("Volume Modulation:",result[i].timestamp, result[i].comment);
									allTurkComments+="\n Volume Modulation\t"+result[i].timestamp+"\t"+ result[i].comment;
								}
							}
							
							
						}
						$("#turkCommentsBox").val(allTurkComments);
						
						result = data[1];
						var overallscore = 0;
						for(var k = 0; k < result['O'].length; k++)
						{
							overallscore += (k+1)*result['O'][k];
						}
						console.log("Overallscore:", overallscore);
						
						var ratingdata = [
						{
							"1": result['O'][0],
							"2": result['O'][1],
							"3": result['O'][2],
							"4": result['O'][3],
							"5": result['O'][4],
							"6": result['O'][5],
							"7": result['O'][6],
							"category": "Overall"
						},
						{
							"1": result['B'][0],
							"2": result['B'][1],
							"3": result['B'][2],
							"4": result['B'][3],
							"5": result['B'][4],
							"6": result['B'][5],
							"7": result['B'][6],
							"category": "Body Gestures"
						},
						{
							"1": result['F'][0],
							"2": result['F'][1],
							"3": result['F'][2],
							"4": result['F'][3],
							"5": result['F'][4],
							"6": result['F'][5],
							"7": result['F'][6],
							"category": "Friendliness"
						},
						{
							"1": result['V'][0],
							"2": result['V'][1],
							"3": result['V'][2],
							"4": result['V'][3],
							"5": result['V'][4],
							"6": result['V'][5],
							"7": result['V'][6],
							"category": "Volume Modulation"
						}];
						result = data[0];
					}
				});

	}
	
	function approveAssignment(AssignmentId)
	{
		$.ajax({
					type: "POST",
					url: "turkcalls.php",
					data: { action: "approveAssignment",
							AssignmentId : AssignmentId, },
					cache: false,
					success: function(result){
						getAssignmentsforHIT();
						//$("#testFeedback").html(result);
					}
				});
		
	}

	function rejectAssignment(AssignmentId)
	{
		$.ajax({
					type: "POST",
					url: "turkcalls.php",
					data: { action: "rejectAssignment",
							AssignmentId : AssignmentId, },
					cache: false,
					success: function(result){
						getAssignmentsforHIT();
					}
				});
	}
	
	function createHIT()
	{
		var passwd = prompt("Password : ");

		if(passwd == "rochci")
		{
		$("#getStatus").html("");
		//var Hitname = document.getElementById('Hitname').value;
		var datakey  = getParameterByName('dataKey');
		//console.log("datakey", datakey);
		//document.write(datakey);
				$.ajax({
					type: "POST",
					url: "turkcalls.php",
					data: { action: "createHIT",
							datakey: datakey },
					cache: false,
					success: function(result){
						HITId = result;

						updateFeedback(0, result);
						updateFeedback(1, result);
						getAssignmentsforHIT();
					}
				});
			}
	}
	
	function createHIT2()
	{
		var HITId = getId(1);    //from database.php
		var datakey  = getParameterByName('dataKey');
			$.ajax({
					type: "POST",
					url: "turkcalls.php",
					data: { action: "createHIT2",
							datakey: datakey,
							HITId: HITId },
					cache: false,
					success: function(result){
						updateFeedback(2, result);
						getAssignmentsforHIT2();
					}
				});
	}
	
	
	function updateFeedback(column, HITId)
	{
		var datakey  = getParameterByName('dataKey');		
			$.ajax({
					type: "POST",
					url: "database.php",
					data: { action: "updateFeedbackId",
							column: column,
							datakey: datakey,
							HITId: HITId},
					cache: false,
					success: function(result){
						//document.write(result);
					}
				});		
	
	}

	function getId(column)
	{
		var datakey  = getParameterByName('dataKey');
		var id;
			$.ajax({
					type: "POST",
					url: "database.php",
					data: { action: "getId",
							column: column,
							datakey: datakey },
					async: false,
					cache: false,
					success: function(result){
						//document.write(result);
						//return result;
						id = result;
					}
				});
		return id;
	}
	
	function checkStage()
	{
		var datakey  = getParameterByName('dataKey');
			$.ajax({
					type: "POST",
					url: "database.php",
					data: { action: "checkStage",
							datakey: datakey },
					async: false,
					cache: false,
					success: function(result){
						//document.write(result);
						//$("#getFeedback").html(result);
						stage = result;
					}
				});
		//$("#getFeedback").html(stage);
		return stage;
	}
	
	function getAssignmentsforHIT2()
	{
		$( ".progress" ).show();
		var id = getId(2);
		
		//$("#getFeedback").html(getCountsforHIT(id));
		var t = setInterval(function(){
			var numass = getCountsforHIT(id); 
			$("#getStatus").html("Rating the comments: "  + numass + "/10");
			$('#commentbar').css("width","50%");
			$('#commentbar').html("50% (comments)");
			$('#ratingbar').width(numass/20*100 + '%');
			$('#ratingbar').html(numass/20*100 + " % (ratings)");
			
			if(numass == 10)
			{
				clearTimeout(t);
				showAssignmentsforHIT();
			}
			
			$("#getStatus").html("Rating the comments: "  + numass + "/10");
			$('#commentbar').css("width","50%");
			$('#commentbar').html("50% (comments)");
			$('#ratingbar').width(numass/20*100 + '%');
			$('#ratingbar').html(numass/20*100 + " % (ratings)");
		},7000);
		
	}
	
	function getAssignmentsforHIT()
	{
		$( ".progress" ).show();
		var id = getId(1);
		var t = setInterval(function(){
			var numass = getCountsforHIT(id); 
			$("#getStatus").html("Getting feedback "  + numass + "/10");
			$('#commentbar').width(numass/20*100 + '%');
			$('#commentbar').html(numass/20*100 + " % (comments)");
			
			if(numass == 10)
			{
				clearTimeout(t);
				createHIT2();
				getAssignmentsforHIT2();
			}
			
			$("#getStatus").html("Getting feedback "  + numass + "/10");
			$('#commentbar').width(numass/20*100 + '%');
			$('#commentbar').html(numass/20*100 + " % (comments)");
		},7000);
						

		//$("#getFeedback").append(getCountsforHIT(id));*/
	}
	
	function getCountsforHIT(HITId)
	{
		var numofAssignments;
		$.ajax({
					type: "POST",
					url: "turkcalls.php",
					data: { action: "getCountsforHIT",
							HITId: HITId},
					cache: false,
					async: false,
					success: function(result){
						//document.write(result);
						//$("#getFeedback").html(result);
						numofAssignments = result;
					}
				});
		return numofAssignments;
	}
	
	window.onload = (function() {		
		var stage = checkStage();
		if (stage < 2)
		{
			$( ".progress" ).hide();
			$("#getStatus").html("<button class='amChartsButtonSelected btn btn-info btn-sm' id='createHIT' onclick=createHIT()>Get Personal Feedback from People</button>");
		}else if(stage == 2)
		{
			getAssignmentsforHIT();
		}else{
			getAssignmentsforHIT2();
		}
	});
	
	function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
</script>

<body>
<?php 
include "include/nav.php";

if (empty($_GET["dataKey"])) {
?>
<div class="jumbotron">
<div class="container">
<h2>Look up feedback from past sessions:</h2>
<form action="turkcomments.php" method="get">
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
<?php } else if (!(file_exists("data/average-features-$dataKey.txt") or isset($sessionAverageFeatures))) { ?>
<div class="jumbotron">
  <div class="container">
  <h2>Invalid Session ID</h2>
  <p>We could not find any feedback associated with the session ID <b>"<?php echo  htmlentities($dataKey); ?>"</b> at this time.<br/>You can try searching again.</p>
  <form action="feedback.php" method="get">
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
<div class="row">
    <div class="col-lg-4" style="position:relative">
    <div id="videoContainer">
		<div id="getFeedback"> <div id = "getStatus"> </div> <div class="progress">
  <div id = "commentbar" class="progress-bar progress-bar-danger" style="width: 0%">
    0% (comments)
  </div>
  
  <div id = "ratingbar" class="progress-bar progress-bar-success" style="width: 0%">
    0% (ratings)
  </div>

  
</div></div>

	</div>
    </div>
	<div class="col-lg-8">
		<textarea id="turkCommentsBox" style="width:100%" rows=30></textarea>
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


<?php if (!empty($_GET["dataKey"]) and (file_exists("data/average-features-$dataKey.txt") or isset($sessionAverageFeatures))) { ?>
<script src="/amstockchart_3.4.5/amcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/themes/light.js"></script>
<script type="text/javascript" src="/amstockchart_3.4.5/amstock.js"></script>

<?php } ?>
</body>

</html>
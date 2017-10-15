<?php 
$dataKey = $_GET["dataKey"];
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<title><?php echo $pageTitle; ?></title>
<?php echo $flatuiHeaderImport; ?>

		<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
	var poll_xhr;
	var HITId;
	
	</script>
	</head>
	<body>
	<script>
	function getAssignmentsforHIT()
	{
	
		 $.ajax({
					type: "POST",
					url: "mainturkuicalls.php",
					data: { 
						action: "getAssignmentsforHIT",
						HITId: HITId,
						},
					cache: false,
					success: function(result){
						//document.write(result);
						$("#getFeedback").html(result);
					}
				});
				
		(function poll(){
				poll_xhr = $.ajax({ 
						type: "POST",
						url: "mainturkuicalls.php",
						data: {
							action: "getAssignmentsforHIT",
							HITId: HITId,
							},
					cache: false,
					success: function(result){
						//$("#getFeedback").html(result);

						if(result == "completed")
						{
							
							//document.write("what is going on?");
							createHIT2();

							//document.getElementById("createHIT").value= "Awaiting for Reviews";
						}
						/*else
						{
							$("#getFeedback").html(result);			
						}*/
					//clearMarkers();
				}, dataType: "html", complete: poll, timeout: 30000 });
			})();
		

	}
	

	function createHIT()
	{
		//var dataString = 'orderid='+ orderid;
				//document.write(dataString);
		var Hitname = document.getElementById('Hitname').value;

				$.ajax({
					type: "POST",
					url: "mainturkuicalls.php",
					data: { action: "createHIT",
							Hitname: Hitname, },
					cache: false,
					success: function(result){
						//document.write(result);
						HITId = result;
						//getAssignmentsforHIT();
						//document.getElementById("createHIT").disabled = true;
						//$("#getFeedback").html(result);
					}
				});
		$("#getFeedback").html(HITId);

	
	}
	
	function createHIT2()
	{
		//poll_xhr.abort();
		ajax.abort();
		console.log("testing abort");
		//var dataString = 'orderid='+ orderid;
				//document.write(dataString);
		var Hitname = document.getElementById('Hitname').value;

				$.ajax({
					type: "POST",
					url: "mainturkuicalls.php",
					data: { action: "createHIT2",
							HITId: HITId,
							Hitname: Hitname, },
					cache: false,
					success: function(result){
						//document.write(result);
						//HITId = result;
						//getAssignmentsforHIT();
						//document.getElementById("createHIT").disabled = true;
						$("#getFeedback").html(result);
					}
				});
				
	
	}
	

</script>

<input type="Hitname" name="Hitname" id="Hitname" value="testhit">

</br></br><div id="getFeedback"> 
	<button class='createHIT' id="createHIT" onclick=createHIT()>create HIT</button> </div>
	
</body>
</html>
<!DOCTYPE html>
<html>
<input type="text" id="textfield">
<input type="submit" onclick="makeresults()">
</html>
<script>
	
	var count = 0;
	var lengthcount = 0;
	 
function makeresults(){
	var textf = document.getElementById("textfield");
	console.log(textf.value);
	var xhr1 = new XMLHttpRequest();
	xhr1.open('GET', "response.php?action=processvideo&vid="+textf.value, true);
	xhr1.send();

	
	//processvid();
	
	var donetime = setInterval(function(){
		xhr1.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log("From check "+this.responseText);
					if(this.responseText == "done"){
						textf.value="done";
						//clearInterval(donetime);
					}
				}
			}
		}
		xhr1.open('GET', "response.php?action=checkprocessvideo&name="+textf.value, true);
		xhr1.send();
		console.log("set");
	},3000);
}

// function processvid(){
	// var name =[341,342,345,347,354,355,432,440,441];
	// var length = [582,452,484,500,614,446,518,506,258];
	// var vid = name[count];
	
	// var pieces = length[count];
	// var txt = vid+"\.wmv-"+lengthcount;
	// console.log(txt);
	// var xhr1 = new XMLHttpRequest();
	// xhr1.onreadystatechange = function(){
		// if (this.readyState == 4) {
				// if (this.status == 200) {
					// console.log("From --- "+this.responseText);
				// }
		// }
		
	// }
	// xhr1.open('GET', "response.php?action=processvideo&vid="+vid+"&lengthcount="+lengthcount, true);
	// xhr1.send();
	// lengthcount+=2;
	// if (lengthcount>pieces){
		// lengthcount=0;
		// count++;
		
	// }
	// if(count<9)setTimeout(processvid,1000);
// }
</script>
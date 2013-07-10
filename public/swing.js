
var count = 0;
var timerID = 0;
var launchDataTimerID = 0;

var isSwinging = false;
var doingBackswing = false;
var doingDownswing = false;
var power = 0;
var direction = 0;
var clubTranslation = "translate(190px, 200px)";
var weatherCount = 0;
var lastCommandObj = null;

function startSwing()
{
	if (isSwinging)
	{
		return;
	}
	
	isSwinging = true;
	doingBackswing = true;

	var rotateString = "rotate(260deg)";		
	document.getElementById("divClub").style.MozTransform = clubTranslation + " " + rotateString;		
	document.getElementById("divClub").style.WebkitTransform = clubTranslation + " " + rotateString;	

	timerID = setInterval ( "onTimer()", 10 );
}

// Click top of backswing
function registerPower()
{
	if (!isSwinging)
	{
		return;
	}
	
	if (!doingBackswing)
	{
		return;
	}
	
	var rotateString = "rotate(-90deg)";
	document.getElementById("divClub").style.MozTransform = clubTranslation + " " + rotateString;		
	document.getElementById("divClub").style.WebkitTransform = clubTranslation + " " + rotateString;	

	power = count;
	
	doingBackswing = false;
	doingDownswing = true;
}

function registerDirection()
{
	if (!isSwinging)
	{
		return;
	}
	
	if (!doingDownswing)
	{
		return;
	}
	
	clearTimeout(timerID);
	
	doingBackswing = false;
	doingDownswing = false;
	isSwinging = false;
	
	direction = count;
	
	//alert('Direction registered')
	
	sendCommandToServer();
	
}


function sendCommandToServer()
{
	var url = "api/send_swing_command";

	var request = new XMLHttpRequest();
	request.open("PUT", url, true);

	power = Math.floor(power / 10);
	if (power > 15) {
		power = 15;
	}

	power = 151 + power;
	direction = 10501 + direction;

	document.getElementById("debug").value = "pwr: " + power + ", dir: " + direction;

	var params = "power=" + power + "&direction=" + direction;

	//Send the proper header information along with the request
	request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	request.setRequestHeader("Content-length", params.length);
	request.setRequestHeader("Connection", "close");

	request.onload = function() {
		if (request.status == 200) {
			console.log(request.responseText);
			var responseObj = JSON.parse(request.responseText);
			lastCommandObj = responseObj.data;
			document.getElementById("results").innerHTML = lastCommandObj.id + " >>> " + JSON.stringify(lastCommandObj, null, 4);

			// starting polling server to get launch data for this command
			startLaunchDataTimer();
		} else {
			alert(request.status + " " + request.statusText);
		}
	}

	request.onerror = function() {
		alert("error it");
	}

	request.send(params);
}

window.onload = function () 
{
	startWeatherTimer();
}

function onTimer()
{
	if (doingBackswing)
	{
		count = count + 1;
	} else {
		count = count - 1;
	}		
}

function onGetWeather()
{
	getWeather();
}

function getWeather()
{
	var url = "api/get_latest_weather";

	var request = new XMLHttpRequest();
	request.open("GET", url);

	request.onload = function() {
		
		weatherCount++;

		if (request.status == 200) {
			console.log(request.responseText);

			var responseObj = JSON.parse(request.responseText);
			var weatherObj = responseObj.data;

			document.getElementById("weather").innerHTML = weatherCount 
				+ " -> Speed: " + weatherObj.wind_speed 
				+ ", Direction: " + weatherObj.wind_direction;
			//document.getElementById("weather").innerHTML = weatherCount + " -> " + request.responseText;
		} else {
			alert(request.status + " " + request.statusText);
		}

	}

	request.onerror = function() {
		alert(request.status + " " + request.statusText);
	}

	request.send(null);
}

function onReset ()
{
	clearTimeout(timerID);
	
	isSwinging = false;
	doingBackswing = false;
	doingDownswing = false;

	lastCommandObj = null;
	
	power = 0;
	direction = 0;
	
	count = 0;
	
	document.getElementById("debug").value = "";
	var rotateString = "rotate(" + (0 - count) + "deg)";
	document.getElementById("divClub").style.MozTransform = clubTranslation + " " + rotateString;
	document.getElementById("divClub").style.WebkitTransform = clubTranslation + " " + rotateString;
}

function startWeatherTimer()
{
	getWeather();
	weatherTimerID = setInterval ("onWeatherTimer()", 13000);
}

function onWeatherTimer()
{
	// grab weather
	getWeather();
}

		
function startLaunchDataTimer()
{
	// Set this after sending a command
	launchDataTimerID = setInterval ("onLaunchDataTimer()", 5000);
}

function stopLaunchDataTimer()
{
	// Set this after sending a command
	clearTimeout(launchDataTimerID);
}

function onLaunchDataTimer()
{
	getLaunchData();
}

function getLaunchData()
{
	// if should be looking for shot data
	if (!lastCommandObj)
	{
		return;
	}

	// get_command_item

	var url = "api/get_command_item?command_id=" + lastCommandObj.id;
	doGetRequest(url, onGotCommandItem);
	


	// try to get shot_id from command_id

	// if get shot_id, then launch data is possibly there (maybe not)

	// if successfully get launch data, then show on screen

	// clear the launch data timer when the launch data is retrieved

	
}

function onGotCommandItem(response)
{
	console.log(JSON.stringify(response))
	var commandItem = response.data;
	document.getElementById("launchData").innerHTML = JSON.stringify(commandItem, null, 4);

	var url = "shots/" + commandItem.shot_id + ".json";
	doGetRequest(url, onGotShot);
}

function onGotShot(response)
{
	// figure out if it's time to head to the report page.

	var shot = response.shot;
	var landings = response.ball_landings;
	var landing = landings[2];

	if (landing) {

		stopLaunchDataTimer();
		goToReportPage(shot.id);
		
	}
}

function onGoToReport()
{
	goToReportPage(13);
}

function goToReportPage(shotID)
{
	sessionStorage.setItem("shotID", shotID);
	redirectTo("report.html");
}




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
			document.getElementById("results").innerHTML = lastCommandObj.id + " >>> " + JSON.stringify(lastCommandObj);

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
	var commandItem = response.data;
	document.getElementById("launchData").innerHTML = JSON.stringify(commandItem);

	var url = "shots/" + commandItem.shot_id + ".json";
	doGetRequest(url, onGotShot);
}

function onGotShot(response)
{
	var shot = response.shot;
	var landings = response.ball_landings;
	var landing = landings[2];

	/*
	landing = {
        "carry": 87.87,
        "created_at": "2013-07-09T19:01:43Z",
        "horizontal_angle": 1.55,
        "id": 203,
        "side": 2.79,
        "speed": 22.71,
        "time": 4.76,
        "updated_at": "2013-07-09T19:01:43Z",
        "vertical_angle": 49.72,
        "x": 87.83,
        "y": 0.0,
        "z": 2.79
    }
	*/

	var xdiff = landing.x - 137.16; // 150 yards in meters
	var zdiff = landing.z - 0;

	var distance = Math.sqrt((xdiff * xdiff) + (zdiff * zdiff));

	var carryYds = landing.x * 1.0936;
	var offlineYds = landing.z * 1.0936;
	var distanceYds = distance * 1.0936;

	if (landing) {
		var message = "You shot a distance of " 
			+ Math.round(carryYds) + " yds and were off-line by " + Math.round(offlineYds) 
			+ " yds. Total distance from hole: " + Math.round(distanceYds) + " yards";
		document.getElementById("launchData").innerHTML = message;
		stopLaunchDataTimer();
	}
}

function doGetRequest(url, closure)
{
	// this function get call then call closure with JSON parsed response text 
	// include all params on query string

	var request = new XMLHttpRequest();
	request.open("GET", url);

	request.onload = function() {
		
		if (request.status == 200) {
			console.log("RESPONSE: " + url + ": " + request.responseText);

			if (closure)
			{
				closure(JSON.parse(request.responseText));
			}
			
		} else {
			alert(request.status + " " + request.statusText);
		}

	}

	request.onerror = function() {
		alert(request.status + " " + request.statusText);
	}

	request.send(null);

}




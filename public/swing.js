var user_id = -1;
var user_name = "";
var user_email = "";

window.onload = function ()
{
	//startWeatherTimer();
	//startLiveXYZTimer();
	startCountdownTimer(120, countdownCallback);  // DO NOT COMMENT OUT THIS LINE!
	user_id = sessionStorage.getItem("user_id");
	user_name = sessionStorage.getItem("user_name");
	user_email = sessionStorage.getItem("user_email");
	paintGraphs();
}

var count = 0;
var timerID = 0;
var launchDataTimerID = 0;

var isSwinging = false;
var doingBackswing = false;
var doingDownswing = false;
var power = 0;
var direction = 0;
var clubTranslation = "translate(100px, 100px)";
var weatherTranslation = "translate(69px, 49px)";
var weatherCount = 0;
var liveXYZCount = 0;
var lastCommandObj = null;
var getRandomWeather = false;
var getRandomLiveXYZData = false;


function startSwing()
{
	if (isSwinging)
	{
		return;
	}
	
	isSwinging = true;
	doingBackswing = true;

	var rotateString = "rotate(260deg)";		
	document.getElementById("divPointer").style.MozTransform = clubTranslation + " " + rotateString;		
	document.getElementById("divPointer").style.WebkitTransform = clubTranslation + " " + rotateString;	

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
	document.getElementById("divPointer").style.MozTransform = clubTranslation + " " + rotateString;		
	document.getElementById("divPointer").style.WebkitTransform = clubTranslation + " " + rotateString;	

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
	
	stopCountdownTimer();
	sendCommandToServer();
	
}


function processButtonClick()
{
	if (!isSwinging)
	{
		document.getElementById("swingButton").innerHTML = "Top";
		startSwing();
	} else if (doingBackswing) {
		document.getElementById("swingButton").innerHTML = "Impact";
		registerPower();
	} else if (doingDownswing) {
		document.getElementById("swingButton").innerHTML = "Swing";
		registerDirection();
	}
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

	document.getElementById("debug").innerHTML = "pwr: " + power + ", dir: " + direction;

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
	if (getRandomWeather)
	{
		url += "?random=1";
	}
	doGetRequest(url, onGotWeather);
}

function onGotWeather(response)
{
	weatherCount++;
	//var stringResponse = (JSON.stringify(response, null, 4);
	//document.getElementById("weather").innerHTML = stringResponse ;

	var weatherObj = response.data;
	var message = weatherCount 
		+ " -> Speed: " + weatherObj.wind_speed 
		+ ", Direction: " + weatherObj.wind_direction;

	if (getRandomWeather)
	{
		message += " RANDOM";
	}

	document.getElementById("weather").innerHTML = message;

	document.getElementById("divWindSpeed").innerHTML = weatherObj.wind_speed + "mph";

	var rotateString = "rotate(" + (weatherObj.wind_direction - 180) + "deg)";
	document.getElementById("divWeatherPointer").style.MozTransform = weatherTranslation + " " + rotateString;
	document.getElementById("divWeatherPointer").style.WebkitTransform = weatherTranslation + " " + rotateString;

	//document.getElementById("weather").innerHTML = weatherCount + " -> " + request.responseText;
}

function onGetLiveXYZDAta()
{
	getLiveXYZData();
}

function getLiveXYZData()
{
	var url = "api/get_live_xyz";
	if (getRandomLiveXYZData)
	{
		url += "?random=1";
	}
	doGetRequest(url, onGotLiveXYZData);
}

function onGotLiveXYZData(response)
{
	liveXYZCount++;

	var xyzObj = response.data;
	var message = liveXYZCount 
		+ " -> x: " + xyzObj.x 
		+ ", y: " + xyzObj.y 
		+ ", z: " + xyzObj.z;

	if (getRandomLiveXYZData)
	{
		message += " RANDOM";
	}

	document.getElementById("liveXYZData").innerHTML = message;
	addXYZtoGraphs(xyzObj);
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
	
	document.getElementById("debug").innerHTML = "";
	var rotateString = "rotate(" + (0 - count) + "deg)";
	document.getElementById("divPointer").style.MozTransform = clubTranslation + " " + rotateString;
	document.getElementById("divPointer").style.WebkitTransform = clubTranslation + " " + rotateString;
}

function startWeatherTimer()
{
	getWeather();
	weatherTimerID = setInterval ("onWeatherTimer()", 2000);
}

function onWeatherTimer()
{
	// grab weather
	getWeather();
}

		
function startLiveXYZTimer()
{
	getLiveXYZData();
	liveXYZTimerID = setInterval ("onLiveXYZTimer()", 100);
}

function onLiveXYZTimer()
{
	// grab live xyz
	getLiveXYZData();
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

	if (!commandItem)
	{
		return;
	}

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
		var distanceYds = calculateDistanceInYards (landing, 150);
		sendResultToServer(user_id, shot.id, distanceYds);
	}
}

function countdownCallback()
{
	redirectTo("report.html?status=toolong");
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

function sendResultToServer(user_id, shot_id, distanceYds)
{
	var objToSend = {};
 	objToSend.user_id = user_id;
 	objToSend.shot_id = shot_id;
 	objToSend.distance_from_hole = distanceYds;

 	$.ajax({
	  type: "POST",
	  url: "result_items.json",
	  data: { result_item:objToSend}
	}).done(function( msg ) {
	  //alert( "Data Saved: " + JSON.stringify(msg) );
	  sendEmail(user_name, user_email, shot_id);
	});
}

var baseUrl = "https://mandrillapp.com/api/1.0/";

function sendEmail (userName, userEmail, shotID)
{
	goToReportPage(shotID);
	return;
	
	var o = {};
 	o.key = "p5FiV5GwZNPZrb1l-vE6vA";
 	o.message = {};
 	o.message.html = "<b>Hello! <a href=\"http://golflabs.chucklebug.com/report.html?shot_id=" + shotID + "\">Here is your Golf Labs Hole in One Challenge Shot</a></b>";
 	o.message.text = "";
 	o.message.subject = "Golf Labs Hole In One Challenge Report";
 	o.message.from_email = "paul@chucklebug.com";
 	o.message.from_name = "Golf Labs";
 	o.message.to = [{email:userEmail, name:userName}];
 	
	/* Send the data using post */
	var posting = $.post( baseUrl + "/messages/send.json", o );
 
  	/* Put the results in a div */
  	posting.done(function( msg ) {
    	$("#debug").html(JSON.stringify(msg));
    	goToReportPage(shotID);
  	});

  	/* Put the error in a div */
  	posting.fail(function(error) {
    	$("#debug").html("FAIL: " + JSON.stringify(error));
    	goToReportPage(shotID);
  	});

}

var canvas;
var context;
var canvasTop;
var contextTop;
var yOffset = 110;
var scalar = 1.8;
var sideOffset = 60;
var width = 300;


function paintGraphs()
{
	last_x = 0;
	last_y = 0;
	last_z = 0;

	canvas = document.getElementById("ballFlightSide");
	if (!canvas)
	{
		alert("Didn't get canvas");
		return;
	}

	context = canvas.getContext("2d");
	if (!context)
	{
		alert("Didn't get context");
		return;
	}

	canvasTop = document.getElementById("ballFlightTop");
	if (!canvasTop)
	{
		alert("Didn't get canvasTop");
		return;
	}

	contextTop = canvasTop.getContext("2d");
	if (!contextTop)
	{
		alert("Didn't get contextTop");
		return;
	}

	context.fillStyle = "black";
	contextTop.fillStyle = "white";

	// Sky
	context.fillStyle = "white"; // #1E90FF";
	context.fillRect(0, 0, width, yOffset);

	context.fillStyle = "#cccccc";

	// Horizontal Lines
	// ground line
	context.fillRect(0, yOffset, width, 1);
	context.fillRect(0, yOffset - scalar * 15, width, 1);
	context.fillRect(0, yOffset - scalar * 30, width, 1);
	context.fillRect(0, yOffset - scalar * 45, width, 1);

	// Vertical Lines
	context.fillRect(0 + scalar * 50, 0, 1, yOffset);
	context.fillRect(0 + scalar * 100, 0, 1, yOffset);
	context.fillRect(0 + scalar * 150, 0, 1, yOffset);

	// Hole
	drawEllipseByCenter(context, scalar * 150, yOffset + 4, 12, 6, "#ccc", false);
	
	// Flag
	// var flag = new Image();
	// flag.src = "images/golf-flag-sm.png";
	// flag.onload = function(){
	// 	//alert("flag loaded");
	// 	context.drawImage(flag, scalar * 150 - 3, yOffset - 95, 33, 100);
	// }
	
	// Top view target line
	contextTop.fillStyle = "#cccccc";
	contextTop.fillRect(0, sideOffset, width, 1);

	// Top view green
	drawCircle(contextTop, scalar * 150, sideOffset, 15 * scalar, "#ccc", false);
	drawCircle(contextTop, scalar * 150, sideOffset, 10 * scalar, "#ccc", false);
	drawCircle(contextTop, scalar * 150, sideOffset, 5 * scalar, "ccc", false);

	drawCircle(contextTop, 0, sideOffset, scalar * 25, "#ccc", false);
	drawCircle(contextTop, 0, sideOffset, scalar * 50, "#ccc", false);
	drawCircle(contextTop, 0, sideOffset, scalar * 75, "#ccc", false);
	drawCircle(contextTop, 0, sideOffset, scalar * 100, "#ccc", false);
	drawCircle(contextTop, 0, sideOffset, scalar * 125, "#ccc", false);
	drawCircle(contextTop, 0, sideOffset, scalar * 150, "#ccc", false);
	

}


var last_x;
var last_y;
var last_z;


function addXYZtoGraphs(position)
{
	
	if (!context)
	{
		alert("Didn't get context");
		return;
	}

	if (!contextTop)
	{
		alert("Didn't get contextTop");
		return;
	}

	var x = metersToYards(position.x);
	var y = metersToYards(position.y);
	var z = metersToYards(position.z);

	if (x == 0)
	{
		return;
	}
	
	// context.beginPath();
	// context.arc(scalar * x, yOffset - scalar * y, 1, 0, 2 * Math.PI, true);
	// context.fillStyle = "#666666";
	// context.fill();

	// contextTop.beginPath();
	// contextTop.arc(scalar * x, sideOffset + scalar * z, 1, 0, 2 * Math.PI, true);
	// contextTop.fillStyle = "#666666";
	// contextTop.fill();

	context.strokeStyle = "#000";
	context.beginPath();
	context.moveTo(scalar * last_x, yOffset - scalar * last_y);
	context.lineTo(scalar * x, yOffset - scalar * y);
	context.stroke();

	contextTop.strokeStyle = "#000";
	contextTop.beginPath();
	contextTop.moveTo(scalar * last_x, sideOffset + scalar * last_z);
	contextTop.lineTo(scalar * x, sideOffset + scalar * z);
	contextTop.stroke();

	last_x = x;
	last_y = y;
	last_z = z;
}





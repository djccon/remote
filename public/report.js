window.onload = function()
{
	var status = getParameterByName("status")
	if (status == "toolong") {
		document.getElementById("results").innerHTML = "Sorry, you took too long to take your shot";
		return;
	}

	var shotID = sessionStorage.getItem("shotID");
	if (!shotID)
	{
		shotID = getParameterByName("shot_id");
		if (!shotID)
		{
			document.getElementById("results").innerHTML = "ShotID not good";
			return;
		}
	}

	var url = "shots/" + shotID + ".json";
	doGetRequest(url, onGotShot);

	document.getElementById("results").innerHTML = "Shot ID = " + shotID;

	showLeaderboard();
	paintGraphs();
}

function onGoToIntro()
{
	redirectTo("welcome.html");
}

function onGotShot(response)
{
	//document.getElementById("results").innerHTML = JSON.stringify(response, null, 4);
	//return;

	var shot = response.shot;
	var landings = response.ball_landings;
	var landing;
	var launches = response.launches;
	var launch;
	var weathers = response.weathers;
	var weather;
	var ballFlights = response.ball_flights;
	var ballFlight;

	if (landings) {
		landing = landings[2];
	}

	if (launches)
	{
		launch = launches[0];
	}

	if (weathers)
	{
		weather = weathers[0];
		console.log("weather ok ");
	}

	if (ballFlights)
	{
		console.log("ballFlights ok");
		ballFlight = ballFlights[0];
		if (ballFlight) {
			console.log("ballFlight ok");
		}
	}

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

	if (landing) {
		var distanceYds = calculateDistanceInYards(landing, 150);
		addValueToPage("distanceToHole", "", distanceYds, " YARDS");
		addLaunchDataToPage(launch, landing);
		addWeatherToPage(weather);
		addBallFlightToPage(ballFlight);
		var message = "Total distance from hole: " + Math.round(distanceYds) + " yards";
		// show actual response JSON
		//document.getElementById("results").innerHTML = message + "\n\n" + JSON.stringify(response, null, 4);
	}
}

function addValueToPage(id, label, distanceYds, units)
{
	var div = document.getElementById(id);
	if (div)
	{
	  	// var p = document.createElement("p");
	  	// p.innerHTML = label + Math.round(distanceYds) + units;
	  	// div.appendChild(p);

	  	// create two divs
	  	// <div class="param-title">WIND SPEED</div><div class="param-value">12 MPH</div>

	  	/// NEEDS CLASS NAMES!

	  	var labelDiv = document.createElement("div");

	  	labelDiv.innerHTML = label;
	  	labelDiv.className = "param-title";
	  	div.appendChild(labelDiv);

	  	var valueDiv = document.createElement("div");
	  	valueDiv.innerHTML = "" + Math.round(distanceYds) + units;;
	  	valueDiv.className = "param-value";
	  	div.appendChild(valueDiv);
	}
}

function addStringToPage(id, label, str, units)
{
	var div = document.getElementById(id);
	if (div)
	{
	  	var p = document.createElement("p");
	  	p.innerHTML = label + str + units;
	  	div.appendChild(p);
	}
}

function addLaunchDataToPage(launch, landing)
{
	if (launch)
	{
		var distanceYds = calculateDistanceInYards(landing, 150);
		addValueToPage("launchData", "DISTANCE FROM HOLE", distanceYds, " YARDS");
		addValueToPage("launchData", "TOTAL DISTANCE", 150 - distanceYds, " YARDS");

		addValueToPage("launchData", "CLUB SPEED", Math.round(mpsToMph(launch.club_speed)), " mph");
		addValueToPage("launchData", "BALL SPEED", Math.round(mpsToMph(launch.ball_speed)), " mph");
		addValueToPage("launchData", "LAUNCH ANGLE", Math.round(launch.ball_vertical_angle), " degrees");
		addValueToPage("launchData", "BACK SPIN", Math.round(launch.spin_rate), " rpm");
	}
}


function addWeatherToPage(launch)
{
	if (launch)
	{
		//document.getElementById("results").innerHTML = JSON.stringify(weather, null, 4);
		addValueToPage("weather", "WIND SPEED", Math.round(launch.wind_speed), " mph");
		addValueToPage("weather", "WIND DIRECTION", Math.round(launch.wind_direction), " degrees");
	}
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





function addBallFlightToPage(ballFlight)
{
	var ballPositions = JSON.parse(ballFlight.positions);
	var position; 
	
	if (ballPositions)
	{
		var canvas = document.getElementById("ballFlightSide");
		if (!canvas)
		{
			alert("Didn't get canvas");
			return;
		}

		var context = canvas.getContext("2d");
		if (!context)
		{
			alert("Didn't get context");
			return;
		}

		var canvasTop = document.getElementById("ballFlightTop");
		if (!canvasTop)
		{
			alert("Didn't get canvasTop");
			return;
		}

		var contextTop = canvasTop.getContext("2d");
		if (!contextTop)
		{
			alert("Didn't get contextTop");
			return;
		}

		for (var i = 0; i < ballPositions.length; i++)
		{
			position = ballPositions[i];
			addXYZtoGraphs(position);
		}
		
	}
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







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
		addLaunchDataToPage(launch);
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
	  	var p = document.createElement("p");
	  	p.innerHTML = label + Math.round(distanceYds) + units;
	  	div.appendChild(p);
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

function addLaunchDataToPage(launch)
{
	if (launch)
	{
		//document.getElementById("results").innerHTML = JSON.stringify(launch, null, 4);
		addValueToPage("launchData", "Club Speed: ", Math.round(mpsToMph(launch.club_speed)), " mph");
		addValueToPage("launchData", "Ball Speed: ", Math.round(mpsToMph(launch.ball_speed)), " mph");
		addValueToPage("launchData", "Launch Angle: ", Math.round(launch.ball_vertical_angle), " degrees");
		addValueToPage("launchData", "Back Spin: ", Math.round(launch.spin_rate), " rpm");
	}
}


function addWeatherToPage(launch)
{
	if (launch)
	{
		//document.getElementById("results").innerHTML = JSON.stringify(weather, null, 4);
		addValueToPage("weather", "Wind Speed: ", Math.round(launch.wind_speed), " mph");
		addValueToPage("weather", "Wind Direction: ", Math.round(launch.wind_direction), " degrees");
	}
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

		context.fillStyle = "black";
		contextTop.fillStyle = "white";

		var yOffset = 110;
		var scalar = 2.3;
		var sideOffset = 60;

		// Sky
		context.fillStyle = "#1E90FF";
		context.fillRect(0, 0, 500, yOffset);

		//context.fillStyle = "black";
		//context.fillRect(scalar * 150 - 5, yOffset, 10, 10);

		// Hole
		drawEllipseByCenter(context, scalar * 150, yOffset + 4, 12, 6, "black", true);
		
		// Flag
		var flag = new Image();
		flag.src = "images/golf-flag-sm.png";
		flag.onload = function(){
			//alert("flag loaded");
			context.drawImage(flag, scalar * 150 - 3, yOffset - 95, 33, 100);
		}
		
		// Top view target line
		contextTop.fillStyle = "#00cc00";
		contextTop.fillRect(0, sideOffset, 500, 1);

		// Top view green
		drawCircle(contextTop, scalar * 150, sideOffset, 35, "#009900", true);
		drawCircle(contextTop, scalar * 150, sideOffset, 25, "#00cc00", true);
		drawCircle(contextTop, scalar * 150, sideOffset, 5, "black", true);

		drawCircle(contextTop, 0, sideOffset, scalar * 25, "#00cc00", false);
		drawCircle(contextTop, 0, sideOffset, scalar * 50, "#00cc00", false);
		drawCircle(contextTop, 0, sideOffset, scalar * 75, "#00cc00", false);
		drawCircle(contextTop, 0, sideOffset, scalar * 100, "#00cc00", false);
		drawCircle(contextTop, 0, sideOffset, scalar * 125, "#00cc00", false);
		drawCircle(contextTop, 0, sideOffset, scalar * 150, "#00cc00", false);
		
		contextTop.fillStyle = "white";

		for (var i = 0; i < ballPositions.length; i++)
		{
			position = ballPositions[i];

			var x = metersToYards(position.x);
			var y = metersToYards(position.y);
			var z = metersToYards(position.z);

			
			context.beginPath();
			context.arc(scalar * x, yOffset - scalar * y, 3, 0, 2 * Math.PI, true);
			context.fillStyle = "white";
			context.fill();

			//context.fillRect(scalar * position.x - 1, yOffset - scalar * position.y - 1, 3, 3);
			//contextTop.fillRect(scalar * position.x - 1, sideOffset + scalar * position.z - 1, 3, 3);
			//addStringToPage("ballFlight", "x,y,z: ", Math.round(position.x) + "," + Math.round(position.y) + "," + Math.round(position.z), "");

			contextTop.beginPath();
			contextTop.arc(scalar * x, sideOffset + scalar * z, 3, 0, 2 * Math.PI, true);
			contextTop.fillStyle = "white";
			contextTop.fill();

		}
		
	}
}



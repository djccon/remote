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
		var message = "Total distance from hole: " + Math.round(distanceYds) + " yards";
		document.getElementById("results").innerHTML = message + "\n\n" + JSON.stringify(response, null, 4);
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

function addLaunchDataToPage(launch)
{
	if (launch)
	{
		//document.getElementById("results").innerHTML = JSON.stringify(launch, null, 4);
		addValueToPage("launchData", "Club Speed: ", Math.round(mpsToMph(launch.club_speed)), " mph");
		addValueToPage("launchData", "Ball Speed: ", Math.round(mpsToMph(launch.ball_speed)), " mph");
		addValueToPage("launchData", "Launch Angle: ", Math.round(launch.ball_vertical_angle), " degrees");
		addValueToPage("launchData", "Back Spin: ", Math.round(rpsToRpm(launch.spin_rate)), " rpm");
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



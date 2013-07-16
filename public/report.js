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

	if (landings) {
		landing = landings[2];
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

	var distanceYds = calculateDistanceInYards(landing, 150);

	if (landing) {
		var message = "Total distance from hole: " + Math.round(distanceYds) + " yards";
		document.getElementById("results").innerHTML = message + "\n\n" + JSON.stringify(response, null, 4);
	}
}


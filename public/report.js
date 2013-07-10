window.onload = function()
{
	var shotID = sessionStorage.getItem("shotID");
	if (!shotID)
	{
		shotID = 136;
	}
	var url = "shots/" + shotID + ".json";
	doGetRequest(url, onGotShot);

	document.getElementById("results").innerHTML = "Shot ID = " + shotID;
}

function onGoToIntro()
{
	redirectTo("intro.html");
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
		document.getElementById("results").innerHTML = message;
		goToReportPage(shot.id);
		
	}
}


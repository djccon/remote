

function redirectTo(sUrl) 
{
	window.location = sUrl + "?rand=" + Math.random();
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

function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

var timeleft = 30;
var countdownCallback = null;

function startCountdownTimer(seconds, callback)
{
	timeleft = seconds;
	countdownCallback = callback;
	// Set this after sending a command
	countdownTimerID = setInterval ("onCountdownTimer()", 1000);
}

function stopCountdownTimer()
{
	// Set this after sending a command
	clearTimeout(countdownTimerID);
}

function onCountdownTimer()
{
	timeleft--;
	updateCountdownDisplay(timeleft);
	if (timeleft == 0)
	{
		stopCountdownTimer();
		if (countdownCallback) {
			countdownCallback();
		}
	}
}

 function showLeaderboard()
 {
 	//alert("about to get leader board");
 	$.ajax({
	  type: "GET",
	  url: "api/get_leaderboard.json",
	}).done(function(msg) {
	  
	  // $("#debug").html("Item: " + JSON.stringify(msg));
	  var items = msg.data;

	  var ul = document.getElementById("leaderlist");
	  for (var i = 0; i < items.length; i++)
	  {
	  	var resultItem = items[i];
	  	var li = document.createElement("li");
	  	li.innerHTML = Math.round(resultItem.distance_from_hole) + " Yards (" + resultItem.name + ")";
	  	ul.appendChild(li);
	  }
	});
 }



function updateCountdownDisplay(timeleft)
{
	document.getElementById("countdownTimer").innerHTML = "Time left: " + timeleft;	
}

function calculateDistanceInYards (landing, goalYds)
{
	var xdiff = landing.x - yardsToMeters(goalYds); // convert to meters for calcs.
	var zdiff = landing.z - 0;

	var distance = Math.sqrt((xdiff * xdiff) + (zdiff * zdiff));

	// convert answer to yards
	var distanceYds = metersToYards(distance);

	return distanceYds;
}

function metersToYards(m)
{
	return m * 1.0936;
}

function yardsToMeters(y)
{
	return y / 1.0936;
}

function mpsToMph(mps)
{
	return 2.23693629 * mps;
}

function mphToMps(mph)
{
	return 0.44704 * mph;
}

function rpmToRps(rpm)
{
    // RPM to Radians per second
    return rpm * Math.PI / 30;
}

function rpsToRpm(rps)
{
    // radians per second to RPM
    return rps * 30 / Math.PI;
}



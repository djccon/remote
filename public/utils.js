var baseUrl = "https://mandrillapp.com/api/1.0/";


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
 	$.ajax({
	  type: "GET",
	  url: "api/get_leaderboard.json",
	}).done(function(msg) {
	  
	  // $("#debug").html("Item: " + JSON.stringify(msg));
	  var items = msg.data;

	  var ul = document.getElementById("leaderboard");
	  for (var i = 0; i < items.length; i++)
	  {
	  	var resultItem = items[i];
	  	var li = document.createElement("li");
	  	li.innerHTML = Math.round(resultItem.distance_from_hole) + " Yards (" + resultItem.name + ")";
	  	ul.appendChild(li);
	  }
	});
 }




function sendEmail (userName, userEmail, shotID)
{
	var o = {};
 	o.key = "p5FiV5GwZNPZrb1l-vE6vA";
 	o.message = {};
 	o.message.html = "<b>Hello! <a href=\"http://immense-waters-5709.herokuapp.com/report.html?shot_id=" + shotID + "\">Here is your Golf Labs Hole in One Challenge Shot</a></b>";
 	o.message.text = "";
 	o.message.subject = "Testing from HTML";
 	o.message.from_email = "paul@chucklebug.com";
 	o.message.from_name = "Golf Labs";
 	o.message.to = [{email:userEmail, name:userName}];
 	
	/* Send the data using post */
	var posting = $.post( baseUrl + "/messages/send.json", o );
 
  	/* Put the results in a div */
  	posting.done(function( msg ) {
    	$("#debug").html(JSON.stringify(msg));
  	});

  	/* Put the error in a div */
  	posting.fail(function(error) {
    	$("#debug").html("FAIL: " + JSON.stringify(error));
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


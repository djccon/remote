function redirectTo(sUrl) 
{
	window.location = sUrl
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

function updateCountdownDisplay(timeleft)
{
	document.getElementById("countdownTimer").innerHTML = "Time left: " + timeleft;	
}




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

	  // <li class="leader-list-item"><span class="leader_item_title" >LEADERS</span><span class="leader_item_right">BEST</span></li>
	  var ul = document.getElementById("leaderlist");
	  var max = items.length;
	  if (max > 10) max = 10;

	  for (var i = 0; i < max; i++)
	  {
	  	var resultItem = items[i];
	  	var li = document.createElement("li");
	  	li.className = "leader-list-item";

	  	var leftSpan = document.createElement("li");
	  	leftSpan.className = "leader_item_left";
	  	leftSpan.innerHTML = resultItem.name;

	  	var rightSpan = document.createElement("li");
	  	rightSpan.className = "leader_item_right";
	  	rightSpan.innerHTML = Math.round(resultItem.distance_from_hole) + " Yards";

	  	//li.innerHTML = Math.round(resultItem.distance_from_hole) + " Yards (" + resultItem.name + ")";
	  	li.appendChild(leftSpan);
	  	li.appendChild(rightSpan);
	  	ul.appendChild(li);
	  }
	});
 }



function updateCountdownDisplay(timeleft)
{
	document.getElementById("countdownTimer").innerHTML = "" + timeleft + " SECONDS";	
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

function drawEllipseByCenter(ctx, cx, cy, w, h, color, fill) {
  drawEllipse(ctx, cx - w/2.0, cy - h/2.0, w, h, color, fill);
}

function drawEllipse(ctx, x, y, w, h, color, fill) {
  var kappa = .5522848,
      ox = (w / 2) * kappa, // control point offset horizontal
      oy = (h / 2) * kappa, // control point offset vertical
      xe = x + w,           // x-end
      ye = y + h,           // y-end
      xm = x + w / 2,       // x-middle
      ym = y + h / 2;       // y-middle



  ctx.beginPath();
  ctx.moveTo(x, ym);
  ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);
  ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
  ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
  ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);
  ctx.closePath();
  
  if (fill)
  {
  	ctx.fillStyle = color;
  	ctx.fill();
  } else {
  	ctx.strokeStyle = color;
	ctx.stroke();
  }
}


function drawCircle(context, x, y, radius, color, fill)
{
	context.beginPath();
	context.arc(x, y, radius, 0, 2 * Math.PI, true);
	
	if (fill)
	{
		context.fillStyle = color;
		context.fill();
	} else {
		context.strokeStyle = color;
		context.stroke();
	}
}




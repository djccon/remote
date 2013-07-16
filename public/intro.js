
window.onload = function () 
{
	startCountdownTimer(30, countdownCallback);
	var user_id = sessionStorage.getItem("user_id");
}


var count = 0;
var timerID = 0;

var isSwinging = false;
var doingBackswing = false;
var doingDownswing = false;
var power = 0;
var direction = 0;
var clubTranslation = "translate(60px, 50px)";

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
	
	document.getElementById("feedback").innerHTML = "Power: " + power + " Direction: " + direction;
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
	
	document.getElementById("feedback").innerHTML = "";
	var rotateString = "rotate(0deg)";
	document.getElementById("divPointer").style.MozTransform = clubTranslation + " " + rotateString;
	document.getElementById("divPointer").style.WebkitTransform = clubTranslation + " " + rotateString;
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

function countdownCallback()
{
	onGoNext();
}

function onGoNext()
{
	redirectTo("swing.html");
}

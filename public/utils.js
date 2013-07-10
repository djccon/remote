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


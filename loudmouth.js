// Make sure the developer knows that there is a JS error

var Loudmouth = (function(my){
	var logger, complaints = [], original_window_onerror = window.onerror, config = {}, original_alert = window.alert;

	my.logger = window.console ? function(){window.console.log.apply(window.console, arguments)} : function(){};

	my.complainLoudly = function(){
		if (complaints.length > 0) {

			var complaints_str = 'There was a JavaScript exception';
			if (complaints.length > 1) complaints_str = 'There were ' + complaints.length + ' JavaScript exceptions';
			complaints_str += " when the page was loading:\n";

			var error, complaint;
			while ( (complaint = complaints.pop()) != null){
				complaints_str += "\n-------------------";
				for ( var p in complaint){
					if (complaint.hasOwnProperty(p)) complaints_str += "\n" + p + " : " + complaint[p];
				}
			};
  		complaints_str += "\n-------------------\n\n";

	  	alert(complaints_str);
		} else {
			Loudmouth.logger("This loudmouth has nothing to complain about, kthxbye!");
		};

		return this;
	};

	my.complainSilently = function(){
		var complaint;
		while( (complaint = complaints.pop()) != null){
			Loudmouth.hollaback(complaint);
		};
	};

	// Report errors back to the server
	my.hollaback = function(error_info) {
		error_info.href = window.location.href;
		if ( Loudmouth.hollaback_url() ) {
			var image_str = "<img src='" + Loudmouth.hollaback_url() + '?error_info=' + JSON.stringify(error_info) + "'>";
			$(document).append(image_str);
		} else {
			Loudmouth.logger("Warning: Loudmouth.js captured a complaint, but the hollaback server URL is not defined, so I'm telling you about the problem: ");
			Loudmouth.logger(error_info);
		};
	};
	
	// URL for reporting errors
	my.hollaback_url = function(target_url){
		if (target_url) config.hollaback_url = target_url;
		return config.hollaback_url;
	};

  my.addError = function(errorMessage, url, lineNumber){
    errorMessage = errorMessage.replace(/"/g, "\\\"");
    addComplaint('error', {errorMessage: errorMessage, url: url, lineNumber: lineNumber});
  };

	var addComplaint = function(type, error_info){
		error_info.type = type;
		complaints.push(error_info);
	};

	my.captureAlerts = function(){
		Loudmouth.logger("Loudmouth will capture all window.alert calls");
		window.alert = function() {
			addComplaint('alert', {alert_message: arguments[0]});
			Loudmouth.logger("Loudmouth saw this alert: " + arguments[0]);
			return original_alert.apply(this, arguments);
		};
		return this;  // Enable chaining
	};

	// Complain right away
	my.watch = function(){
		setOnError(Loudmouth.complainLoudly);
		return this;  // Enable chaining
	};

	// Keep track of all complaints quietly
	my.lurk = function(){
		setOnError(Loudmouth.complainSilently);

		if ( ! Loudmouth.hollaback_url() ) {
			Loudmouth.logger("Warning: The hollaback server URL is not defined, so errors will not be reported back to the server. Use Loudmouth.hollaback_url(<your url>) to tell Loudmouth where to shout.");
		}
		return this;  // Enable chaining
	};

	var setOnError = function(complain_fn){
		var original_onerror_fn = window.onerror;

		var new_onerror_fn = function(errorMessage, url, lineNumber){
			Loudmouth.addError(errorMessage, url, lineNumber);
			complain_fn();
			return original_onerror_fn ? original_onerror_fn.call(errorMessage, url, lineNumber) : original_onerror;
		};

		window.onerror = new_onerror_fn;
	};

	// Stop watching
	my.goAway = function(){
		window.onerror = original_window_onerror;
		return this;  // Enable chaining
	};

	return my;

})(Loudmouth || {});
	

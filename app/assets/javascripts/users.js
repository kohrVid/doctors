$(document).ready(function() {
	$("#approve_all").show();
	$("#lock_all").show();
	/*
	$("#unapproved_users").change(function() {
		if (this.selectedIndex!==0) {
			window.location.href = this.value;
		}        
	});
	$("#unapproved_patients").change(function() {
		if (this.selectedIndex!==0) {
			window.location.href = this.value;
		}        
	});*/
});


$("#approve_all").change(function() {
	if(this.checked) 	{
		$("input[name*=approved]").prop("checked", true);
	} else {
		$("input[name*=approved]").prop("checked", false);
	}
});

$("#lock_all").change(function() {
	if(this.checked) 	{
		$("input[name*=locked]").prop("checked", true);
	} else {
		$("input[name*=approved]").prop("checked", false);
	}
});

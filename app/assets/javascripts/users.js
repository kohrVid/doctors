$(document).ready(function() {
	$("#approve_all").show();
	$("#lock_all").show();
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

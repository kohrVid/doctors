$(document).ready ->
#WYSIHTML5
  $("#wysihtml5-textarea").each = (i, elem) ->
    $(elem).wysihtml5()

#Individual User Approval
  $("#Users_unapproved").change ->
    window.location = $(this).val()
  $("#Patients_unapproved").change ->
    window.location = $(this).val()

#Appointments form
  $("#appointment_start_time_3i").change ->
    day = $("#appointment_start_time_3i").val()
    $("#appointment_end_time_3i").val(day)

  $("#appointment_start_time_2i").change ->
    month = $("#appointment_start_time_2i").val()
    $("#appointment_end_time_2i").val(month)

  $("#appointment_start_time_1i").change ->
    year = $("#appointment_start_time_1i").val()
    $("#appointment_end_time_1i").val(year)



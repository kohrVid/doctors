$(document).ready ->
#  $(".hidden").hide()
  $("#wysihtml5-textarea").each = (i, elem) ->
    $(elem).wysihtml5()

  $("#Users_unapproved").change ->
    window.location = $(this).val()
  $("#Patients_unapproved").change ->
    window.location = $(this).val()


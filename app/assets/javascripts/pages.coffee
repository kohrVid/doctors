$(document).ready ->
#  $(".hidden").hide()
  $("#wysihtml5-textarea").each = (i, elem) ->
    $(elem).wysihtml5()

  $("#unapproved_users").change ->
    window.location = $(this).val()


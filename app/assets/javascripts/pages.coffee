$(document).ready ->
  $(".hidden").hide()
  $("#wysihtml5-textarea").each = (i, elem) ->
    $(elem).wysihtml5()

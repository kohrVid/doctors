// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require owl.carousel
//= require wysihtml
//= require wysihtml-toolbar
//= require parser_rules/advanced_unwrap
//= require_tree .
$(function() {
  $(document).foundation();
});
/*
$(function(){
	$('#unapproved').bind('change', function () {
		var url = "/users/" + $(this).val()
		if (url) {
			window.location.replace(url);
		}
		return false;
	});
});
*/
/*
var wysihtml5ParserRules = {
  "type_definitions": {
      "text_color_object": {
        "styles": {
          "color": true
        }
      },
  },
  
  tags: {
    "span": {
        "one_of_type": {
            "text_color_object": 1
        },
        "keep_styles": {
            "color": 1
        },
        "remove_action": "unwrap"
    }
  }
};
*/
   var editor = new wysihtml5.Editor("wysihtml5-textarea", { // id of textarea element
      toolbar:      "wysihtml5-toolbar", // id of toolbar element
      stylesheets:  "<%= stylesheet_path('wysihtml') %>", // optional, css to style the editor's content
      parserRules:  wysihtml5ParserRules, // defined in parser rules set
      //showToolbarAfterInit: false
	"events": {
	      "color": function() { 
	         $('wysihtml5-textarea').trigger('change');
      		}
   	}
   });


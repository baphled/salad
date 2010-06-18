$(document).ready(function () {
  $("form.project").validate({
    highlight: function(element, errorClass) {
     $(element).fadeOut(function() {
       $(element).fadeIn();
       $(element).addClass(errorClass);
     });
    },
    unhighlight: function(element, errorClass) {
      var $parent = $(element).parent();
      $parent.find('span.error').hide();
    },
    successClass: 'valid',
    errorClass: 'error ui-state-error',
    errorElement: "span",
    errorPlacement: function(error, element) {
      var $warningSpan = $('<span></span')
                        .css({'float': 'left', 'margin': '0.3em'})
                        .addClass('ui-icon ui-icon-alert'),
          $parent = element.parent(),
          $previousError = $parent.find('span.error');

      if ($previousError.html() == null) {
        error
          .wrap("<span class='ui-state-error ui-corner-all'></span>")
          .insertAfter(element)
          .prepend($warningSpan);
      } else {
        $previousError.show();
      }
    },
    rules: {
      "project[title]": {required: true, minlength: 3,
        remote: {
          url: "/projects/validate.json",
          type: "get",
          data: {
            "title": function() {
              return $('#project_title').val();
            }
          }
        }
      },
      
      "project[description]": {required: true, minlength: 12},
      "project[aim]": {required: true, minlength: 6},
      
      "project[location]": {
        remote: {
          url: "/projects/valid_directory.json",
          type: "get",
          data: {
            "location": function() {
              return $('#project_location').val();
            }
          }
        }
      }
    }
  });

});
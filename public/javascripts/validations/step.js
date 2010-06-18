$(document).ready(function () {
  $('form.step').validate({
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
      "step[title]": {
        required: true,
        minlength: 12,
        
        remote: {
          url: "/steps/validate_prefix.json",
          type: "get",
          data: {
            "title": function() {
              return $('#step_title').val();
            }
          }
        }
      }
    }
  });
});
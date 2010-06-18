$(document).ready(function () {
  $('form.story').validate({
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
      "story[scenario]": {required: true, minlength: 7,
        remote: {
          url: "/stories/validate.json",
          type: "get",
          data: {
            "scenario": function() {
              return $('#story_scenario').val();
            }
          }
        }
      }
    }
  });
});
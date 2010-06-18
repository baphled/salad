$(document).ready(function () {
  $('form.feature').validate({
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
      "feature[title]": {required: true, minlength: 7,
        remote: {
          url: "/features/validate.json",
          type: "get",
          data: {
            "title": function() {
              return $('#feature_title').val();
            }
          }
        }
      },
      "feature[in_order]": {required: true, minlength: 7},
      "feature[as_a]": {required: true, minlength: 4},
      "feature[i_want]": {required: true, minlength: 7}
    }
  });
});
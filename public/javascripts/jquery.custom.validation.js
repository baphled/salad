;(function($) {
  /**
  * Customised validations saving us the trouble of having to setup the defaults used throughout the application
  *
  **/
  $.fn.customValidations = function(options) {
    var opts = $.extend({}, $.fn.customValidations.defaults, options);
    
    $(this).validate({
      ignoreTitle: true,
      focusInvalid: true,
      clearFocus: true,
      successClass: 'valid',
      errorClass: 'error ui-state-error',
      errorElement: "span",
      highlight: function(element, errorClass, validClass) {
        $(element).fadeOut(function() {
          var $parent = $(element).parent();
          var $validElements = $parent.find('span.valid');
          $validElements.remove();

          $(element).addClass(errorClass).removeClass(validClass);
          $parent.addClass(errorClass).removeClass(validClass);
          $(element).show();
        });
      },
      unhighlight: function(element, errorClass, validClass) {
        var $parent = $(element).parent();
        var $invalidElements = $parent.find('span.error');

        $invalidElements.html('');
        $(element).removeClass(errorClass).addClass(validClass);
        $invalidElements.removeClass(errorClass).addClass(validClass);
        $parent.removeClass(errorClass).addClass(validClass);
      },
      success: function(label) {
        var $parent = $(label).parent();
        var $validElements = $parent.find('span.valid');

        $validElements.remove();
        label.removeClass('error ui-state-error').addClass("valid");
      },
      errorPlacement: function(error, element) {
        var $warningSpan = $('<span></span')
                          .css({'float': 'left', 'margin': '0.3em', 'padding-left': '5px'})
                          .addClass('ui-icon invalid'),
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
      rules: opts.rules
    });
  }
})(jQuery);

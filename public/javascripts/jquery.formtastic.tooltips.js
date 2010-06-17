(function($) {
  /**
  * A simplistic plugin for generating tipsy based tooltips for forms
  *
  * This plugin relies on formatastic's markup structure to generate the tooltips from the inline-hints elements
  *
  * @useage $('fieldset.inputs > ol li').generateFormatasticTooltips()
  *
  * @author Yomi Colledge
  **/
$.fn.generateFormatasticTooltips = function(options) {
  var opts = $.extend({}, $.fn.animateIconPanel.defaults, options);

  return $(this).each(function() {
    var $inputWrapper = $(this).find(opts.hintElement),
        hint = $inputWrapper.html();

    if (null != hint) {
      $inputWrapper.hide();
      $input = $('>input, >textarea', this);
      $input.tipsy({trigger: 'focus', gravity: 'w', fallback: hint});
    }
  });

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.generateFormatasticTooltips.defaults = {
  hintElement:'p.inline-hints'
};

})(jQuery);
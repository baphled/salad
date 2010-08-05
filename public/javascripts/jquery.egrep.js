/**
 * Basic function to help with regular expressions within jQuery
 *
 * @author Yomi Colledge
 * 
 */
(function($) {
  $.fn.egrep = function(pat) {
   var out = [];
   var textNodes = function(n) {
    if (n.nodeType == Node.TEXT_NODE) {
     var t = typeof pat == 'string' ?
      n.nodeValue.indexOf(pat) != -1 :
      pat.test(n.nodeValue);
     if (t) {
      out.push(n.parentNode);
     }
    }
    else {
     $.each(n.childNodes, function(a, b) {
      textNodes(b);
     });
    }
   };
   return this.each(function() {
    textNodes(this);
   });

  };
})(jQuery);
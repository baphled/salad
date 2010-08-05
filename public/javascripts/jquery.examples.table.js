$(document).ready(function() {
  var $originalSteps = null;

  var displayExamples = function(event) {

    var $headings = $('table.ui-tabs:visible > thead tr:last td b'),   // get headings
        $currentRow = $('td', this),
        $steps = $('ul.steps:visible li').egrep(/<(\w+)>/i);           // get steps with <>'s

    if (event.type == 'mouseenter') {
      $originalSteps = $('ul.steps:visible li').clone();
    }

    // search through each of the headings
    $currentRow.each(function() {
      var $row = $(this);
      var found = false;

      $headings.each(function(){
        var $heading = $(this),
            matcher = '<' + $heading.text() + '>';
        // search and replace matcher with the steps value
        if (found == false) {
          $steps.each(function() {
            var $step = $(this);
            // if the step contains the matcher
            var re = new RegExp(matcher);
            if (re.exec($step.text())) {
              var newString = $step.text().replace(matcher, $row.text());
              // replace text
              $step.text(newString);
              // return found
              found = true;
            }
          });
        }
      });
    });
  };

  var restoreExamples = function() {
    // revert
    $('ul.steps:visible li').replaceWith($originalSteps);
  };
  
  $('table.ui-tabs tbody tr').hover(displayExamples, restoreExamples);
});
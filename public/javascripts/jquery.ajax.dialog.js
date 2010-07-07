/**
* This plugin makes an ajax call to the backend requesting a specific piece of data from an object
* For the moment, we'll primarily be using this to retrieve Salad's feature content but we should be able
* to extend it to pull in any time of data and display it in a dialog box.
*
* @author Yomi Colledge
*
**/
$(function() {
  // create dialog div
  var $dialog = $('<div>').addClass('dialog path');
  
  // bind click event to related property on page
  $('a#file-feature').live('click', function() {
    // check to see if we already have the dialog element on the page
    if ($('div pre').size() == 0) {
      // make ajax call
      $.ajax({
        url: $('a#file-feature').attr('href'),
        type: 'GET',
        dataType: 'json',
        complete: function(xhr, textStatus) {
        },
        success: function(data, textStatus, xhr) {
          // populate dialog box with content
          var $wrapper = $('<pre>').append($('<code>'));
          
          $dialog
            .append($wrapper.append(data))
            .dialog({
              title: 'Source feature content',
              width: '95%',
              height: 500,
              buttons: { "Ok": function() { $(this).dialog("close"); } },
              modal: true
            });
        },
        error: function(xhr, textStatus, errorThrown) {
          // display flash error
        }
      });      
    } else {
      $('div.dialog').dialog('open');
    }
    
    return false;
  })
});

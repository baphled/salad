$(document).ready(function () {
  var loaded_location_value = $('#project_location').val();
  $("form.project").customValidations({
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
  if (window.location.pathname.indexOf('edit') != -1) {
    $("#project_title").rules('remove', 'remote');
    // @TODO Need to get this to be added or removed only when the location has changed or is not got a value
    $("#project_location").rules('remove', 'remote');
  }
});
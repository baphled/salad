$(document).ready(function () {
  $('form.step').customValidations({
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
  if (window.location.pathname.indexOf('edit') != -1) {
    $("#step_title").rules('remove', 'remote');
  };
});
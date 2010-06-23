$(document).ready(function () {
  $('form.resource').customValidations({
    rules: {
      "resource[name]": {
        required: true,
        minlength: 3,
        remote: {
          url: "/parking/unique_resource_name.json",
          type: "get",
          data: {
            "name": function() {
              return $('#resource_name').val();
            }
          }
        }
      },
      "resource[project]": {required: true, minlength: 3}
    }
  });
  if (window.location.pathname.indexOf('edit') != -1) {
    $("#resource_name").rules('remove', 'remote');
  };
});
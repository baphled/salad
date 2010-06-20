$(document).ready(function () {
  $('form.resource').customValidations({
    rules: {
      "resource[name]": {required: true},
      "resource[project_id]": {required: true}
    }
  });
});
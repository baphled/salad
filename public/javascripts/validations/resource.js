$(document).ready(function () {
  $('form.resource').customValidations({
    rules: {
      "resource[name]": {required: true, minlength: 3},
      "resource[project]": {required: true, minlength: 3}
    }
  });
});
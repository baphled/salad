$(document).ready(function () {
  $("form.project").validate({
    rules: {
      "project[title]": {required: true, minlength: 3},
      "project[description]": {required: true, minlength: 12},
      "project[aim]": {required: true, minlength: 6}
    }
  });
});
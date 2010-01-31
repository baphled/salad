$(document).ready(function () {
  $("form.project").validate({
    rules: {
      "project[title]": {required: true, minlength: 3},
      "project[description]": {required: true},
      "project[aim]": {required: true}
    }
  });
});
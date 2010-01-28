$(document).ready(function () {
  $("form.project").validate({
    rules: {
      "project[title]": {required: true},
      "project[description]": {required: true},
      "project[aim]": {required: true}
    }
  });
});
$(document).ready(function () {
  $("form.project").validate({
    debug: true,
    rules: {
      "project[title]": {required: true},
      "project[description]": {required: true},
      "project[aim]": {required: true}
    }
  });
});
$(document).ready(function () {
  $('form.story').validate({
    rules: {
      "story[scenario]": {required: true, minlength: 7}
    }
  });
});
$(document).ready(function () {
  $('form.feature').validate({
    rules: {
      "feature[title]": {required: true, minlength: 7},
      "feature[in_order]": {required: true, minlength: 7},
      "feature[as_a]": {required: true, minlength: 4},
      "feature[i_want]": {required: true, minlength: 7}
    }
  });
});
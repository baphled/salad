$(document).ready(function () {
  $('form.feature').customValidations({
    rules: {
      "feature[title]": {required: true, minlength: 7,
        remote: {
          url: "/features/validate.json",
          type: "get",
          data: {
            "title": function() {
              return $('#feature_title').val();
            }
          }
        }
      },
      "feature[in_order]": {required: true, minlength: 7},
      "feature[as_a]": {required: true, minlength: 4},
      "feature[i_want]": {required: true, minlength: 7}
    }
  });
  if (window.location.pathname.indexOf('edit') != -1) {
    $("#feature_title").rules('remove', 'remote');
  };
});
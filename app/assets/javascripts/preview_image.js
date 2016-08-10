$(function() {
  $('.js-preview-image').each(function() {
    var preview = $(this);
    var prototype_image = $(this).find('input[type=file]');
    prototype_image.change(function() {
      var file = this.files[0]
      var fileReader = new FileReader();
      fileReader.onload = function() {
        preview.css({
          'background-image': 'url(' + fileReader.result + ')'
        });
      };
      fileReader.readAsDataURL(file);
    });
  });
});

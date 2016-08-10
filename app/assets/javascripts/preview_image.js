$(function() {
  $('.js-preview-image').each(function() {
    const preview = $(this);
    const prototype_image = $(this).find('input[type=file]');
    prototype_image.change(function() {
      // 1. 選択されたファイルがない場合は何もせずにerrorをアラートで出す
      if (!this.files.length) {
        alert('No file selected')
      }
      // 2. files配列にファイルが入っており、変数fileへ代入
      var file = this.files[0]
      // 3. 画像ファイル以外は表示できない
      if (!file.type.match('image.*')) {
        alert('Upload image file only')
      }
      // 4. fileを読み込むFileReaderオブジェクト
      const fileReader = new FileReader();
      // 5. 読み込みが完了した際のイベントハンドラ。
      fileReader.onload = function() {
        preview.css({
          'background-image': 'url(' + fileReader.result + ')'
        });
      };
      // 6. 画像読み込み
      fileReader.readAsDataURL(file);
    });
  });
});

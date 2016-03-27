$(document).ready(function() {
  bind_real_field_with_displayer();
  bind_uploader_click_to_button();
});

function bind_real_field_with_displayer(){
  $('.js_quote_upload').change(function() {
    var child = $(this).data('child');
    var value = $(this).val().replace(/^.*[\\\/]/, '');
    $('#'+child+'_filename').val(value);
  });
}

function bind_uploader_click_to_button(){
  $('.js_doc_uploader').click(function() {
    var uploader_id = $(this).data('parent');
    $('#quote_proposal_'+uploader_id).click();
  });
}

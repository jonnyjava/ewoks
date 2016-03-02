$(document).ready(function(){
  $('.js_check_toggler').click(function(){
    toggle_check();
  });
});

function toggle_check(){
  var actual_state = $(this).data('all-selected');
  $(this).data('all-selected', !actual_state);
  actual_state ? uncheck_all(): check_all();
}

function check_all(){
  $('.js_select_all').each(function(){
    $(this).prop('checked', true);
    $(this).parent().attr('aria-checked', true);
    $(this).parent().addClass('checked');
  });
}

function uncheck_all(){
  $('.js_select_all').each(function(){
    $(this).prop('checked', false);
    $(this).parent().attr('aria-checked', false);
    $(this).parent().removeClass('checked');
  });
}
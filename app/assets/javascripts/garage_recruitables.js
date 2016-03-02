$(document).ready(function(){
  activate_search();
  activate_export();
  activate_check_toggler();
});

function activate_search(){
  $('.js_search').click(function(){
    var filtering_params = $('.js_searchable');
    if (search_has_values(filtering_params)){
      submit_search($(this),filtering_params);
    }
  });
}

function search_has_values(filtering_params){
  var has_values = false;
  filtering_params.filter(function(){
    if($(this).val() !== ''){
      has_values = true;
    }
  });
  return has_values;
}

function submit_search(clicked_button, filtering_params){
  var form = clicked_button[0].form;
  var status = $('.js_selectable').val();
  filtering_params.clone().hide().appendTo(form);
  $('.js_selectable').val(status);
  $(form).submit();
}

function activate_export(){
  $('.js_excel_exporter').click(function(){
    var selected_garages = $('.js_exportable');
    $($(this)[0].form).append(selected_garages).submit();
  });
}

function activate_check_toggler(){
  $('.js_check_toggler').click(function(){
    toggle_check();
  });
}

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

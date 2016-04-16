$ ->
  $(".js-datepicker").datepicker
    defaultDate: "+1w",
    changeMonth: true,
    dateFormat: "yy-mm-dd"

  $(".js-datepicker-start").datepicker
    defaultDate: "+1w",
    changeMonth: true,
    dateFormat: "yy-mm-dd",
    onClose: (selectedDate) ->
      $(".js-datepicker-end").datepicker("option", "minDate", selectedDate)

  $(".js-datepicker-end").datepicker
    defaultDate: "+1w",
    changeMonth: true,
    dateFormat: "yy-mm-dd",
    onClose: (selectedDate) ->
      $(".js-datepicker-start").datepicker("option", "maxDate", selectedDate)

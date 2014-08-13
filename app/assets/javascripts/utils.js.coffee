$ ->
  $(".timepicker").timepicker
    showInputs: false,
    defaultTime: '00:00',
    showMeridian: false,
    minuteStep: 15

  $("input:checkbox").on "ifClicked", (event) ->
    day = $(this).attr("data-day")
    checked = $(this).is(":checked")
    $("#timetable_" + day + "_morning_close").val("").prop "disabled", not checked
    $("#timetable_" + day + "_afternoon_open").val("").prop "disabled", not checked
    return

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


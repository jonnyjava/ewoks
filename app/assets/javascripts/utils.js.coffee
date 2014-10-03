$ ->
  $(".timepicker").timepicker
    showInputs: false,
    defaultTime: '00:00',
    showMeridian: false,
    minuteStep: 15

  $("input:checkbox.at_noon").on "ifClicked", (event) ->
    day = $(this).attr("data-day")
    checked = $(this).is(":checked")
    $("#timetable_" + day + "_morning_close").val("").prop "disabled", checked
    $("#timetable_" + day + "_afternoon_open").val("").prop "disabled", checked
    return

  $("input:checkbox.daylong").on "ifClicked", (event) ->
    day = $(this).attr("data-day")
    checked = $(this).is(":checked")

    if !checked
      $("#" + day + "_noon").attr("disabled", true)
    else
      $("#" + day + "_noon").attr("disabled", false)

    if $("#" + day + "_noon").is(":checked")
      $("#timetable_" + day + "_morning_open").val("").prop "disabled", !checked
      $("#timetable_" + day + "_afternoon_close").val("").prop "disabled", !checked
      $("#timetable_" + day + "_morning_close").val("").prop "disabled", !checked
      $("#timetable_" + day + "_afternoon_open").val("").prop "disabled", !checked
    else
      $("#timetable_" + day + "_morning_open").val("").prop "disabled", !checked
      $("#timetable_" + day + "_afternoon_close").val("").prop "disabled", !checked
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

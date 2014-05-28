jQuery ->
  Shadowbox.init()
  $('.js-focus').focus()
  $('.js-tooltip').tooltip()
  $('.js-select2').select2()
  $('.js-datepicker').datetimepicker(
    icons:
      time: "fa fa-clock-o"
      date: "fa fa-calendar"
      up: "fa fa-arrow-up"
      down: "fa fa-arrow-down"
  )
  $(".modal").on('shown.bs.modal', () -> $(this).find('input:text:visible:first').focus())
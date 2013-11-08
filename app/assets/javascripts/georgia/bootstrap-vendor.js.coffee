jQuery ->
  $('.js-focus').focus()
  $('.js-tooltip').tooltip()
  $('.js-sortable').sortable(axis: 'y')
  $('.js-select2').select2()
  $(".modal").on('shown.bs.modal', () -> $(this).find('input:text:visible:first').focus())

class @SpinningForm

  constructor: (element) ->
    @element = $(element)
    @submitBtn = @element.find("[type='submit']")
    @setBindings()

  setBindings: () =>
    @element.on('ajax:beforeSend', (event, xhr, settings) =>
      @disableBtn()
      @submitBtn.html("<i class='fa fa-spinner fa-spin'>&nbsp;</i> Saving...")
    )
    @element.on('ajax:success', (event, xhr, status) =>
      @submitBtn
        .addClass('btn-info')
        .html("<i class='fa fa-check'>&nbsp;</i> Saved")
    )
    @element.on('ajax:error', (event, xhr, status) =>
      @submitBtn
        .addClass('btn-danger')
        .html("<i class='fa fa-exclamation-triangle'>&nbsp;</i> Oups!")
    )
    @element.on('ajax:complete', (event, xhr, status) =>
      setTimeout(
        () =>
          @clearBtnClasses()
          @enableBtn()
          @submitBtn.html("<i class='fa fa-check'>&nbsp;</i> Save")
        , 2000
      )
    )

  disableBtn: () =>
    @submitBtn.prop('disabled', true)

  enableBtn: () =>
    @submitBtn.prop('disabled', false)

  clearBtnClasses: () =>
    @submitBtn
      .removeClass('btn-info')
      .removeClass('btn-danger')


$.fn.spinningForm = () ->
  @each ->
    new SpinningForm($(this))

jQuery ->
  $("form[data-remote='true']").each () ->
    $(this).spinningForm()
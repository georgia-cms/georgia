class @Checkboxable

  constructor: (element) ->
    @element      = $(element)
    @select_all   = @element.find("[data-checkbox='all']")
    @checkboxes   = @element.find("[data-checkbox='child']")

    @select_all.bind('click', @updateCheckboxes)
    @checkboxes.bind('click', @update)

  update: (event) =>
    checkbox = $(event.currentTarget)
    @updateCheckbox(checkbox)
    @updateSelectAll()

  updateCheckboxes: () =>
    switch @getState(@select_all)
      # uncheck, going checked
      when 'unchecked'
        @check(@select_all)
        @check(@checkboxes) if @checkboxes.length
      # indeterminate, going unchecked
      when 'indeterminate'
        @uncheck(@select_all)
        @uncheck(@checkboxes) if @checkboxes.length
      # checked, going unchecked
      else
        @uncheck(@select_all)
        @uncheck(@checkboxes) if @checkboxes.length

  updateCheckbox: (el) =>
    switch @getState(el)
      # uncheck, going checked
      when 'unchecked'
        @check(el)
      # checked, going unchecked
      else
        @uncheck(el)


  updateSelectAll: () =>
    # gather all siblings states
    states = @checkboxes.map (i, c) => @getState(c)
    # get unique values
    states = @distinct(states)
    # if not all siblings share the same state, go indeterminate
    if states.length > 1
      @indeterminate(@select_all)
    else
      # all siblings are sharing the same state
      switch states[0]
        # if all unchecked, set parent as unchecked
        when 'unchecked' then @uncheck(@select_all)
        # if all checked, set parent as checked
        when 'checked' then @check(@select_all)

  check: (el) =>
    $(el).each (index, e) =>
      @setState(e, 'checked')
      $(e).prop('indeterminate', false)
      $(e).prop('checked', true)
      $(e).closest('tr').addClass('is-selected')

  uncheck: (el) =>
    $(el).each (index, e) =>
      @setState(e, 'unchecked')
      $(e).prop('indeterminate', false)
      $(e).prop('checked', false)
      $(e).closest('tr').removeClass('is-selected')

  indeterminate: (el) =>
    $(el).each (i, e) =>
      @setState(e, 'indeterminate')
      $(e).prop('indeterminate', true)

  # Keep only distinct/unique values for an Array
  distinct: (array) ->
    result = []
    $.each(array, (i,v) ->
      result.push(v) if ($.inArray(v, result) == -1)
    )
    result

  getCheckbox: (event)  -> $(event.currentTarget).closest('tr').find("[data-checkbox='child']").first()
  getState: (el)        -> $(el).data('state')
  setState: (el, state) -> $(el).data('state', state)


$.fn.actsAsCheckboxable = () ->
  @each ->
    new Checkboxable($(this))

jQuery ->
  $("table.js-checkboxable").each ->
    $(this).actsAsCheckboxable()
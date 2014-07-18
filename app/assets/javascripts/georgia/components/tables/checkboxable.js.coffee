class @Checkboxable

  constructor: (element) ->
    @element            = $(element)
    @selectAllCheckbox  = @element.find("[data-checkbox='all']")
    @setBindings()

  checkboxes: () => @element.find("[data-checkbox='child']")

  setBindings: () =>
    @selectAllCheckbox.bind('click', @updateCheckboxes)
    @element.on('click', @checkboxes(), @update)

  update: (event) =>
    checkbox = $(event.target)
    @updateCheckbox(checkbox)
    @updateSelectAll()

  updateCheckboxes: (event) =>
    switch @getState(@selectAllCheckbox)
      # uncheck, going checked
      when 'unchecked'
        @check(@selectAllCheckbox)
        @check(@checkboxes()) if @checkboxes().length
      # indeterminate, going unchecked
      when 'indeterminate'
        @uncheck(@selectAllCheckbox)
        @uncheck(@checkboxes()) if @checkboxes().length
      # checked, going unchecked
      else
        @uncheck(@selectAllCheckbox)
        @uncheck(@checkboxes()) if @checkboxes().length

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
    states = @checkboxes().map (i, c) => @getState(c)
    # get unique values
    states = @distinct(states)
    # if not all siblings share the same state, go indeterminate
    if states.length > 1
      @indeterminate(@selectAllCheckbox)
    else
      # all siblings are sharing the same state
      switch states[0]
        # if all unchecked, set parent as unchecked
        when 'unchecked' then @uncheck(@selectAllCheckbox)
        # if all checked, set parent as checked
        when 'checked' then @check(@selectAllCheckbox)
        else @uncheck(@selectAllCheckbox)

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

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()
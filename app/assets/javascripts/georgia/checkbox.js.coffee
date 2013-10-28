# CheckboxTree is used on the settings page to allow for tree-like structure of checkboxes
# It makes use of a data-attribute to go around a bug where you can't uncheck programatically on certain browsers.
# Use data-checked attribute to set either:
# - checked
# - unchecked
# - indeterminate

# TODO: Once you've updated the parent based on its siblings, you'd need to check for the other level of ancestry too.

class @Checkboxable

  constructor: (element) ->
    @element      = $(element)
    @select_all   = @element.find("[data-checkbox='all']")
    @checkboxes   = @element.find("[data-checkbox='child']")

    @select_all.bind('click', @updateCheckboxes)
    @checkboxes.bind('click', @update)

  update: (event) =>
    element = $("##{event.target.id}")
    @updateCheckbox(element)
    @updateSelectAll()

  updateCheckboxes: () =>
    switch @getState(@select_all)
      # uncheck, going checked
      when 'uncheck'
        @check(@select_all)
        @check(@checkboxes) if @checkboxes.length
      # indeterminate, going checked
      when 'indeterminate'
        @check(@select_all)
        @check(@checkboxes) if @checkboxes.length
      # checked, going unchecked
      else
        @uncheck(@select_all)
        @uncheck(@checkboxes) if @checkboxes.length

  updateCheckbox: (el) =>
    switch @getState(el)
      # uncheck, going checked
      when 'uncheck'
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
        when 'uncheck' then @uncheck(@select_all)
        # if all checked, set parent as checked
        when 'checked' then @check(@select_all)

  check: (el) =>
    $(el).each (index, e) =>
      @setState(e, 'checked')
      $(e).prop('indeterminate', false)
      $(e).prop('checked', true)

  uncheck: (el) =>
    $(el).each (index, e) =>
      @setState(e, 'uncheck')
      $(e).prop('indeterminate', false)
      $(e).prop('checked', false)

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

  getState: (el) ->
    $(el).data('state')

  setState: (el, state) ->
    console.log 'State before: ' + $(el).data('state')
    $(el).data('state', state)
    console.log 'State after: ' + $(el).data('state')

$.fn.actsAsCheckboxable = () ->
  @each ->
    new Checkboxable($(this))

jQuery ->
  $(".js-checkboxable").each ->
    $(this).actsAsCheckboxable()
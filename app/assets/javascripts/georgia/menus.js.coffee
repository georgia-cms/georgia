jQuery ->
	$( "#active" ).sortable(
		connectWith: '.column'
		tolerance: 'pointer'
		handle: '.handle'
		receive: ->
			$.post($(this).data('update-url'), $(this).sortable('serialize') )
	).disableSelection()

	$( "#inactive" ).sortable(
		connectWith: '.column'
		tolerance: 'pointer'
		receive: ->
			$.post($(this).data('update-url'), $(this).sortable('serialize') )
	).disableSelection()
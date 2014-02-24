jQuery ->
	$('#post_body').bind 'input propertychange', () ->
		input = $(this).val()
		$('.form-actions').show()
		if input.slice(0,2) == 'ht'
			$('.form-loading').show()
			$.ajax
				url: '/fetch'
				data:
					q: input
		else
			$('input:radio[name="post[type]"][value="Status"]').prop('checked', true)
			if $('#post_body').val().length == 0
				$('.form-actions, .form-loading').hide()
		return false

	$('#post_title').bind 'input propertychange', () ->
		input = $(this).val()
		if !input.length
			alert "Please include a title."
		return false

	$('#post_body').focus()
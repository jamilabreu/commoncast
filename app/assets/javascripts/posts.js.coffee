jQuery ->
	$('#post_body').bind 'input propertychange', () ->
		input = $(this).val()
		$('.form-actions').show()
		if input.slice(0,4) == 'http'
			$('.form-loading').show()
			$.ajax
				url: '/fetch'
				data:
					q: input
		else
			$('input:radio[name="post[type]"][value="Status"]').prop('checked', true)
			if !input.length
				$('#post_title, .form-actions').hide()
		return false

	$('#post_title').bind 'input propertychange', () ->
		input = $(this).val()
		if !input.length
			alert "Please include a title."
		return false

	$('#post_body').focus()
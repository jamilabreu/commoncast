jQuery ->
	$('input[type=file]').change (event) ->
		input = $(event.currentTarget)
		file = input[0].files[0]
		reader = new FileReader()
		reader.onload = (e) ->
			$('.image_field img').attr "src", e.target.result
		reader.readAsDataURL file
extends Panel



func _process(_delta):
	rect_size.x = get_viewport_rect().size.x
	rect_size.y = get_viewport_rect().size.y

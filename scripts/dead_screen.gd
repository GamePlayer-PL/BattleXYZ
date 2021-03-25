extends Node2D



func _process(_delta):
	$zg.rect_position.x = get_viewport_rect().size.x/3
	$zg.rect_position.y = get_viewport_rect().size.y/8

func _input(event):
	if(event.is_action_pressed("ui_exit")):
		get_tree().quit()
	if(event.is_action_pressed("back_to_game")):
		get_tree().change_scene("res://scenes/main.tscn")

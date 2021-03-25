extends Sprite

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	position.x = get_global_mouse_position().x+texture.get_size().x/4
	position.y = get_global_mouse_position().y+texture.get_size().y/4

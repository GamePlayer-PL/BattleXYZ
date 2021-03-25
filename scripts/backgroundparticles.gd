extends CPUParticles2D


func _process(_delta):
	self.position.x = get_viewport_rect().size.x+20
	self.emission_rect_extents.y = get_viewport_rect().size.y

var pause = false

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)
		if(pause):
			self.speed_scale = 0
		else:
			self.speed_scale = 1

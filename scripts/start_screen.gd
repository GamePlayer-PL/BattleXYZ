extends Sprite

func _ready():
	self.visible = true
	$AnimationPlayer.play("Unvisible")

func _process(_delta):
	position.x = get_viewport_rect().size.x/2
	position.y = get_viewport_rect().size.y/2
	scale.x = get_viewport_rect().size.x/self.texture.get_size().x
	scale.y = get_viewport_rect().size.y/self.texture.get_size().y

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	self.queue_free()

extends RigidBody2D

var pause = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	position.x = get_viewport_rect().size.x+50
	position.y = rng.randf_range(0, get_viewport_rect().size.y)
	pause = get_tree().get_root().get_node("main/objectsystem").pause

func _process(_delta):
	if(!pause):
		self.linear_velocity.x = -50
	else:
		self.linear_velocity.x = 0
	if(position.x < -50):
		self.queue_free()

func _on_wrench_body_entered(body):
	if(body.name.left(1) == "p" or body.name.left(1) == "b"):
		self.queue_free()

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)
		

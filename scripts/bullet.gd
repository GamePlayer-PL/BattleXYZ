extends RigidBody2D

var pause = false

func move2(steps):
	self.position.x = self.position.x+sin(self.rotation_degrees)*steps
	self.position.y = self.position.y+cos(self.rotation_degrees)*steps

onready var time = OS.get_system_time_msecs()

func _ready():
	rotation_degrees = get_tree().get_root().get_node("main/player").rotation_degrees
	position.x = get_tree().get_root().get_node("main/player").position.x+20
	position.y = get_tree().get_root().get_node("main/player").position.y
	pause = get_tree().get_root().get_node("main/bulletsystem").pause
func _process(_delta):
	#print("PP: %d"%$CPUParticles2D.position.x+":%d"%$CPUParticles2D.position.y)
	#print("BB: %d"%position.x+":%d"%position.y)
	#$CPUParticles2D.position = self.position
	#move_local_x(1)
	if(!pause):
		self.linear_velocity.x = 50
	else:
		self.linear_velocity.x = 0
	#$CollisionShape2D.position.x = position.x
	if(position.x > get_tree().get_root().get_node("main/player").position.x+get_viewport_rect().size.x):
		self.queue_free()


func _on_bullet_body_entered(body):
	#print("B")
	if(body.name.left(1) == "a" or body.name == "coin" or body.name == "diamond coin"):
		self.queue_free()
	

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)

extends Node2D

var pause = false
var rng = RandomNumberGenerator.new()
onready var time = OS.get_system_time_msecs()

func _ready():
	rng.randomize()
	var random = round(rng.randf_range(1, 4))
	$Sprite.texture = load("res://textures/asteroids/asteroid-%d"%random+".png")
	position.x = get_viewport_rect().size.x+50
	position.y = rng.randf_range(0, get_viewport_rect().size.y)
	pause = get_tree().get_root().get_node("main/objectsystem").pause

func _physics_process(_delta):
	if(!pause):
		self.linear_velocity.x = -50
	else:
		self.linear_velocity.x = 0
	#print(self.position)
	if(position.x < -20):
		self.queue_free()
	#if(destroy == false):
	#	time = OS.get_system_time_msecs()
	#if(destroy and OS.get_system_time_msecs() - time > 10):
	#	self.queue_free()
#	if($Sprite.visible):
#		if(OS.get_system_time_msecs() - time2 > 10):
#			#$CollisionShape2D.position.x = position.x
#			time2 = OS.get_system_time_msecs()

func _on_asteroid_body_entered(body):
	#print("C")
	if(body.name == "player" or body.name.left(1) == "b"):
		get_tree().get_root().get_node("main").play_rock()
		self.queue_free()
		#self.queue_free()
		#$CPUParticles2D.emitting = true
		#$CollisionShape2D.disabled = true
		#$Sprite.visible = false
		#destroy = true



func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)
		

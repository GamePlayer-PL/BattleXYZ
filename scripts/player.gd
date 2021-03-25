extends Node2D

var deg = 0
var play = true
var health = 3
var coins = 0


func _ready():
	$player.rotation_degrees = 0

var y = 0

func _process(_delta):
	if(pause):
		$player/spacecraft/enginefire.speed_scale = 0
	else:
		$player/spacecraft/enginefire.speed_scale = 1
	#print("P: %d"%$player/CollisionShape2D.position.x+":%d"%$player/CollisionShape2D.position.y)
	position.y = get_viewport_rect().size.y/2+y
	position.x = get_viewport_rect().size.x/2-get_viewport_rect().size.x/4
	#$player/CollisionShape2D.position.x = position.x
	#$player/CollisionShape2D.position.y = position.y
	if(play == true and !pause):
		game()
		#set_process_input(true)
	



func game():
	if(deg == -1):
		if($player.rotation_degrees > -30 and not(y < -200)):
			$player.rotation_degrees -= 1
			y -= 1
	if(deg == 1):
		if($player.rotation_degrees < 30 and not(y > 200)):
			$player.rotation_degrees += 1
			y += 1
	if(deg == 0):
		if($player.rotation_degrees < 0):
			$player.rotation_degrees += 1
			y -= 1
		if($player.rotation_degrees > 0):
			$player.rotation_degrees -= 1
			y += 1

var pause = false

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)
		
	if(event.is_action_pressed("ui_up") and !pause):
		deg = -1
		
	if(event.is_action_pressed("ui_down") and !pause):
		deg = 1
		
	if not(event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up")):
		deg = 0


func _on_player_body_entered(body):
	#print("A")
	if(body.name.left(1) == "a"):
		if not(health <= 0):
			health -= 1
			$AnimationPlayer.play("sprite")
		if(health == 2):
			get_tree().get_root().get_node("main/healthGUI/animations/AnimationPlayer").play("3-h-down")
		if(health == 1):
			get_tree().get_root().get_node("main/healthGUI/animations/AnimationPlayer").play("2-h-down")
		if(health == 0):
			#get_tree().get_root().get_node("main/healthGUI/animations/AnimationPlayer").play("1-h-down")
			get_tree().get_root().get_node("main").gameover()
	if(body.name.left(1) == "c"):
		coins += 10
		get_tree().get_root().get_node("main/Pointssystem/Label").text = "Punkty: %d"%coins
	if(body.name.left(1) == "d"):
		coins += 100
		get_tree().get_root().get_node("main/Pointssystem/Label").text = "Punkty: %d"%coins
	if(body.name.left(1) == "w"):
		if not(health >= 3):
			health += 1
			$AnimationPlayer.play("sprite")
			get_tree().get_root().get_node("main").play_wrench()
		if(health == 2):
			get_tree().get_root().get_node("main/healthGUI/animations/AnimationPlayer").play("2-h-up")
		if(health == 3):
			get_tree().get_root().get_node("main/healthGUI/animations/AnimationPlayer").play("3-h-up")

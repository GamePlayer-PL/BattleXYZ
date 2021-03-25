extends Node2D


var anim_type = 0
var pause = false


func _process(_delta):
	$Panel.rect_position.x = get_viewport_rect().size.x
	$Panel.rect_position.y = get_viewport_rect().size.y
	$Pauselabel.rect_position.x = get_viewport_rect().size.x/2.6
	if(anim_type == -1):
		animation_down()
	if(anim_type == 1):
		animation_up()

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)
		if(pause == true):
			animation_s_down()
		else:
			animation_s_up()

onready var time1 = OS.get_system_time_msecs()

func animation_down():
	if(OS.get_system_time_msecs() - time1 > 10 and $Pauselabel.rect_position.y < get_viewport_rect().size.y/8):
		$Pauselabel.rect_position.y += 20
		#$Pauselabel.modulate.a += 10
		time1 = OS.get_system_time_msecs()
	if($Pauselabel.rect_position.y > get_viewport_rect().size.y/8):
		anim_type = 0

onready var time2 = OS.get_system_time_msecs()

func animation_up():
	if(OS.get_system_time_msecs() - time2 > 10 and $Pauselabel.rect_position.y > -200):
		$Pauselabel.rect_position.y -= 20
		#$Pauselabel.modulate.a -= 10
		time2 = OS.get_system_time_msecs()
	if($Pauselabel.rect_position.y < -200):
		anim_type = 0

func animation_s_up():
	$AnimationPlayer.play("Unvisible")
	anim_type = 1

func animation_s_down():
	$AnimationPlayer.play("Visible")
	anim_type = -1

extends Node2D

var pause = false

func mkbullet():
	var ins = load("res://scenes/bullet.tscn").instance()
	ins.name = "bullet:%d"%OS.get_system_time_msecs()
	self.add_child(ins)
	get_tree().get_root().get_node("main").play_laser()

func _input(event):
	if(event.is_action_pressed("shot") and !pause):
		mkbullet()
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)

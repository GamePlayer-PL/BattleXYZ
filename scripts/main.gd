extends Node2D

func _ready():
	#get_node("healthGUI/animations/2").visible = true
	if(OS.get_name() == "HTML5"):
		var score = read_from_javascript("lastscore")
		var score2 = read_from_javascript("highscore")
		$pause/Pauselabel/lastscore.text = "Ostatni wynik: %d"%score
		$pause/Pauselabel/highscore.test = "Najwyższy wynik: %d"%score2
	else:
		$pause/Pauselabel/lastscore.text = "Ostatni wynik: %d"%read_from_disk("lastscore")
		$pause/Pauselabel/highscore.text = "Najwyższy wynik: %d"%read_from_disk("highscore")

func _process(_delta):
	$Label.text = "H: %d"%$player.health+"\nP: %d"%$player.coins
	$healthGUI.position.x = get_viewport_rect().size.x-get_viewport_rect().size.x/1.1
	$healthGUI.position.y = 27
	$Pointssystem.position.x = get_viewport_rect().size.x-100
	$Pointssystem.position.y = 27
	$time.position.x = get_viewport_rect().size.x/2
	$time.position.y = 27
	$damage.position.x = get_viewport_rect().size.x/2
	$damage.position.y = get_viewport_rect().size.y/2
	$damage.scale.x = 0.6#*get_viewport_rect().size.x/8
	$damage.scale.y = 0.6#*get_viewport_rect().size.y/8
	if($bulletsystem.pause != true):
		time2()
		

var game_time = 0
onready var time = OS.get_system_time_secs()

func time2():
	if(OS.get_system_time_secs() - time > 1):
		game_time += 1
		$time/Label.text = "%d"%game_time
		time = OS.get_system_time_secs()

func save_in_javascript(vara, data):
	JavaScript.eval("window.localStorage.setItem('"+vara+"', '" + data + "')")

func save_on_disk(filename2, data):
	var file = File.new()
	file.open("user://"+filename2+".var", File.WRITE)
	file.store_var(data)
	file.close()

func read_from_disk(filename2):
	var dir = Directory.new()
	if(dir.file_exists("user://"+filename2+".var")):
		var file = File.new()
		file.open("user://"+filename2+".var", File.READ)
		var data = file.get_var()
		file.close()
		return data
	else:
		return 0

func read_from_javascript(vara):
	if JavaScript.eval("window.localStorage.hasOwnProperty('"+vara+"')"):
		return JavaScript.eval("window.localStorage.getItem('"+vara+"')")
	else:
		return 0

func _exit_tree():
	if(OS.get_name() == "HTML5"):
		save_in_javascript("lastscore", get_node("player").coins)
		if(get_node("player").coins > read_from_javascript("highscore")):
			save_in_javascript("highscore", get_node("player").coins)
	else:
		save_on_disk("lastscore", get_node("player").coins)
		if(get_node("player").coins > read_from_disk("highscore")):
			save_on_disk("highscore", get_node("player").coins)
		

func _input(event):
	if(event.is_action_pressed("ui_exit") and $bulletsystem.pause == true):
		get_tree().quit()
	if(event.is_action_pressed("ui_cancel") and $bulletsystem.pause == true):
		$mouse.texture = load("res://textures/mouse-1.png")
	if(event.is_action_pressed("ui_cancel") and $bulletsystem.pause == false):
		$mouse.texture = load("res://textures/mouse-2.png")

func gameover():
	_exit_tree()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/dead_screen.tscn")

func play_wrench():
	$soundeffects.time3 = OS.get_system_time_msecs()
	$soundeffects/wrench.play()

func play_rock():
	$soundeffects.time4 = OS.get_system_time_msecs()
	get_node("soundeffects/rock-destroy").play()

func play_coin():
	$soundeffects.time2 = OS.get_system_time_msecs()
	$soundeffects/coin.play()

func play_laser():
	$soundeffects.time1 = OS.get_system_time_msecs()
	$soundeffects/laser.play()

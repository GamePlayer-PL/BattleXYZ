extends Node2D


onready var time1 = OS.get_system_time_msecs()
onready var time2 = OS.get_system_time_msecs()
onready var time3 = OS.get_system_time_msecs()
onready var time4 = OS.get_system_time_msecs()

func _process(_delta):
	#if($laser.playing):
	if((OS.get_system_time_msecs() - time1)/500 > $laser.stream.get_length()):
		$laser.stop()
	if((OS.get_system_time_msecs() - time2)/500 > $coin.stream.get_length()):
		$coin.stop()
	if((OS.get_system_time_msecs() - time3)/500 > $wrench.stream.get_length()):
		$wrench.stop()
	if((OS.get_system_time_msecs() - time4)/500 > get_node("rock-destroy").stream.get_length()):
		get_node("rock-destroy").stop()

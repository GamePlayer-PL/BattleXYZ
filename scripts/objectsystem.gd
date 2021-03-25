extends Node2D

var pause = false

func mkasteroid():
	var ins = load("res://scenes/asteroid.tscn").instance()
	ins.name = "asteroid:%d"%OS.get_system_time_msecs()
	self.add_child(ins)

var rng = RandomNumberGenerator.new()
onready var time = OS.get_system_time_msecs()
onready var time2 = OS.get_system_time_msecs()
onready var time3 = OS.get_system_time_msecs()
onready var time4 = OS.get_system_time_msecs()

func _ready():
	rng.randomize()

func _process(_delta):
	if(!pause and OS.get_system_time_msecs() - time > round(rng.randf_range(1000, 5000))):
		mkasteroid()
		time = OS.get_system_time_msecs()
	if(!pause and OS.get_system_time_msecs() - time2 > round(rng.randf_range(10000, 15000))):
		mkcoin()
		time2 = OS.get_system_time_msecs()
	if(!pause and OS.get_system_time_msecs() - time3 > round(rng.randf_range(50000, 60000))):
		mkdcoin()
		time3 = OS.get_system_time_msecs()
	if(!pause and OS.get_system_time_msecs() - time4 > round(rng.randf_range(30000, 45000))):
		mkwrench()
		time4 = OS.get_system_time_msecs()

func mkcoin():
	var ins = load("res://scenes/coins/coin.tscn").instance()
	ins.name = "coin:%d"%OS.get_system_time_msecs()
	self.add_child(ins)

func mkdcoin():
	var ins = load("res://scenes/coins/diamond_coin.tscn").instance()
	ins.name = "dcoin:%d"%OS.get_system_time_msecs()
	self.add_child(ins)

func mkwrench():
	var ins = load("res://scenes/wrench.tscn").instance()
	ins.name = "wrench:%d"%OS.get_system_time_msecs()
	self.add_child(ins)
func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		pause = not(pause)

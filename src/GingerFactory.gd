extends Node

var ginger_scene = load("res://scn/GingerBreadMan.tscn")
var santa_scene = load("res://scn/Santa.tscn")
var time_start
var time_now
var scene_size
var minutes = 0
var seconds = 0
var ginger_count = 0
var santa_count = 0
var last_santa = 0



func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	scene_size = get_viewport().size
	#for i in range(10):
	#	spawn_ginger()

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	minutes = elapsed / 60
	seconds = elapsed % 60

	# TODO: Create spawn points, and use random spawn points off-screen to spawn enemies
	if ginger_count < seconds / 5:
		spawn_ginger()
	

	elif seconds > last_santa + 15 and santa_count <1:
		spawn_santa()

	
func spawn_ginger():
	ginger_count += 1
	var ginger = ginger_scene.instance()
	ginger.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	ginger.max_health = 20 + (seconds/2) + randi() % 20
	ginger.damage = .1 + (seconds/100)
	ginger.Speed = 10 + (seconds/5)
	#get_parent().add_child(ginger)
	get_node("..").add_child(ginger)
	#add_child(ginger)
	
func spawn_santa():
	santa_count += 1
	var santa = santa_scene.instance()
	santa.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	#get_parent().add_child(santa)
	#add_child(santa)
	get_node("..").add_child(santa)
	
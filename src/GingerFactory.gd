extends Node

var ginger_scene = load("res://scn/GingerBreadMan.tscn")
var santa_scene = load("res://scn/Santa.tscn")
var time_start
var time_now
var scene_size

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	scene_size = get_viewport().size
	for i in range(10):
		spawn_ginger(Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y)))
	spawn_santa(Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y)))

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	
	if get_child_count() < seconds / 5:
		spawn_ginger(Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y)))

	
func spawn_ginger(location):
	var ginger = ginger_scene.instance()
	ginger.position = location
	#get_parent().add_child(ginger)
	add_child(ginger)
	
func spawn_santa(location):
	var santa = santa_scene.instance()
	santa.position = location
	#get_parent().add_child(santa)
	add_child(santa)
	
extends Node

func _ready():
	var scene_size = get_viewport().size
	var ginger_scene = load("res://scn/GingerBreadMan.tscn")
	var santa_scene = load("res://scn/Santa.tscn")
	for i in range(10):
		var ginger = ginger_scene.instance()
		ginger.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
		#get_parent().add_child(ginger)
		add_child(ginger)
	
	var santa = santa_scene.instance()
	santa.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	#get_parent().add_child(santa)
	add_child(santa)
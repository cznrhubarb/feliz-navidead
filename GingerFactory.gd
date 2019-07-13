extends Node

func _ready():
	var scene_size = get_viewport().size
	var ginger_scene = load("res://GingerBreadMan.tscn")
	for i in range(20):
		var ginger = ginger_scene.instance()
		ginger.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
		print(ginger.position)
		get_owner().add_child(ginger)
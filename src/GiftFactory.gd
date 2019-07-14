extends Node

func _ready():
	var scene_size = get_viewport().size
	var gift_scene = load("res://scn/Gift.tscn")
	for i in range(2):
		var gift = gift_scene.instance()
		gift.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
		#get_parent().add_child(gift)
		add_child(gift)
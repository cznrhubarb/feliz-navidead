extends Node

func _ready():
	var scene_size = get_viewport().size
	var tree_scene = load("res://scn/Tree.tscn")
	for i in range(10):
		var tree = tree_scene.instance()
		tree.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
		#get_parent().add_child(tree)
		add_child(tree)
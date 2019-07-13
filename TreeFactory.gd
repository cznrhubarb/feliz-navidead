extends Node

func _ready():
	var scene_size = get_viewport().size
	var tree_scene = load("res://Tree.tscn")
	for i in range(20):
		var tree = tree_scene.instance()
		tree.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
		print(tree.position)
		add_child(tree)
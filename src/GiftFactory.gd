extends Node

var scene_size
var gift_scene

func _ready():
	set_process(true)
	scene_size = get_viewport().size
	gift_scene = load("res://scn/Gift.tscn")
	for i in range(2):
		spawn_gift()


func _process(delta):
	if get_child_count() <1:
		spawn_gift()


func spawn_gift():
	var gift = gift_scene.instance()
	gift.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	#get_parent().add_child(gift)
	add_child(gift)
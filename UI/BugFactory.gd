extends Node

var scene_size
var bug_scene
var bug_delay = 2
var bug_timer = bug_delay
var bugging_out = false

func _ready():
	scene_size = get_viewport().size
	bug_scene = load("res://scn/Bug.tscn")

func _process(delta):
	if bugging_out:
		bug_timer -= delta
		if bug_timer <= 0:
			bug_timer = bug_delay
			var bug = bug_scene.instance()
			bug.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
			#get_parent().add_child(bug)
			add_child(bug)
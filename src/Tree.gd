extends StaticBody2D

const start_fade_distance = 200
const end_fade_distance = 30
const reappear_distance = 13
var type = "tree"
var spr
var child

func _ready():
	spr = find_node("Sprite")
	child = get_tree().get_root().find_node("Child", true, false)

func _process(delta):
	if child.has_curse("hidden_trees"):
		var distance = (child.position - position).length()
		var fade_ratio
		if distance < reappear_distance:
			fade_ratio = 1
		else:
			fade_ratio = min((distance - end_fade_distance) / start_fade_distance, 1)
		spr.modulate.a = fade_ratio
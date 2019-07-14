extends CanvasLayer

# Declare member variables here. Examples:
var score = 0
var score_display

# Called when the node enters the scene tree for the first time.
func _ready():
	score_display = get_node("Score_Layer/Score_Box/Score_Value")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_score(value):
	score += value
	score_display.text = str(score)
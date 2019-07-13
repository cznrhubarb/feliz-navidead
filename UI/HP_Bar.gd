extends PanelContainer

# Set Default tint to green
var tint = Color(0,1,0) # green
var hp_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO: set "HP_TextureProgress" Progress Tint equal to "tint" var
	pass # Replace with function body.
	hp_bar = get_node("Panel/HP_TextureProgress")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_health(health):
	# Update Label to reflect current / max hp
	# set Tint of TextureProgress to reflect current HP stability level.
	if health > 75:
		tint = Color(0,1,0) # green
	elif health >50:
		tint = Color(1,1,0) # yellow
	elif health >25:
		tint = Color(1,.5,0) # orange
	elif health <25:
		tint = Color(1,0,0) # red
	hp_bar.tint_progress = tint
	hp_bar.value = health	
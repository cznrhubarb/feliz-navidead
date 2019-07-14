extends PanelContainer

# Set Default tint to green
var tint = Color(0,1,0) # green
var hp_bar

func _ready():
	#TODO: set "HP_TextureProgress" Progress Tint equal to "tint" var
	pass # Replace with function body.
	hp_bar = get_node("Panel/HP_TextureProgress")

func update_health(health, max_health = 100):
	var percent = health / float(max_health)
	# Update Label to reflect current / max hp
	# set Tint of TextureProgress to reflect current HP stability level.
	if percent > 0.75:
		tint = Color(0,1,0) # green
	elif percent > 0.50:
		tint = Color(1,1,0) # yellow
	elif percent > 0.25:
		tint = Color(1,.5,0) # orange
	else:
		tint = Color(1,0,0) # red
	hp_bar.tint_progress = tint
	hp_bar.value = 100 * percent
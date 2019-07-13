extends PanelContainer

# Set Default tint to green
var tint = Color(0,1,0) # green

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO: set "HP_TextureProgress" Progress Tint equal to "tint" var
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _update(health):
	# Update Label to reflect current / max hp
	# set Tint of TextureProgress to reflect current HP stability level.
	if health <75:
		tint = Color(1,1,0) # yellow
	elif health <50:
		tint = Color(1,.5,0) # orange
	elif health <25:
		tint = Color(1,0,0) # red
	else:
		tint = Color(0,1,0) # green
	#TODO: set "HP_TextureProgress" Progress Tint equal to "tint" var
extends KinematicBody2D

export var Speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		position.x += Speed * delta
	elif Input.is_action_pressed("move_left"):
		position.x -= Speed * delta
		
	if Input.is_action_pressed("move_up"):
		position.y -= Speed * delta
	elif Input.is_action_pressed("move_down"):
		position.y += Speed * delta

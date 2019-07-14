extends Particles2D

func _ready():
	rotation -= 3.14159 * 0.35
	process_material.gravity = process_material.gravity.rotated(Vector3.FORWARD, -3.14159 * 0.35)
	if name.begins_with("Right"):
		process_material = process_material.duplicate()
		flip()

func flip():
	rotation -= 3.14159 * 0.30
	process_material.gravity = process_material.gravity.rotated(Vector3.FORWARD, -3.14159 * 0.30)
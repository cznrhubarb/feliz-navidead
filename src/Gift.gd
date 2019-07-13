extends KinematicBody2D
const Factory = preload("res://src/Weapons/WeaponFactory.gd")

var weapon
var curse

func _ready():
	weapon = Factory.make_weapon()
	curse = null

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2())
	if collision_info:
		var tree = get_tree()
		var dialog = tree.get_root().find_node("GiftDialog", true, false)
		dialog.weapon = weapon
		dialog.curse = curse
		dialog.visible = true
		tree.paused = true
		
		queue_free()

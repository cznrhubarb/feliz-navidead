extends KinematicBody2D
const Factory = preload("res://src/Weapons/WeaponFactory.gd")

var weapon
var curse
var last_collision
var dialog
var type = "gift"

func _ready():
	dialog = get_tree().get_root().find_node("GiftDialog", true, false)
	weapon = Factory.make_weapon()
	curse = null

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2())
	if collision_info and collision_info.collider.type == "child":
		if not last_collision:
			last_collision = collision_info
			dialog.set_weapon(weapon)
			dialog.set_curse(curse)
			dialog.gift = self
			dialog.visible = true
	elif last_collision:
		last_collision = null
		dialog.visible = false

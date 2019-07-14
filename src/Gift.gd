extends KinematicBody2D
const Factory = preload("res://src/Weapons/WeaponFactory.gd")

var weapon
var curse
var last_collision
var dialog
var type = "gift"

func _ready():
	var anim = find_node("AnimationPlayer")
	anim.play("Burn", -1, 0.75)
	anim.seek(rand_range(0, anim.current_animation_length))
	
	dialog = get_tree().get_root().find_node("GiftDialog", true, false)
	weapon = Factory.make_weapon()
	curse = get_tree().get_root().find_node("CurseBag", true, false).get_curse()

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2())
	if collision_info:
		if not last_collision and collision_info.collider.type == "child":
			last_collision = collision_info
			dialog.set_weapon(weapon)
			dialog.set_curse(curse)
			dialog.gift = self
			dialog.visible = true
	elif last_collision:
		last_collision = null
		dialog.visible = false

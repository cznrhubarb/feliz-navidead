extends KinematicBody2D
const Factory = preload("res://src/Weapons/WeaponFactory.gd")

var weapon
var curse

func _ready():
	weapon = Factory.make_weapon()
	#weapon = load("res://src/Weapons/BaseWeapon.gd").new()
	curse = null

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2())
	if collision_info:
		collision_info.collider.add_weapon(weapon)
		collision_info.collider.add_curse(curse)
		queue_free()

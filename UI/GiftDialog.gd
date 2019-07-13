extends Container

var weapon
var curse
var gift
onready var child = get_tree().get_root().find_node("Child", true, false)

func _ready():
	find_node("Panel").modulate.a = 0.6

func set_weapon(wpn):
	if not child.has_curse("gift_horse"):
		find_node("WeaponText").text = wpn.description
	weapon = wpn

func set_curse(crs):
	if not child.has_curse("gift_horse"):
		find_node("CurseText").text = crs.description
	curse = crs

func _on_Open_pressed():
	child.add_weapon(weapon)
	child.add_curse(curse)
	gift.queue_free()
	visible = false

extends Container

var weapon
var curse
var gift

func _ready():
	find_node("Panel").modulate.a = 0.6

func set_weapon(wpn):
	find_node("WeaponText").text = wpn.description
	weapon = wpn

func set_curse(crs):
	#find_node("CurseText").text = crs.description
	curse = crs

func _on_Open_pressed():
	var child = get_tree().get_root().find_node("Child", true, false)
	child.add_weapon(weapon)
	child.add_curse(curse)
	gift.queue_free()
	visible = false

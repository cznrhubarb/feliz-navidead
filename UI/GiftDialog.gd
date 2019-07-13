extends Panel

var weapon
var curse

func _on_Open_pressed():
	var tree = get_tree()
	var child = tree.get_root().find_node("Child", true, false)
	child.add_weapon(weapon)
	child.add_curse(curse)
	visible = false
	get_tree().paused = false

func _on_NoThanks_pressed():
	visible = false
	get_tree().paused = false

extends StaticBody2D

# variables
var type = "pickup"

func _ready():
	pass
	
func _on_PickupZone_body_entered(body):
	if body.type == "child":
		picked_up(body)

func picked_up(player):
	if player.health < 100:
		player.health += 20
		player.update_health()
		player.game_hud.add_score(20)
		queue_free()

extends Node

var curses

func _ready():
	fill_curse_bag()

func fill_curse_bag():
	curses = [
		{ 
			key = "gift_horse",
			description = "You will never look a gift horse in the mouth again.",
			effect = "no curse or weapon descriptions"
		},
		{ 
			key = "quake",
			description = "You will feel the earth move under your feet.",
			effect = "violent constant camera shake"
		},
		{ 
			key = "lego",
			description = "Sometime in the next month, in real life, you are going to step on a lego barefoot.",
			effect = "nothing"
		},
		{ 
			key = "reverse_shot",
			description = "You will always be looking back over your shoulder.",
			effect = "fire in reverse"
		},
		{ 
			key = "reverse_run",
			description = "You will always be running behind.",
			effect = "walk  in reverse"
		},
		{ 
			key = "hidden_trees",
			description = "You won't be able to see the forest for the trees.",
			effect = "invisible trees"
		},
		{
			key = "penalty",
			description = "You will start working on a great golf score.",
			effect = "lose points"
		},
		# ================ Completed above this line =====================
		{ 
			key = "locusts",
			description = "You will suffer from a swarm of locusts.",
			effect = "crawling bugs on screen"
		},
		{ 
			key = "enemy_bullets",
			description = "You will realize turn about is fair play.",
			effect = "enemies fire bullets now"
		},
		{ 
			key = "weapon_jams",
			description = "Your weapons will get you into a sticky situation.",
			effect = "weapons jam occasionally"
		},
		{ 
			key = "confetti",
			description = "You will learn to celebrate the small wins.",
			effect = "each enemy kill causes a shit ton of confetti to spray out all over the screen"
		},
#		{ 
#			key = "frog_kiss",
#			description = "You are turned into a frog until you are next kissed.",
#			effect = "frog sprite, move speed slower and jumpy"
#		},
	]

func get_curse(specific_curse_name = "locusts"):
	if specific_curse_name != null:
		for curse in curses:
			if curse.key == specific_curse_name:
				return curse
	
	if curses.size():
		fill_curse_bag()
	
	var index = randi() % curses.size()
	var curse = curses[index]
	curses.remove(index)
	
	return curse
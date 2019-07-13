extends Node

var curses

func _ready():
	fill_curse_bag()

func fill_curse_bag():
	curses = [
		{ 
			description = "You won't be able to see the forest for the trees.",
			effect = "invisible trees"
		},
		{ 
			description = "You will never look a gift horse in the mouth again.",
			effect = "no curse or weapon descriptions"
		},
		{ 
			description = "You will suffer from a swarm of locusts.",
			effect = "crawling bugs on screen"
		},
		{ 
			description = "You will feel the earth move under your feet.",
			effect = "violent constant camera shake"
		},
		{ 
			description = "You will always be looking back over your shoulder.",
			effect = "walk and fire in reverse"
		},
		{ 
			description = "Sometime in the next month, in real life, you are going to step on a lego barefoot.",
			effect = "nothing"
		},
		{ 
			description = "You will realize turn about is fair play.",
			effect = "enemies fire bullets now"
		},
		{ 
			description = "Your weapons will get you into a sticky situation.",
			effect = "weapons jam occasionally"
		},
		{ 
			description = "You will learn to celebrate the small wins.",
			effect = "each enemy kill causes a shit ton of confetti to spray out all over the screen"
		},
#		{ 
#			description = "You are turned into a frog until you are next kissed.",
#			effect = "frog sprite, move speed slower and jumpy"
#		},
	]

func get_curse():
	if curses.size():
		fill_curse_bag()
	
	var index = randi() % curses.size()
	var curse = curses[index]
	curses.remove(index)
	
	return curse
extends Node

var ginger_scene = load("res://scn/GingerBreadMan.tscn")
var santa_scene = load("res://scn/Santa.tscn")
var elf_scene = load("res://scn/Elf.tscn")
var time_start
var time_now
var scene_size
var minutes = 0
var seconds = 0
var elapsed = 0
var ginger_count = 0
var elf_count = 0
var santa_count = 0
var last_santa = 0


func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	scene_size = get_viewport().size
	
	for i in range(2):
		spawn_ginger()

func _process(delta):
	time_now = OS.get_unix_time()
	elapsed = time_now - time_start
	minutes = elapsed / 60
	seconds = elapsed % 60
	print(elapsed)
	print(last_santa)
	print(santa_count)
	print(seconds > last_santa and santa_count <1)
	
	

	# TODO: Create spawn points, and use random spawn points off-screen to spawn enemies
	if ginger_count < seconds / 5:
		spawn_ginger()
		
	if elapsed > last_santa + 15 and santa_count <1:
		spawn_santa()

	if elf_count < clamp((seconds / 15), 0, 20):
		spawn_elf()

	
func spawn_ginger():
	ginger_count += 1
	var ginger = ginger_scene.instance()
	ginger.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	ginger.max_health = 20 + (seconds/2) + randi() % 20
	ginger.damage = .1 + (elapsed/100)
	ginger.Speed = 10 + (elapsed/5)
	add_child(ginger)
	
func spawn_elf():
	elf_count += 1
	var elf = elf_scene.instance()
	elf.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	elf.max_health = 20 + ((elapsed/100))
	elf.damage = 10
	elf.Speed = 50 + (elapsed/5)
	add_child(elf)

	
func spawn_santa():
	santa_count += 1
	var santa = santa_scene.instance()
	santa.position = Vector2(rand_range(0, scene_size.x), rand_range(0, scene_size.y))
	add_child(santa)
	print("santa spawned")
	
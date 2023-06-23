extends Node2D

var screen
var spawn_speed = Vector2(0.250, 1.500) #milliseconds to find a random time between each spawn
var rate_of_bad = 8

var rate_of_bad_spawn = 500
var rate_of_good_spawn = 1000
#Possibly make it so the fruit spawn in Left Center or Right, within a certain amount of each, overlapping
func _ready():
	screen = get_viewport_rect().size
	#Set timer spawn rate
	$Timer.wait_time = rand_range(spawn_speed.x, spawn_speed.y)
	
	$Timer.start()
	

func _on_Timer_timeout():
	var rand_fruit = randi() % 10
	var bad_fruit = randi() % 10
	
	#changing the bad fruit spawn rate
	if bad_fruit > rate_of_bad:
		if Global.total_points > rate_of_bad_spawn and rate_of_bad != 2:
			rate_of_bad_spawn += 500
			rate_of_bad - 1
		var bad_piece = load("res://Not_Fruit.tscn").instance()
		bad_piece.global_position = Vector2(rand_range(30, screen.x - 30), -30)
		$Items.add_child(bad_piece)
		
	#changes the spawn rate of spawning things
	if Global.total_points > rate_of_good_spawn and spawn_speed.x > 0.15:
		spawn_speed.x -= 0.04
		spawn_speed.y -= 0.07
		rate_of_good_spawn += 1000
	var piece = load("res://Fruit.tscn").instance()
	piece.global_position = Vector2(rand_range(30, screen.x - 30), -30)
	
	$Items.add_child(piece)
	
	$Timer.wait_time = rand_range(spawn_speed.x, spawn_speed.y)


func _on_ExtraTimeSpawner_timeout():
	if Global.can_create_extra_time:
		Global.can_create_extra_time = false
		var t = load("res://Time.tscn").instance()
		t.global_position = Vector2(rand_range(30, screen.x - 30), -30)
		add_child(t)

#stops the fruit and not fruit from spawning
func stop():
	$Timer.stop()
	$ExtraTimeSpawner.stop()
	for i in $Items.get_children():
		i.points = 0

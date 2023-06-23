extends RigidBody2D

var points
var collected = false

func _ready():
	randomize()
	var r = randi() % 40
	if r > 0 and r < 20:
		#Apple
		$Sprite.texture = Global.fruit_images[0]
		points = 50
		change_speed(0)
	elif r > 19 and r < 33:
		#Cherries
		$Sprite.texture = Global.fruit_images[1]
		points = 100
		change_speed(1)
	else:
		#Bananas
		$Sprite.texture = Global.fruit_images [2]
		points = 150
		change_speed(2)


func change_speed(num):
	
	if num == 0:
		gravity_scale = rand_range(1.0, 2.0)
	elif num == 1:
		gravity_scale = rand_range(1.0, 3.0)
	elif num == 2:
		gravity_scale = rand_range(1.5, 4.0)


func _on_VisibilityNotifier2D_screen_exited():
	if !collected:
		var bad_points = -points/2
		Global.total_points += bad_points
		Global.emit_signal("fruit_not_collected")
		queue_free()

func collected():
	Global.play_sfx("res://Assets/Sounds/good_item.wav")
	collected = true
	Global.good_fruit_collected += 1
	Global.total_points += points
	Global.emit_signal("collected_fruit")
	queue_free()

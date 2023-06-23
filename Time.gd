extends RigidBody2D

var time_to_add = 0

func _ready():
	randomize()
	var r = randi() % 100
	
	if r < 85:
		$Sprite.texture = Global.time_images[0]
		time_to_add = 10
	elif r > 84 and r < 97:
		$Sprite.texture = Global.time_images[1]
		time_to_add = 20
	else:
		$Sprite.texture = Global.time_images[2]
		time_to_add = 30

func collected():
	Global.emit_signal("collected_time", time_to_add)
	Global.play_sfx("res://Assets/Sounds/time_item.wav")
	Global.timers_collected += 1
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

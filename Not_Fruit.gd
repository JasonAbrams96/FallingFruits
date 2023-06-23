extends RigidBody2D

var points
var collected = false

func _ready():
	randomize()
	var s = randi() % 40
	
	#Chooses a random not fruit to set this not fruit as
	if s < 23:
		$Sprite.texture = Global.not_fruit_images[0]
		points = -55
		
	elif s > 22 and s < 33:
		$Sprite.texture = Global.not_fruit_images[1]
		points = -110
	else:
		$Sprite.texture = Global.not_fruit_images[2]
		points = -165

#Sets the speed of the not fruit to fall either faster or slower
func set_speed():
	gravity_scale = rand_range(1.75, 5.0)

#cleans up if no on screen, ie fell past the basket
func _on_VisibilityNotifier2D_screen_exited():
	if !collected:
		queue_free()

#Collected function
func collected():
	Global.play_sfx("res://Assets/Sounds/bad_item.wav")
	collected = true
	Global.bad_fruit_collected += 1
	Global.total_points += points
	Global.emit_signal("collected_not_fruit")
	queue_free()

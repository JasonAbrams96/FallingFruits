extends Node

var time_left = 60
var time_til_start = 3

func _ready():
	Global.the_current_scene = self
	$Countdown/CountdownTimer.start()
	Global.connect("collected_time", self, "update_time")
	get_tree().paused = true
	
func _on_TimeTimer_timeout():
	time_left -= 1
	update_HUD_time(time_left)

func update_HUD_time(time):
	$HUD.update_time(time_left)
	if time_left == 0:
		$TimeTimer.stop()
		$FruitSpawning.stop()
		$Basket.stop()
		
		var gos = load("res://Menus/GameOver.tscn").instance()
		add_child(gos)

func update_time(t):
	time_left += t
	update_HUD_time(time_left)
	
func _on_CountdownTimer_timeout():
	time_til_start -= 1

	
	if time_til_start == 0:
		$Countdown/ColorRect/Label.text = "START!"
		$Countdown/CountdownTimer.wait_time = 0.5
	elif time_til_start == -1:
		get_tree().paused = false
		$TimeTimer.start()
		$Countdown.queue_free()
	else:
		$Countdown/ColorRect/Label.text = str(time_til_start)


func _on_TextureButton_pressed():
	get_tree().paused = false
	Global.clear()
	get_tree().change_scene("res://Menus/Main Menu.tscn")

extends Control

var panel_num = 0
var max_panel_num = 3

func _ready():
	Global.the_current_scene = self
	Global.play_music(-1)
	#Open file to read High Scores from
	var scores_labels = $SlideShow/HighScore/VBoxContainer.get_children()
	for i in range(Global.high_scores.size()):
		var arr = Global.high_scores[i].split(",")
		scores_labels[i].text = arr[0] + ("%25s" % arr[1]) # buffers white spaces between the name and numbers


func _on_LeftArrow_pressed():
	$LeftArrow.disabled = true
	panel_num += 1
	
	if !$SlideShowTween.is_active():
		$SlideShowTween.interpolate_property($SlideShow, "rect_position", $SlideShow.rect_position, Vector2(-448.0 * panel_num, 0.0), 1.0, Tween.TRANS_LINEAR)
		$SlideShowTween.start()
		
	if panel_num >= max_panel_num:
		panel_num = -1
		
		
#func _on_RightArrow_pressed():
#
#	panel_num -= 1
#
#	if !$SlideShowTween.is_active():
#		$SlideShowTween.interpolate_property($SlideShow, "rect_position", $SlideShow.rect_position, Vector2(-448.0 * panel_num, 0.0), 1.0, Tween.TRANS_LINEAR)
#		$SlideShowTween.start()
#
#	if panel_num <= -1:
#		panel_num = 3


func _on_PlayButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_OptionsButton_pressed():
	$Options.visible = true


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_AckButton_pressed():
	$Acknowledgements.visible = true


func _on_SlideShowTween_tween_all_completed():
	$LeftArrow.disabled = false

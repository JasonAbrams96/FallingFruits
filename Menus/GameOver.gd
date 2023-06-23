extends Control
var current_char = 0
var max_char = 3
var good_score = false
var p_name = ""


func _ready():
	$ScoreLbl.text += " " + str(Global.total_points)
	if check_score():
		good_score = true
		Global.play_sfx("res://Assets/Sounds/high_score_got.wav")
	else:
		$TextureButton.disabled = false
func check_char(c):
	var my_c = c.to_upper().to_ascii()
	if my_c[0] >= 65 and my_c[0] <= 90:
		return true
	return false
	
func check_name():
	for i in p_name:
		print(i)
		if !check_char(i):
			$TextureButton.disabled = true
			return false
	$TextureButton.disabled = false
	return true
		
# Checks the current score with the scores saved
func check_score():
	for i in Global.high_scores:
		var arr = Global.high_scores[i].split(",")
		if Global.total_points > int(arr[1]):
			$LineEdit.visible = true
			$TextureButton.disabled = true
			return true
	return false
					
			

#Quits back to the main menu and saves scores
func _on_TextureButton_pressed():
	if good_score and check_name():
		Global.check_scores(p_name.to_upper(), Global.total_points)
	Global.clear()
	
	get_tree().change_scene("res://Menus/Main Menu.tscn")
	
	
#checks the Line Edit to make sure it is at length 3 and everything is a text
func _on_LineEdit_text_changed(new_text):
	p_name = $LineEdit.text
	if $LineEdit.text.length() == 3:
		check_name()
	else:
		$TextureButton.disabled = true

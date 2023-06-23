extends Control

func _ready():
	$MasterSlider.value =Global.meta_data["volume_master"]
	$MusicSlider.value = Global.meta_data["volume_music"]
	$SFXSlider.value = Global.meta_data["volume_sfx"]

func _exit_tree():
	Global.write_meta_dat()


func _on_BackButton_pressed():
	Global.write_meta_dat()
	visible = false


func _on_MasterSlider_value_changed(value):
	if value == -20.0:
		zero_volume("Master")
	else:
		Global.change_volume(AudioServer.get_bus_index("Master"), value)

func _on_MusicSlider_value_changed(value):
	if value == -20.0:
		zero_volume("Music")
	else:
		Global.change_volume(AudioServer.get_bus_index("Music"), value)

func _on_SFXSlider_value_changed(value):
	if value == -20.0:
		zero_volume("SFX")
	else:
		Global.change_volume(AudioServer.get_bus_index("SFX"), value)
		
func zero_volume(name):
	Global.change_volume(AudioServer.get_bus_index(name), -80.0)

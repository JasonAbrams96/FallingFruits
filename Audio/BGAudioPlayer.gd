extends AudioStreamPlayer

var offset = 0
var current_song = ""

func replay():
	play(offset)
	
func _ready():
	
	connect("finished", self, "replay")
	
func play_sound(sound_file):
	#Changes the bg music to the new file
	if playing:
		stop()
	
	if sound_file is String:
		current_song = load(sound_file)
		set_stream(current_song)
		play()

extends Node

var the_current_scene = null

#signals used throughout the game
signal update_points(p)
signal collected_fruit(p)
signal collected_not_fruit(p)
signal collected_time(t)
signal fruit_not_collected(p)


#Preloads images that can spawn
var fruit_images = {
	0: preload("res://Assets/fruit1.png"),
	1: preload("res://Assets/fruit2.png"),
	2: preload("res://Assets/fruit3.png")
}

var not_fruit_images = {
	0: preload("res://Assets/beehive.png"),
	1: preload("res://Assets/boot.png"),
	2: preload("res://Assets/mine.png")
}

var time_images = {
	0: preload("res://Assets/10secs.png"),
	1: preload("res://Assets/20secs.png"),
	2: preload("res://Assets/30secs.png")
}

#Variables to control sounds
var volume_master = 1
var volume_music = 1
var volume_sfx = 1

var sfx_player = preload("res://Audio/SEAudioPlayer.tscn")

#Variables for meta data
var total_points = 0
var bad_fruit_collected = 0
var good_fruit_collected = 0
var timers_collected = 0

#variable to allow extra time to be created
var can_create_extra_time = false

#Variables to store and keep track of highscores
var high_scores_file = "Digi.dat"
var high_scores = {}

#	variable to keep track of data used for options
var meta_data_filename = "Meta.dat"
var meta_data = {
	"volume_master" : 1,
	"volume_music" : 1,
	"volume_sfx" : 1,
	"over_5000" : false,
	"over_9000" : false
}

func _ready():
	read_high_scores()
	read_meta_dat()
	
func write_high_scores(first_save):
	var file = File.new()
	file.open("user://" + high_scores_file, File.WRITE)

	# Used to initialize the highscores when the game is first played
	if first_save:
		high_scores = {
			0:"NIM,5000",
			1:"NIM,5000",
			2:"NIM,5000",
			3:"NIM,5000",
			4:"NIM,5000",
		}
	for i in high_scores:
		file.store_string(high_scores[i])
		if i != 4: #Magic number is the max key value for the ditionary
			file.store_string("\n")
	file.close()

	
func read_high_scores():
	var file = File.new()
	file.open("user://" + high_scores_file, File.READ)
	var text = file.get_as_text()
	file.close()
	
	var arr = text.split("\n")
	if arr.size() == 0 or arr.size() == 1: #Fo some reason it comes in as 1 sometimes. IDK
		#Create the file and add the NIMs
		write_high_scores(true)
	else:
		for i in range(5):
			high_scores[i] = arr[i]
			
		
func check_scores(p_name, score):
	if score > 5000 and !meta_data["over_5000"]:
		meta_data["over_5000"] = true
	elif score > 9000 and !meta_data["over_9000"]:
		meta_data["over_9000"] = true
		
	var current_scores = []
	var max_scores_num = 5
	#	Go through dictionary and find the scores
	for i in range(high_scores.size()):
		# I use 1 in array t because that should always be a number
		var t = high_scores[i].split(",")
		if int(t[1]):
			current_scores.append(int(t[1]))
		else:
			print("Global, Check_Scores, split")
			
			
	#	`Now check the scores in current scores with the one that came in to this func
	#		If it is greater than /equal to then replace
	current_scores.append(score)
	high_scores[5] = p_name + "," + str(score)
	
	var max_count = 5
	
	#	Sort the dictionary based on score
	for i in range(current_scores.size()):
		for j in range(max_count):
			
			if i + 1 == 6:
				break
				
			if current_scores[j] < current_scores[j+1]:
				var tmp = current_scores[j]
				current_scores[j] = current_scores[j+1]
				current_scores[j+1] = tmp
				max_count -= 1
				
				tmp = high_scores[j]
				high_scores[j] = high_scores[j+1]
				high_scores[j+1] = tmp
			
	#	Dropping the last score to keep only 5 scores in check
	high_scores.erase(5)
	write_high_scores(false)
	
func write_meta_dat():
	var file = File.new()
	var data = meta_data
	file.open("user://" + meta_data_filename, File.WRITE)
	file.store_var(data)
	file.close()
	
func read_meta_dat():
	var file = File.new()
	#Checks to make sure the file exists
	var err = file.open("user://" + meta_data_filename, File.READ)
	if err != 0:
		write_meta_dat()
		
	#reads in the data
	var data
	
	data  = file.get_var()
	file.close()

	#sets the meta data
	if data != null:
		meta_data = data
	
func change_volume(audio_channel, value):
	AudioServer.set_bus_volume_db(audio_channel, value)
	if audio_channel == 0:
		meta_data["volume_master"] = value
	elif audio_channel == 1:
		meta_data["volume_music"] = value
	elif audio_channel == 2:
		meta_data["volume_sfx"] = value
	
	
func play_music(music_num):
	var music
	if music_num < 0:
		music = "res://Assets/Sounds/StartMenu1.ogg" if randi() % 100 < 98 else "res://Assets/Sounds/StartMenu2.ogg"
		
	elif music_num > 0:
		if music_num == 1:
			music = "res://Assets/Sounds/w1.ogg"
		elif music_num == 2:
			music = "res://Assets/Sounds/w2.ogg"
		elif music_num == 3:
			music = "res://Assets/Sounds/w3.ogg"
	BgAudioPlayer.play_sound(music)
	
	
func play_sfx(sfx_location):
	var audio = load(sfx_location)
	var my_sfx = sfx_player.instance()
	the_current_scene.add_child(my_sfx)
	my_sfx.play_sound(audio)
		
func clear():
	total_points = 0
	timers_collected = 0
	bad_fruit_collected = 0
	good_fruit_collected = 0
	can_create_extra_time = false
	
	
	
	
	
	

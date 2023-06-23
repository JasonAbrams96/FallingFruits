extends Node

var shaders = {
	1:preload("res://Shaders/ElectronicWaves.gdshader"),
	2:preload("res://Shaders/Circle.gdshader"),
	3:preload("res://Shaders/Swoosh.gdshader")
}

func _ready():
	randomize()
	if Global.meta_data["over_5000"] and Global.meta_data["over_9000"]:
		var rand = randi() % 100
		print(rand)
		if rand < 32:
			$Background0.visible = true
			Global.play_music(1)
		elif rand < 65:
			$Background1.material.shader = shaders[1]
			$Background0.visible = false
			$Background1.visible = true
			Global.play_music(3)
		elif rand < 100:
			$Background0.visible = false
			$Background1.visible =true
			$Background2.visible = true
			
			$Background1.material.shader = shaders[2]
			$Background2.material.shader = shaders[3]
			
			var mat = $Background1.material
			var nt = NoiseTexture.new()
			nt.seamless = true
			nt.noise = OpenSimplexNoise.new()
			nt.noise.octaves = 3
			nt.noise.period = 64
			nt.noise.persistence = 0.5
			nt.noise.lacunarity = 2
			nt.noise.seed = 357
			mat.set_shader_param("noiseTexture", nt)
			mat.set_shader_param("speed", 0.05)
			
			Global.play_music(2)
	elif Global.meta_data["over_5000"]:
		var rand = randi() % 100
		print(rand)
		if rand < 49:
			$Background0.visible = true
			Global.play_music(1)
		elif rand < 99:
			$Background1.material.shader = shaders[1]
			$Background0.visible = false
			$Background1.visible = true
			Global.play_music(2)
	else:
		Global.play_music(1)

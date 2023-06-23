extends Area2D

var max_movement = 12
var current_movement = 0
var dir = 0
var screen
var track_time_spawn = 1
var can_move = true
var can_collect = true

func _ready():
	#Gets the screen size
	screen = get_viewport_rect().size.x - 64 
	
func _physics_process(delta):
	
	if can_move:
		if Input.is_action_pressed("ui_left"):
			dir = -1
		elif Input.is_action_pressed("ui_right"):
			dir = 1
		else:
			if current_movement > 0:
				current_movement -= 1
			dir = 0

		if dir == 1 or dir == -1:
			current_movement += 1 
			if current_movement > max_movement:
				current_movement = max_movement

			global_position.x += dir * current_movement
			
			global_position.x = clamp(global_position.x, 64, screen)



func movement_check():
	current_movement += 1
	
	if current_movement > max_movement:
		current_movement = max_movement


func _on_Basket_body_entered(body):
	if can_collect:
		if body.is_in_group("item_good"):
			body.collected()
		elif body.is_in_group("item_bad"):
			body.collected()
		elif body.is_in_group("time"):
			body.collected()
			
		if Global.total_points % (500 * track_time_spawn) == 0:
			Global.can_create_extra_time = true
			track_time_spawn += 1

func stop():
	can_move = false
	can_collect = false
	set_collision_layer_bit(0, false)

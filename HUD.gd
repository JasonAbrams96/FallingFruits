extends CanvasLayer

var amount_til_check_again = 1500
func _ready():
	Global.connect("collected_fruit", self, "update_points")
	Global.connect("fruit_not_collected", self, "update_points")
	Global.connect("collected_not_fruit", self, "update_points")
	pass

func update_points():
	if Global.total_points >= amount_til_check_again:
		amount_til_check_again += 1500
		Global.can_create_extra_time
	$ColorRect/PointsLabel.text = str(Global.total_points)
	
func update_time(new_time):
	$ColorRect/TimeLabel.text = str(new_time)

extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var line

func _process(delta):


	if Input.is_action_just_pressed("click"): # check for click
		click()
	if Input.is_action_just_pressed("right_click"):
		delete_points()
func click(): 
	line.add_point(get_global_mouse_position()) #create a Line2D point on mouse position
func delete_points():
	line.clear_points()

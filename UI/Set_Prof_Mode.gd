extends "set_visibility.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_play_mode_visbility():
	print(".")
	if global.play_mode:
		visible = true
	else:
		visible = false

func _on_Button_pressed():
	global.professor_mode = !global.professor_mode

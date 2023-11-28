extends Node2D

var game_mode_ui = false

func set_visibility():
	#print(self)
	if int(global.professor_mode) ^ int(game_mode_ui):
		visible = true
	else:
		visible = false

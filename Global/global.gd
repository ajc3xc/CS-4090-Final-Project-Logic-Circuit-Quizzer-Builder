extends Node

#check if node or drop down menu is being dragged
var is_dragging = false
var node_selected = false

#enable / disable professor mode
var professor_mode = true setget set_professor_mode

#emit signal that professor mode was changed
signal change_professor_mode()

func set_professor_mode(val: bool):
	professor_mode = val
	#change_professor_mode.emit()
	emit_signal("change_professor_mode", self)
	get_tree().call_group("gates", "set_background_sprite_visibility")
	get_tree().call_group("UI", "set_visibility")

extends "res://Gates/gate.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	create_visible_nodes_list()




func _on_LineEdit_mouse_entered():
	if not global.is_dragging and global.professor_mode:
		draggable = true


func _on_LineEdit_mouse_exited():
	if not global.is_dragging and global.professor_mode:
		draggable = false
		
func set_visibility():
	print(".")


func _on_LineEdit_text_entered(new_text):
	pass # Replace with function body.

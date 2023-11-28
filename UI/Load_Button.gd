extends Node2D



func _ready():
	pass # Replace with function body.





func _on_LineEdit_text_entered(new_text):
	var scene_name = new_text
	#var level = get_tree().get_root().get_child(child)
	#get_tree().get_root().remove_child(level)
	#level.call_deferred("free")
	if scene_name != "":
		get_tree().change_scene("res://game_simulator.tscn")
		#get_tree().change_scene("res://"+scene_name+".tscn")
		#clear out any gates currently in the scene
		print(get_tree().get_root().get_children())
		for child in get_tree().get_root().get_children():
			if child.is_in_group("gates") or child.name == "save_node":
				get_tree().get_root().remove_child(child)
				child.queue_free()
		
		print(get_tree().get_root().get_children())
		var packed_scene = load("res://"+scene_name+".tscn")
		
		#clear out any gates currently in the scene
		
		var imported_scene = packed_scene.instance()
		get_tree().get_root().add_child(imported_scene)
		for gate in imported_scene.get_children():
			print(gate)
	else:
		print("Invalid Scene")

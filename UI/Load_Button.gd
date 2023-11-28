extends Node2D



func _ready():
	pass # Replace with function body.





func _on_LineEdit_text_entered(new_text):
	var scene_name = new_text
	#var level = get_tree().get_root().get_child(child)
	#get_tree().get_root().remove_child(level)
	#level.call_deferred("free")
	if scene_name != "":
		get_tree().change_scene("res://"+scene_name+".tscn")
		#var packed_scene = load("res://"+scene_name+".tscn")
		#var my_scene = packed_scene.instance()
		#get_tree().get_root().add_child(my_scene)
		print("new scene loaded")
	else:
		print("Invalid Scene")

extends Node2D



func _ready():
	pass # Replace with function body.





func _on_LineEdit_text_entered(new_text):
	var scene_name = new_text
	
	if scene_name != "":
		var packed_scene = load("res://"+scene_name+".tscn")
		var my_scene = packed_scene.instance()
		add_child(my_scene)
	else:
		print("Invalid Scene")

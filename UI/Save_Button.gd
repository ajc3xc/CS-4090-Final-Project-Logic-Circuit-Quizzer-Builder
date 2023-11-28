extends Node2D




func _ready():
	pass # Replace with function body.




func _on_LineEdit_text_entered(new_text):
	var new_scene = new_text
	
	if new_scene != "":
		var packed_scene = PackedScene.new()
		packed_scene.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://saves"+new_scene+".tscn", packed_scene)
	else:
		print("Error: Couldn't save empty scene")

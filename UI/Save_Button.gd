extends Node2D





func _ready():
	pass # Replace with function body.




func _on_LineEdit_text_entered(new_text):
	var new_scene = new_text
	var save_scene = PackedScene.new()
	var save_node = Node2D.new()
	save_node.name = "save_node"
	var saved_gates = []
	if new_scene != "":
		for child in get_tree().get_root().get_children():
			if child.is_in_group("gates"):
				#print(".")
				#remove child from root node, add to save node
				get_tree().get_root().remove_child(child)
				save_node.add_child(child)
				saved_gates.append(child)
				#child.set_owner(save_node)
				#for a in child.get_children():
				#	a.set_owner(save_node)
#				#ave_scene.pack(child)
#				save_node.add_child(child)
#				child.owner = save_node
#			else:
#				pass
				#rint("Node saved")
		#print(save_node.get_children())
		for child in save_node.get_children():
			 child.set_owner(save_node)
		print(save_node.get_children())
		save_scene.pack(save_node)
		ResourceSaver.save("res://saves/"+new_scene+".tscn", save_scene)
		
		#now that the scene is saved, reload the gates back into the scene
		for gate in saved_gates:
			#remove from save node, add back to root node
			save_node.remove_child(gate)
			get_tree().get_root().add_child(gate)
			
	else:
		print("Error: Couldn't save empty scene")

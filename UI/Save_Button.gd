extends "res://UI/set_visibility.gd"

func _ready():
	pass # Replace with function body.




func _on_LineEdit_text_entered(save_file_name):
	#testing
	#save_file_dict()
	var new_scene = save_file_name
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
		
		print(save_node.get_children())
		for gate in save_node.get_children():
			gate.set_owner(save_node)
			#gate.test_var = true
			#for child in gate.get_children():
			#	if child in gate.visible_line_nodes:
			#		print(child)
			#		child.name += "_saved"
			#		child.set_owner(save_node)
			#recursively_set_ownership(child, save_node)
			
		print(save_node.get_children())
		for gate in save_node.get_children():
			print(gate.test_var)
		save_scene.pack(save_node)
		ResourceSaver.save("res://saves/"+new_scene+".tscn", save_scene)
		
		#now that the scene is saved, reload the gates back into the scene
		for gate in saved_gates:
			#remove from save node, add back to root node
			save_node.remove_child(gate)
			get_tree().get_root().add_child(gate)
			
		#save_file_dict(saved_gates)
			
	else:
		print("Error: Couldn't save empty scene")

#func save_file_dict(saved_gates):
#	var file = File.new()
#	var save_file_path = "res://saves/test.out"
#	file.open(save_file_path, file.WRITE)
#	file.store_var("test")
#	file.close()
	
	
#set ownership of child node and all its descendants to the save node
#func recursively_set_ownership(node, save_node):
#	if node.is_in_group("line_node")
#		node.name += "_saved"
#		node.set_owner(save_node)
#		for child in node.get_children():
#			recursively_set_ownership(child, save_node)

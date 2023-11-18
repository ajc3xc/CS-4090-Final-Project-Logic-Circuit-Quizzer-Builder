extends Node2D


#prevent nodes in the same gate from connecting
func disable_gate_nodes_connecting():
	var child_line_nodes = []
	
	for child in get_children():
		if child.is_in_group("line_node"):
			child_line_nodes.append(child)
	
	#set their list of gate nodes
	for child in get_children():
		if child.is_in_group("line_node"):
			child.gate_nodes = child_line_nodes
	

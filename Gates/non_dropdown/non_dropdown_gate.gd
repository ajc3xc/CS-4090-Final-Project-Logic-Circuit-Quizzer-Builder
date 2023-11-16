extends Node2D


onready var label = get_node("Label")
var label_text = "None"

#set visibility of gates
#changed in inherited classes
var show_in_node = false
var show_out_node = false
func setup_gate():
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#get list of child line nodes
	setup_gate()
	var child_line_nodes = []
	var label = get_node("Label")
	for child in get_children():
		if child.is_in_group("line_node"):
			child_line_nodes.append(child)
	
	#set their list of gate nodes
	for child in get_children():
		if child.is_in_group("line_node"):
			child.gate_nodes = child_line_nodes
	
	label.text = label_text
	if show_in_node:
		get_node("in").show()
	if show_out_node:
		get_node("out").show()

extends Node2D

#store path of gateColor child node, and size of bounding box
onready var gateColor= get_node("gateColor")
var gateSize

#variables for dragging around node
var draggable = false
var original_invalid_color

#store in and out child nodes
#necessary for when changing their connected lines, if they are moving
onready var in_node = get_node("in")
onready var out_node = get_node("out")

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
	disable_gate_nodes_connecting()
	var label = get_node("Label")
	
	label.text = label_text
	if show_in_node:
		get_node("in").show()
	if show_out_node:
		get_node("out").show()
	
	gateSize = gateColor.get_size()
	
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

#automatically changes the color if gate entered / exited
#this is only called if a line isn't actively being drawn
func _on_gateColor_mouse_entered():
	#check if color was changed
	if not global.is_dragging and not global.node_selected:
		#print("area entered")
		global.node_selected = true
		if not Input.is_action_pressed("left_click"):
			gateColor.color = Color.darkgray
			print("enabling dragging")
			draggable = true
		else:
			#visually show that this node can't be selected
			#save original circle color
			gateColor.color = Color.red

#
func _on_gateColor_mouse_exited():
	if not global.is_dragging:
		gateColor.color = Color.black
		global.node_selected = false
		draggable = false
		
func _physics_process(delta):
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			global.is_dragging = true
		elif Input.is_action_pressed("left_click"):
			#move center of object to mouse position
			var pos_delta = get_global_mouse_position() - gateSize / 2 - global_position
			global_position = get_global_mouse_position() - gateSize / 2
			in_node.adjust_connections_when_node_moved(pos_delta)
			out_node.adjust_connections_when_node_moved(pos_delta)
		elif Input.is_action_just_released("left_click"):
			global.is_dragging = false

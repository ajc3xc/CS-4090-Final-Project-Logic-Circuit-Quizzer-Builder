tool
extends Node2D

#variables for circle
var circle_radius = 40
var circle_color = Color.black
var circle_position = Vector2.ZERO

#variables for line drawn
var line_end = Vector2.ZERO #where the line ends
var hovered_over = false #stores whether cursor is hovering over line node
var is_connected = false
var connected_node = null #node that this node connects to

#load line from memory
onready var line = get_node("line")

var offset: Vector2
var initialPos: Vector2

var draggable = false

#var node_to_clear = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize first two points
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)
	#line.set_point_position(1, Vector2.ZERO+Vector2(100, 100))
	add_child(line)
	if is_instance_valid(line):
		print(".")
	global.line_nodes[self] = {"start": global_position,
							"end": Vector2.ZERO,
							"color": circle_color}
	update()

#drawing is very problematic, so I'm clobbering together a quick fix
func _draw():
	line.set_point_position(1, global.line_nodes[self]["end"])
	draw_circle(circle_position, circle_radius, global.line_nodes[self]["color"])
		

#change circle color, reset circle position (just in case)
func change_circle_color(new_color: Color):
	circle_position = Vector2.ZERO
	global.line_nodes[self]["color"] = new_color
	circle_color = new_color
	update()

#draw connecting line from circle
func draw_connecting_line(mouse_position: Vector2):
	global.line_nodes[self]["end"] = mouse_position
	update()

#automatically changes the color if circle entered / exited
func _on_Area2D_mouse_entered():
	hovered_over = true
	if not global.is_dragging:
		draggable = true
		change_circle_color(Color.white)

#reset variable and colors
func reset_circle():
	draggable = false
	change_circle_color(Color.black)

func _on_Area2D_mouse_exited():
	hovered_over = false
	if not global.is_dragging and not connected_node:
		reset_circle()

func _physics_process(delta):
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			print("pressed start")
			for member in get_tree().get_nodes_in_group("line_node"):
				member
			if connected_node:
				connected_node.reset_circle()
				#connected_node.draw_connecting_line(connected_node.circle_position)
				connected_node = null
				
			#make current 
			global.is_dragging = true
		if Input.is_action_pressed("left_click"):
			offset = get_global_mouse_position() - global_position
			draw_connecting_line(offset)
			#variable storing whether a member is already connected
			#ensures only one member can be connected to
			var no_connecting_members = true
			for member in get_tree().get_nodes_in_group("line_node"):
				#check if the node isn't the current one, and it isn't
				#already connected to another node
				if member != self and not is_connected:
					#if so, check if it is currently being hovered over
					if member.hovered_over and no_connecting_members:
						member.change_circle_color(Color.white)
						connected_node = member
						no_connecting_members = false
					else:
						member.change_circle_color(Color.black)
					
			if no_connecting_members:
				connected_node = null
			
		if Input.is_action_just_released("left_click"):
			print("released")
			#print(str(global.line_nodes[self]["start"])+" "+str(global.line_nodes[self]["end"]))
			global.is_dragging = false
			if connected_node:
				#global.line_nodes
				draw_connecting_line(offset)
				connected_node.connected_node = self
			else:
				#draw_connecting_line(Vector2(-116, -67))
				#for member in get_tree().get_nodes_in_group("line_node"):
				#	draw_line()
				#	print(global.line_nodes[member]["start"] - global.line_nodes[member]["end"])
				reset_circle()
				
				
				#print(global.line_nodes.keys())
				global.node_to_clear = global.line_nodes.keys().find(self, 0)
				draw_connecting_line(circle_position)
				#for member in get_tree().get_nodes_in_group("line_node"):
				#	print(global.line_nodes[member]["start"] - global.line_nodes[member]["end"])
				#draw_connecting_line(circle_position)
				
				#draw_connecting_line(global.line_nodes[self]["start"])

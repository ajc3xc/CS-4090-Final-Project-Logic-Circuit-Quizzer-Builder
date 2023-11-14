tool
extends Node2D

#variables for circle
var circle_radius = 40
var circle_color = Color.black
var circle_position = Vector2.ZERO #where circle originates from

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
	#add_child(line)
	#if is_instance_valid(line):
	#	print(".")
	global.line_nodes[self] = {"start": global_position,
							"end": Vector2.ZERO,
							"color": circle_color}
	update()

#drawing is very problematic, so I'm clobbering together a quick fix
func _draw():
	line.set_point_position(1, line_end)
	draw_circle(circle_position, circle_radius, global.line_nodes[self]["color"])
		

#change circle color, reset circle position (just in case)
func change_circle_color(new_color: Color):
	circle_position = Vector2.ZERO
	global.line_nodes[self]["color"] = new_color
	circle_color = new_color
	update()

#draw connecting line from circle
func draw_connecting_line(mouse_position: Vector2):
	line_end = mouse_position
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
			if connected_node:
				#reset this node and connected node
				#but keep this one set as white
				connected_node.reset_circle()
				connected_node.draw_connecting_line(connected_node.circle_position)
				draw_connecting_line(circle_position)
				connected_node.connected_node = null
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
					#only turn black if it isn't already connected
					#to something else
					elif not member.connected_node:
						member.change_circle_color(Color.black)
					
			if no_connecting_members:
				connected_node = null
			
		if Input.is_action_just_released("left_click"):
			print("released")
			#print(str(global.line_nodes[self]["start"])+" "+str(global.line_nodes[self]["end"]))
			global.is_dragging = false
			if connected_node:
				#global.line_nodes
				offset = connected_node.global_position - global_position
				draw_connecting_line(offset)
				#disconnect any other nodes attached to connected node
				if connected_node.connected_node:
					#this looks ridiculous, but trust me it works
					#resets the connected connected node (it makes my head spin too)
					connected_node.connected_node.draw_connecting_line(circle_position)
					connected_node.connected_node.connected_node = null
					connected_node.connected_node.reset_circle()
					connected_node.connected_node = null
				#after that doozy is done, now reset the one you connected to
				connected_node.draw_connecting_line(circle_position)
				connected_node.connected_node = self
				
				
				#this could be added, but it would make the simulation slower
				#connected_node.line_end = Vector2(-offset.x, -offset.y)
				#connected_node.line.set_point_position(1, connected_node.line_end)
				
				#turn off draggable for these nodes
				draggable = false
				connected_node.draggable = false
			else:
				#draw_connecting_line(Vector2(-116, -67))
				#for member in get_tree().get_nodes_in_group("line_node"):
				#	draw_line()
				#	print(global.line_nodes[member]["start"] - global.line_nodes[member]["end"])
				reset_circle()
				
				
				#print(global.line_nodes.keys())
				draw_connecting_line(circle_position)
				draggable = false
				#for member in get_tree().get_nodes_in_group("line_node"):
				#	print(global.line_nodes[member]["start"] - global.line_nodes[member]["end"])
				#draw_connecting_line(circle_position)
				
				#draw_connecting_line(global.line_nodes[self]["start"])

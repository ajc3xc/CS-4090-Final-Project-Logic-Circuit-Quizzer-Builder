tool
extends Node2D

#variables for circle
var circle_radius = 40
var circle_color = Color.black
var original_invalid_color #used when hovering over a gate to turn it red if you're dragging the mouse while entering
var circle_position = Vector2.ZERO #where circle originates from

#variables for line drawn
var line_end = Vector2.ZERO #where the line ends
var line_start = Vector2.ZERO #where the line starts
var hovered_over = false #stores whether cursor is hovering over line node
var is_connected = false
var last_connected_node = null #last node this node connected to

var example_line
var connected_nodes = {} #stores dictionary of dictionaries of connected nodes

#load line from memory
onready var line = get_node("line")

var offset: Vector2

var draggable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize first two points
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)
	update()

#drawing is very problematic, so I'm clobbering together a quick fix
func _draw():
	for output_line in connected_nodes.values():
		output_line["line"].clear_points()
		output_line["line"].add_point(output_line["start"])
		output_line["line"].add_point(output_line["end"])
	line.clear_points()
	line.add_point(line_start)
	line.add_point(line_end)
	draw_circle(circle_position, circle_radius, circle_color)
		

#change circle color, reset circle position (just in case)
func change_circle_color(new_color: Color):
	circle_position = Vector2.ZERO
	circle_color = new_color
	update()

#change where line starts from
#this is when finishing drawing a line
#this is not good code, but I don't care enough
func change_line_start(new_line_start: Vector2):
	line_start = new_line_start
	update()

#draw connecting line from circle
func draw_connecting_line(mouse_position: Vector2):
	line_end = mouse_position
	update()

#automatically changes the color if circle entered / exited
#this is only called if a line isn't actively being drawn
func _on_Area2D_mouse_entered():
	hovered_over = true
	#check if color was changed
	if not global.is_dragging and not global.node_selected:
		print("area entered")
		global.node_selected = true
		if not Input.is_action_pressed("left_click"):
			change_circle_color(Color.white)
			print("enabling dragging")
			draggable = true
		else:
			#visually show that this node can't be selected
			#save original circle color
			original_invalid_color = circle_color
			change_circle_color(Color.darkred)
	

#reset variable and colors
func reset_circle():
	draggable = false
	change_circle_color(Color.black)

func _on_Area2D_mouse_exited():
	hovered_over = false
	if original_invalid_color:
		circle_color = original_invalid_color
		original_invalid_color = null
		change_circle_color(circle_color)
	if not global.is_dragging:
		global.node_selected = false
		draggable = false
		if not is_connected:
			reset_circle()

######################################################
func set_is_connected():
	if not last_connected_node and connected_nodes.size() <= 0:
		for member in get_tree().get_nodes_in_group("line_node"):
			if member.connected_nodes.has(self):
				return
		is_connected = false
		reset_circle()
	else:
		is_connected = true

#removes line and wipes dictionary entry
func erase_connection(connected_node_to_remove):
	last_connected_node.draw_connecting_line(circle_position)
	remove_child(connected_nodes[connected_node_to_remove]["line"])
	connected_nodes.erase(connected_node_to_remove)
	set_is_connected()
	print(connected_nodes)
	last_connected_node = null
	#set value of is_connected
	set_is_connected()

func _physics_process(delta):
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			print("pressed start")
			change_line_start(circle_position)
			global.is_dragging = true
		if Input.is_action_pressed("left_click"):
			offset = get_global_mouse_position() - global_position
			draw_connecting_line(offset)
			#variable storing whether a member is already connected
			#ensures only one member can be connected to
			var no_connecting_members = true
			for member in get_tree().get_nodes_in_group("line_node"):
				if member != self:
					if member.hovered_over:
						#if so, check if it is currently being hovered over
						if no_connecting_members:
							last_connected_node = member
							no_connecting_members = false
							member.change_circle_color(Color.white)
					#otherwise, reset the color
					elif member.connected_nodes.size() > 0 or member.last_connected_node:
						member.change_circle_color(Color.white)
					else:
						member.change_circle_color(Color.black)
			if no_connecting_members:
				last_connected_node = null
			#print(connected_node)
			
		if Input.is_action_just_released("left_click"):
			print("released")
			#print(last_connected_node)
			global.is_dragging = false
			if last_connected_node:
				#turn off draggable and hovered_over for these nodes
				draggable = false
				hovered_over = false
				last_connected_node.draggable = false
				global.node_selected = false
				last_connected_node.hovered_over = false
				global.is_dragging = false
				#ensure neither node has been connected to the other before
				if not connected_nodes.has(last_connected_node):
					if not last_connected_node.connected_nodes.has(self):
						var new_line = Line2D.new()
						new_line.set_default_color(Color.darkred)
						add_child(new_line)
						
						offset = last_connected_node.global_position - global_position
						var offset_inverted = Vector2.ZERO - offset
						var offset_in_circle = offset.normalized() * circle_radius
				
						offset = offset - offset_in_circle
						last_connected_node.change_circle_color(Color.white)
						connected_nodes[last_connected_node] = {"line": new_line,
														"start": offset_in_circle,
														"end": offset}
														
						
						#last_connected_node.connected_nodes[self] = {""}
						change_line_start(offset_in_circle)
						draw_connecting_line(offset)
						last_connected_node.last_connected_node = self
						
						#set is_connected to true for both
						is_connected = true
						last_connected_node.is_connected = true
														
					#other node was connected to this one
					else:
						print(".")
						last_connected_node.change_line_start(circle_position)
						last_connected_node.draw_connecting_line(circle_position)
						print(connected_nodes)
						print(last_connected_node.connected_nodes)
						change_line_start(circle_position)
						draw_connecting_line(circle_position)
						last_connected_node.erase_connection(self)
						print(last_connected_node.last_connected_node)
						last_connected_node = null
						if connected_nodes.size() <= 0:
							is_connected = false
							reset_circle()
				#this node was connected to it
				else:
					print("!")
					last_connected_node.change_line_start(circle_position)
					last_connected_node.draw_connecting_line(circle_position)
					erase_connection(last_connected_node)
					change_line_start(circle_position)
					draw_connecting_line(circle_position)
					if not is_connected:
						reset_circle()
						
			#did not connect to a new node	
			else:
				if not is_connected:
					reset_circle()
				draw_connecting_line(circle_position)
				draggable = false
				global.node_selected = false
				global.is_dragging = false

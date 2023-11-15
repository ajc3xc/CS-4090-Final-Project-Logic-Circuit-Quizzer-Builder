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
	update()

#drawing is very problematic, so I'm clobbering together a quick fix
func _draw():
	line.set_point_position(1, line_end)
	draw_circle(circle_position, circle_radius, circle_color)
		

#change circle color, reset circle position (just in case)
func change_circle_color(new_color: Color):
	circle_position = Vector2.ZERO
	circle_color = new_color
	update()

#draw connecting line from circle
func draw_connecting_line(mouse_position: Vector2):
	line_end = mouse_position
	update()

#automatically changes the color if circle entered / exited
#this is only called if a line isn't actively being drawn
func _on_Area2D_mouse_entered():
	hovered_over = true
	if not global.is_dragging and not global.node_selected:
		print("area entered")
		if not Input.is_action_pressed("left_click"):
			change_circle_color(Color.white)
			print("enabling dragging")
			global.node_selected = true
			draggable = true
		elif not connected_node:
			#visually show that this node can't be selected
			change_circle_color(Color.darkred)

#reset variable and colors
func reset_circle():
	global.node_selected = false
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
				connected_node.draw_connecting_line(circle_position)
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
				if member != self:
					if member.hovered_over:
						#if so, check if it is currently being hovered over
						if no_connecting_members:
							connected_node = member
							no_connecting_members = false
							member.change_circle_color(Color.white)
					#otherwise, reset the color
					elif member.connected_node:
						member.change_circle_color(Color.white)
					elif not member.connected_node:
						member.change_circle_color(Color.black)
			if no_connecting_members:
				connected_node = null
			
		if Input.is_action_just_released("left_click"):
			print("released")
			global.is_dragging = false
			if connected_node:
				#draw line from center of this node to center of other node
				offset = connected_node.global_position - global_position
				draw_connecting_line(offset)
				connected_node.change_circle_color(Color.white)
				
				if connected_node.connected_node and connected_node.connected_node != self:
					#this looks ridiculous, but trust me it works
					if connected_node.connected_node.connected_node:
						connected_node.connected_node.connected_node = null
					#reset any secondary connected nodes connected to the connected node
					connected_node.connected_node.draw_connecting_line(circle_position)
					connected_node.connected_node.reset_circle()
					connected_node.connected_node = null
				
				#delete any line it may connect to
				connected_node.draw_connecting_line(circle_position)
				connected_node.connected_node = self
				
				
				#this could be added, but it would make the simulation slower
				#draws line for both nodes
				#connected_node.line_end = Vector2(-offset.x, -offset.y)
				#connected_node.line.set_point_position(1, connected_node.line_end)
				
				#turn off draggable for these nodes
				draggable = false
				hovered_over = false
				connected_node.draggable = false
				global.node_selected = false
				connected_node.hovered_over = false
			else:
				reset_circle()
				draw_connecting_line(circle_position)
				draggable = false
				global.node_selected = false

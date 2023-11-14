tool
extends Node2D

#variables for circle
var circle_radius = 40
var circle_color = Color.black
var circle_position = Vector2.ZERO

#variables for line drawn
var line_end = Vector2.ZERO

var offset: Vector2
var initialPos: Vector2

var draggable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	update()


func _draw():
	draw_circle(circle_position, circle_radius, circle_color)
	draw_line(circle_position, line_end, Color.white, 8.0)

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
func _on_Area2D_mouse_entered():
	if not global.is_dragging:
		draggable = true
		change_circle_color(Color.white)

#reset variable and colors
func reset_circle():
	draggable = false
	change_circle_color(Color.black)

func _on_Area2D_mouse_exited():
	if not global.is_dragging:
		reset_circle()


func _physics_process(delta):
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			print("pressed start")
			initialPos = global_position
			#offset = 
			global.is_dragging = true
		if Input.is_action_pressed("left_click"):
			offset = get_global_mouse_position() - global_position
			draw_connecting_line(offset)
			
		if Input.is_action_just_released("left_click"):
			print("released")
			global.is_dragging = false
			reset_circle()
			draw_connecting_line(circle_position)

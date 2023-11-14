extends Node2D

onready var drop_down_menu = $OptionButton

var selectedType = "None"
var isCorrect = false

var OR = preload("res://Assets/OR.png")
var AND = preload("res://Assets/AND.png")
var NOT = preload("res://Assets/NOT.png")
onready var bullet_sprite = get_node("Sprite")

func _ready():
	add_items()

func add_items():
	drop_down_menu.add_icon_item(OR, "    ", 1)
	drop_down_menu.add_icon_item(AND, "    ", 2)
	drop_down_menu.add_icon_item(NOT, "    ", 3)

func _on_OptionButton_item_selected(index):
	#current selected item
	var current_selected = index
	
	if current_selected == 0:
		selectedType = "OR"
		bullet_sprite.set_texture(OR)
		_check_if_type_correct()
	elif current_selected == 1:
		selectedType = "AND"
		bullet_sprite.set_texture(AND)
		_check_if_type_correct()
	elif current_selected == 2:
		selectedType = "NOT"
		bullet_sprite.set_texture(NOT)
		_check_if_type_correct()
		
	#print(str(selectedType)+" "+str(isCorrect))
	
# OS.set_window_size(Vector2(1920, 1080)

#used in inhereited nodes
func _check_if_type_correct():
	pass
	

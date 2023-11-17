extends Node2D

onready var drop_down_menu = $OptionButton

var selectedType = "None"
var isCorrect = false

var NONE = preload("res://Assets/black_square.png")
var OR = preload("res://Assets/OR.png")
var AND = preload("res://Assets/AND.png")
var XOR = preload("res://Assets/XOR.png")
var NOT = preload("res://Assets/NOT.png")
var NAND = preload("res://Assets/NAND.png")
var NOR = preload("res://Assets/NOR.png")
var XNOR = preload("res://Assets/XNOR.png")
#onready var bullet_sprite = get_node("Sprite")

var in_nodes = 0
var has_output = false

func _ready():
	add_items()
	enable_nodes()

func add_items():
	
	drop_down_menu.add_icon_item(NONE, "    ", 0)
	drop_down_menu.add_icon_item(OR, "    ", 1)
	drop_down_menu.add_icon_item(AND, "    ", 2)
	drop_down_menu.add_icon_item(XOR, "    ", 3)
	drop_down_menu.add_icon_item(NOT, "    ", 4)
	drop_down_menu.add_icon_item(NAND, "    ", 5)
	drop_down_menu.add_icon_item(NOR, "    ", 6)
	drop_down_menu.add_icon_item(XNOR, "    ", 7)
	
func enable_nodes():
	"""
	if has_output:
		$out_node.set_visible(true)
	if in_nodes == 1:
		$single_in_node.set_visible(true)
	elif in_nodes == 2:
		$"""
	
	
func _on_OptionButton_item_selected(index):
	#current selected item
	var current_selected = index
	
	if current_selected == 0:
		selectedType = "None"
	if current_selected == 0:
		selectedType = "OR"
		#bullet_sprite.set_texture(OR)
		_check_if_type_correct()
	elif current_selected == 1:
		selectedType = "AND"
		_check_if_type_correct()
	elif current_selected == 2:
		selectedType = "XOR"
		_check_if_type_correct()
	elif current_selected == 3:
		selectedType = "NOT"
		_check_if_type_correct()
	elif current_selected == 4:
		selectedType = "NAND"
		_check_if_type_correct()
	elif current_selected == 5:
		selectedType = "NOR"
		_check_if_type_correct()
	elif current_selected == 6:
		selectedType = "XNOR"
		_check_if_type_correct()
		
	#print(str(selectedType)+" "+str(isCorrect))
	
# OS.set_window_size(Vector2(1920, 1080)

#used in inhereited nodes
func _check_if_type_correct():
	pass
	

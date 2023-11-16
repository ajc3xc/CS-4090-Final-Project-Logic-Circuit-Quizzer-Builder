extends "res://Gates/dropdown/drop_down_menu.gd"


var gateType = "NOR"

#used in inhereited nodes
func _check_if_type_correct():
	isCorrect = (selectedType == gateType)

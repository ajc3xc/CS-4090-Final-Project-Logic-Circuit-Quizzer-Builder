extends "res://Gates/drop_down_menu.gd"


var gateType = "NOT"

#used in inhereited nodes
func _check_if_type_correct():
	isCorrect = (selectedType == gateType)




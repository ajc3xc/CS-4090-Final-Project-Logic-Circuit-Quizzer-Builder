extends "res://Gates/drop_down_menu.gd"

const gateType = "OR"

#used in inhereited nodes
func _check_if_type_correct():
	isCorrect = (selectedType == gateType)

extends "res://Gates/drop_down_menu.gd"


var gateType = "NOT"
var input1 = false

#used in inhereited nodes
func _check_if_type_correct():
	isCorrect = (selectedType == gateType)
	if (input1 == 1):
		return false
	else:
		return true



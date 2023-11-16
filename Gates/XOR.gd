extends "res://Gates/drop_down_menu.gd"


var gateType = "XOR"
var input1 = false
var input2 = false
#used in inhereited nodes
func _check_if_type_correct():
	isCorrect = (selectedType == gateType)
	if (input1 == 1 && input2 == 0) || (input1 == 0 && input2 == 1):
		return true
	else:
		return false 


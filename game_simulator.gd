extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



#check if all options selected are true
func _on_Button_pressed():
	var allCorrect = true
	
	for child in get_tree().get_nodes_in_group("gates"):
		print("Gate Type: "+str(child.gateType)+\
		", Selected Type: "+str(child.selectedType)+", Correct: "+str(child.isCorrect))
		if not child.isCorrect:
			allCorrect = false
			
	print(allCorrect)

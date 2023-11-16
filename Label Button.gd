extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#create  a function to create the object mentioned in button
func _on_Label_Button_pressed():
	print("Label has been pressed")
	var textBox= Label.new()
	Label.create()
	
	
	
	pass # Replace with function body.

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
	#creates a label that isnt customizable yet and doesnt show up on background
	#create a static object to be background that isnt interactable?

	print("Label has been pressed")
	var label_text = "This is a new label"
	var textBox = Label.new()
	textBox.rect_global_position = Vector2(50,100)
	textBox.text = label_text
	add_child(textBox)
	print("Label has been created")
	
	
	
	
	
	
	
	pass # Replace with function body.S

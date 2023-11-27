extends "set_visibility.gd"

var scene_name_input: LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_name_input = LineEdit.new()
	add_child(scene_name_input)
	#prompts user for name when pressed
	#has error where textbox shows on start
	scene_name_input.rect_min_size = Vector2(200, 30)
	scene_name_input.placeholder_text = "Enter Scene name(No .tscn)"
	scene_name_input.connect("text_entered", self, "_on_LineEdit_text_entered")



func _on_LineEdit_text_entered(new_text):
	#Uses name of scene entered to launch a new scene
	var scene_name = new_text
	
	if scene_name != "":
		var scene_path = "res://"+scene_name+".tscn"
		#checks if its real
		if ResourceLoader.exists(scene_path):
			#loads in new scene 
			var scene_instance = load(scene_path)
			add_child(scene_instance)
			print("Scene loaded:", scene_path)
			
			#Errors
		else:
			print("Error: Scene not found at", scene_path)
	else:
		print("Error: Please enter a scene name that is valid.")

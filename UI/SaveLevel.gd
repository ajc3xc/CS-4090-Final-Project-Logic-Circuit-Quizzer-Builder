extends "set_visibility.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_name_input: LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_button_pressed")
	#should enable the line editor to recieve name of file 
	save_name_input = $Button/Level_Namer

func _on_Button_pressed():
	var scene = get_tree().get_edited_scene_root()
	
	if scene:
		#Prompt user for save name
		var dialog = FileDialog.new()
		dialog.mode = FileDialog.MODE_SAVE_FILE
		dialog.popup_centered()
		
		dialog.connect("file_selected", self, "_on_FileDialog_files_selected", [scene])
	else:
		print("Error: Scene is empty")

func _on_FileDialog_files_selected(paths, scene):
	#saves the scene as a new .tscn file
	var save_path = paths
	
	if not save_path.ends_with(".tscn"):
		save_path += ".tscn"
	
	scene.save_packed(save_path)
	
	print("Scene saved as:", save_path)

extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	print(files)

	return files


func _on_LevelSelection_pressed():
	var files_index = 0
	var files = list_files_in_directory("res://saves")
	print(files)
	for i in files:
		add_item(files[files_index])
		files_index = + 1
	print("Finished Loading all saves")




func _on_LevelSelection_item_selected(index):
	#get_tree().change_scene("res://")
	pass

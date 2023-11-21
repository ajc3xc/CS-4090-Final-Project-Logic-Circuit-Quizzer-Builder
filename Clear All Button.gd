extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Clear_All_Button_pressed():
	#Clear all button can just be a reset to base Professor view
	#Make a copy of baseprofview for them to edit
	#Should just reset to base Professor View
	#Edit scene in professor view
	get_tree().change_scene("res://BaseProfessorView.tscn")
	
	#var root = get_tree().get_root()
	
	
	#var newLevel = get_tree().get_current_scene()
	#root.remove_child(newLevel)
	#newLevel.call_deferred("free")
	
	#var prof_view_tscn = load("res://ProfessorView.tscn")
	#var prof_view = prof_view_tscn.instance()
	#root.add_child(prof_view)
	

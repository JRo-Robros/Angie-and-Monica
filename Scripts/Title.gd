extends Node2D


func _unhandled_key_input(event):
	if event.pressed:
		load_menu()


#func _on_TextEdit_gui_input(event) -> void:
#	if not (event is InputEventKey):
#		return
#	if event.physical_scancode == 16777221:
#		load_menu()
#	return

func load_menu():
	#LevelsData.set_custom_level($TextEdit.text)
	get_tree().change_scene("res://MainMenu.tscn")

extends Node2D


func _unhandled_key_input(event):
	if event.pressed and event.physical_scancode == 16777221:
		load_game()


func _on_TextEdit_gui_input(event) -> void:
	if not (event is InputEventKey):
		return
	if event.physical_scancode == 16777221:
		load_game()
	return

func load_game():
	LevelsData.set_custom_level($TextEdit.text)
	get_tree().change_scene("res://Game.tscn")

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$UI/MenuButtons/CampaignBtn.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TutorialBtn_pressed():
	LevelsData._is_tutorial = true;
	LevelsData.set_exit_scene("MainMenu")
	get_tree().change_scene("res://Game.tscn")

func _on_CampaignBtn_pressed():
	LevelsData._is_tutorial = false;
	LevelsData.custom_level = []
	LevelsData.set_exit_scene("Congrats")
	get_tree().change_scene("res://Game.tscn")


func _on_LevelEditorBtn_pressed():
	get_tree().change_scene("res://Editor.tscn")


#func _on_SettingsBtn_pressed():
#	pass # Replace with function body.


#func _on_CreditsBtn_pressed():
#	$UI/Container.visible = !$UI/Container.visible
#	$UI/Credits.visible = !$UI/Container.visible

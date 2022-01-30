extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CampaignBtn_pressed():
	LevelsData.custom_level = []
	LevelsData.set_exit_scene("Congrats")
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.


func _on_LevelEditorBtn_pressed():
	get_tree().change_scene("res://Editor.tscn")
	pass # Replace with function body.


func _on_SettingsBtn_pressed():
	pass # Replace with function body.


func _on_CreditsBtn_pressed():
	$UI/Container.visible = !$UI/Container.visible
	$UI/Credits.visible = !$UI/Container.visible

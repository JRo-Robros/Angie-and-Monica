extends Node2D

onready var levelController:= $Level
onready var angel := $Angel
onready var devil := $Devil
onready var tween := $Tween

var receive_input := 0
var level := 1
var levelName := ""
var levelDesc := ""
var levelMoves := 15
var levelTime := 300
var moves := 0
var time := 0
var game_is_over := false

signal input_received

func _ready():
	level = 1
	connect('input_received', angel, '_input_received')
	connect('input_received', devil, '_input_received')
	levelController.initialize_level(get_level_data())


func _process(delta):
	if receive_input >= 2:

		if angel.global_position == devil.global_position:
			angel.character_dies()
			devil.character_dies()
		
		if angel.on_goal and devil.on_goal:
			_on_level_cleared()

		var dir:= Vector2.ZERO
		
		if Input.is_action_just_pressed("ui_up"):
			dir = Vector2.UP
		if Input.is_action_just_pressed("ui_down"):
			dir = Vector2.DOWN
		if Input.is_action_just_pressed("ui_left"):
			dir = Vector2.LEFT
		if Input.is_action_just_pressed("ui_right"):
			dir = Vector2.RIGHT
			
		if dir != Vector2.ZERO:
			increment_moves()
			receive_input = 0
			emit_signal("input_received", dir)

	
func stop_input():
	receive_input = 0

func game_over():
	if game_is_over: return
	game_is_over = true
	_reset_level()

func increment_moves():
	moves += 1
	$"Move Counter".text = "Moves: "+str(moves)

func _on_Bounds_body_entered(body):
	if body.has_method('on_tile'):
		body.on_tile(0)

func _on_Level_level_initialized():
	if level % 2 == 1:
		$Music1.play()
	else:
		$Music2.play()
	
	$hud_level.bbcode_text = "[color=#e9e9e9]"+levelName+"[/color]"
	$hud_level.append_bbcode("\n")
	$hud_level.append_bbcode(levelDesc)
	moves = -1
	increment_moves()
	game_is_over = false
	yield(get_tree().create_timer(0.5), "timeout")
	receive_input = 2
	angel.is_active = true
	devil.is_active = true

func _reset_level():
	$AngiePortrait.offset = Vector2(-200,0)
	$MonicaPortrait.offset = Vector2(180,0)
	$LevelSummary.visible = false
	receive_input = 0
	yield(get_tree().create_timer(0.5), "timeout")
	levelController.reset()
	
func _on_level_cleared():
	angel.is_active = false
	devil.is_active = false
	receive_input = 0
	$Good.play()
	yield(get_tree().create_timer(0.5), "timeout")
	show_level_summary()
	$Music1.stop()
	$Music2.stop()
		
func _on_exittomenu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
	return

func show_level_summary():
	$LevelSummary.visible = true
	var stars = "1"
	var bd = "[center]Well Done!\n\n"
	bd += "Moves: " + str(moves) + "\n\n"
	if moves-levelMoves < 0:
		bd += "New Record!!"
		stars = "4"
	elif moves-levelMoves == 0:
		bd += "3 Stars"
		stars = "3"
	elif moves-levelMoves < 3:
		bd += "2 Stars"
		stars = "2"
	else:
		bd += "1 Star"
	bd += "\n\n[/center]"
		
	$LevelSummary/VBoxContainer/Breakdown.bbcode_text = bd
	$LevelSummary/VBoxContainer/Advance.visible = false
	$LevelSummary/VBoxContainer/Retry.visible = false
	
	dialogue(LevelsData.getDialogue(levelName, stars))


func advance():
	$AngiePortrait.offset = Vector2(-200,0)
	$MonicaPortrait.offset = Vector2(180,0)
	level += 1
	$LevelSummary.visible = false
	var _levelData = get_level_data()
	if _levelData.size() > 0:
		levelController.initialize_level(_levelData)
	else:
		get_tree().change_scene(LevelsData.get_exit_scene_path())


func get_level_data() -> Array:
	var _levelData:Array = [] 
	
	# Try to grab the current custom level.
	if LevelsData.custom_level.size() > 0:
		if LevelsData.custom_level.size() >= level:
			_levelData = LevelsData.custom_level[level-1].duplicate()
	
	# Try to grab the current built-in level.
	else:
		if LevelsData.level_exists(level):
			_levelData = LevelsData.get_level_data(level).duplicate()
	
	# Set empty if corrupted.
	if _levelData.size() > 0 && (_levelData.size() - 108) % 3 != 0:
		_levelData = []
		
	return _levelData


func dialogue(dialogue:Array = ["[color=#8fd3ff][center]hello[/center][/color]","[color=#c32454][center]hi[/center][/color]"]):
	var box = $LevelSummary/VBoxContainer/DialogueBox
	tween.interpolate_property(
		$AngiePortrait,
		"offset",
		Vector2(-200,0),
		Vector2.ZERO,
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		$MonicaPortrait,
		"offset",
		Vector2(180,0),
		Vector2.ZERO,
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, 'tween_completed')
	for line in dialogue:
		box.percent_visible = 0
		box.bbcode_text = line
		tween.interpolate_property(
			box,
			"percent_visible",
			0,
			1,
			0.75,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, 'tween_completed')
		yield(get_tree().create_timer(1.2), "timeout")
		box.percent_visible = 0
		yield(get_tree().create_timer(0.2), "timeout")
	$LevelSummary/VBoxContainer/Advance.visible = true
	$LevelSummary/VBoxContainer/Retry.visible = true
	$LevelSummary/VBoxContainer/Advance.grab_focus()

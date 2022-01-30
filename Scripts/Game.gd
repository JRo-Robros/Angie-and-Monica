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
		
func _on_exittomenu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
	return	

func show_level_summary():
	$LevelSummary.visible = true
	var bd = "[center]Well Done!\n\n"
	bd += "Moves: " + str(moves) + "\n\n"
	if moves-levelMoves < 0:
		bd += "New Record!!"
	elif moves-levelMoves == 0:
		bd += "3 Stars"
	elif moves-levelMoves < 3:
		bd += "2 Stars"
	else:
		bd += "1 Star"
	bd += "\n\n[/center]"
		
	$LevelSummary/VBoxContainer/Breakdown.bbcode_text = bd
	$LevelSummary/VBoxContainer/Advance.visible = false
	$LevelSummary/VBoxContainer/Retry.visible = false
	
	dialogue()
	
func advance():
	level += 1
	$LevelSummary.visible = false
	var _levelData = get_level_data()
	if _levelData.size() > 0:
		levelController.initialize_level(_levelData)
	else:
		print('You win!!')
		if LevelsData.custom_level.size() > 0:
			get_tree().change_scene("res://Editor.tscn")
		else:
			get_tree().change_scene("res://Title.tscn")
	
func get_level_data() -> Array:
	var _levelData:Array = []
	print(LevelsData.custom_level)
	if LevelsData.custom_level.size() >= level:
		_levelData = LevelsData.custom_level[level-1].duplicate()
	elif LevelsData.level_exists(level):
		_levelData = LevelsData.get_level_data(level).duplicate()
	
	if _levelData.size() < 1:
		return []
	elif (_levelData.size() - 108) % 3 != 0:
		return []
	else:
		return _levelData
		
func dialogue(dialogue:Array = ["[color=#8fd3ff][center]hello[/center][/color]","[color=#c32454][center]hi[/center][/color]"]):
	var box = $LevelSummary/VBoxContainer/DialogueBox
	for line in dialogue:
		box.bbcode_text = line
		tween.interpolate_property(
			box,
			"percent_visible",
			0,
			1,
			0.5,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, 'tween_completed')
		yield(get_tree().create_timer(1.0), "timeout")
		box.percent_visible = 0
		yield(get_tree().create_timer(0.2), "timeout")
	$LevelSummary/VBoxContainer/Advance.visible = true
	$LevelSummary/VBoxContainer/Retry.visible = true

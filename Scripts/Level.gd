extends Node2D

onready var angel = get_parent().get_node("Angel")
onready var devil = get_parent().get_node('Devil')
onready var game = get_parent()
var level_data:Array

var tile := preload('res://Tile.tscn')
var block := preload("res://Block.tscn")

var move_count = 0

signal level_initialized

func _ready():
	pass

func reset():
	initialize_level(level_data)

func initialize_level(_levelData:Array) -> void:
	angel.reset()
	devil.reset()
	for i in get_children():
		i.queue_free()
	level_data = _levelData.duplicate(true)
	move_count = 0
	game.levelName = _levelData.pop_back()
	game.levelDesc = _levelData.pop_back()
	var moves = _levelData.pop_back()
	game.levelMoves = moves
	var time = _levelData.pop_back()
	game.levelTime = time
	var angelOrigin = Vector2(_levelData.pop_back(),_levelData.pop_back())
	var devilOrigin = Vector2(_levelData.pop_back(),_levelData.pop_back())
	for i in 100:
		var a = tile.instance()
		a.position.x = (i % 10) * 33
		a.position.y = (i / 10) * 33 + 33
		a.type = _levelData.pop_back()
		add_child(a)
		
	while _levelData.size() > 0:
		var b = block.instance()
		b.blockType = _levelData.pop_back()
		b.position = Vector2((33 * _levelData.pop_back()), (33 * _levelData.pop_back()) + 33)
		add_child(b)
		
	angel.position = Vector2(position.x + (33 * angelOrigin.x), position.y + 33 + (33 * angelOrigin.y))
	devil.position = Vector2(position.x + (33 * devilOrigin.x), position.y + 33 + (33 * devilOrigin.y))
	
	#TODO: Call On Enter Tile for Angel and Demon
	
	emit_signal("level_initialized")
	return

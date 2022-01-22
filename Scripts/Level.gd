extends Node2D

onready var angel = get_parent().get_node("Angel")
onready var devil = get_parent().get_node('Devil')
onready var hud_level = get_parent().get_node('hud_level')
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
	angel.animation_player.play('Fly')
	devil.animation_player.play('Fly')
	angel.dead = false
	devil.dead = false
	angel.is_reversed = false
	devil.is_reversed = false
	angel.indicator.visible = false
	devil.indicator.visible = false
	for i in get_children():
		i.queue_free()
	level_data = _levelData.duplicate(true)
	move_count = 0
	hud_level.text = _levelData.pop_back()
	hud_level.text += ":\n"
	hud_level.text += _levelData.pop_back()
	var moves = _levelData.pop_back()
	var time = _levelData.pop_back()
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
		
	emit_signal("level_initialized")
	return

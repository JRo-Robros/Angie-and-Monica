extends Node2D

onready var angel = get_node("Angel")
onready var devil = get_node('Devil')

var tiles = []
var editTiles = []
var blocks = {}
var angel_origin:=Vector2.ZERO
var devil_origin:=Vector2.ZERO
var levelName := "Title Here"
var levelDesc := "Description"
var parMoves := 15
var parTime := 300

var tile := preload('res://EditTile.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 100:
		tiles.push_back(1)
		var a = tile.instance()
		a.tile_type = 0
		a.index = i
		a.grid_coord = Vector2((i % 10),(i / 10))
		a.position.x = (i % 10) * 33 + 250
		a.position.y = (i / 10) * 33 + 27
		add_child(a)
		editTiles.push_back(a)
		
	if LevelsData.custom_level.size() > 0:
		initialize_level(LevelsData.custom_level[0])

func set_angel_origin(coord:Vector2):
	angel_origin = coord
	angel.position = Vector2(coord.x * 33 + 250, coord.y * 34 + 20)
	
func set_devil_origin(coord:Vector2):
	devil_origin = coord
	devil.position = Vector2(coord.x * 33 + 250, coord.y * 34 + 20)

func add_rem_block(coord, type):
	var key = str(coord)
	if type == 0:
		blocks.erase(key)
	else:
		blocks[key] = [type-1, coord.x, coord.y]

func set_tile_type(index:int, type:int):
	tiles[index] = type
	
func make_level():
	var output = compile_LevelData()
	$Output.text = JSON.print(output)

func compile_LevelData() -> Array:
	var output = []
	for b in blocks:
		output.push_back(blocks[b][2])
		output.push_back(blocks[b][1])
		output.push_back(blocks[b][0])
	for i in 100:
		output.push_back(tiles[99-i])
	output.push_back(devil_origin.y)
	output.push_back(devil_origin.x)
	output.push_back(angel_origin.y)
	output.push_back(angel_origin.x)
	output.push_back(parTime)
	output.push_back(parMoves)
	output.push_back(levelDesc)
	output.push_back(levelName)
	return output

func initialize_level(_levelData:Array) -> void:
	angel.position = Vector2.ZERO
	devil.position = Vector2.ZERO
	print(_levelData.pop_back())
	print(_levelData.pop_back())
	var moves = _levelData.pop_back()
	var time = _levelData.pop_back()
	var angelOrigin = Vector2(_levelData.pop_back(),_levelData.pop_back())
	var devilOrigin = Vector2(_levelData.pop_back(),_levelData.pop_back())
	for i in editTiles:
		i.set_tile_type(_levelData.pop_back())
		
	print(_levelData.size())
	while _levelData.size() > 0:
		var bType = _levelData.pop_back()
		# ind = x + (y*10)
		var etInd = _levelData.pop_back() + (_levelData.pop_back() * 10)
		editTiles[etInd].set_block_type(bType+1)
		
	set_angel_origin(angelOrigin)
	set_devil_origin(devilOrigin)
	return

func load_from_input() -> void:
	load_from_string(get_node("Output").text)
	return


func load_from_string(_inputString:String) -> void:
	var data = JSON.parse(_inputString)
	if typeof(data.result) == TYPE_ARRAY:
		initialize_level(data.result)
	else:
		push_error("Unexpected results.")
	return


func _on_TestLevelBtn_pressed() -> void:
	LevelsData.custom_level = []
	LevelsData.custom_level.push_back(compile_LevelData())
	get_tree().change_scene("res://Game.tscn")
	return


func _on_ExitBtn_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
	return


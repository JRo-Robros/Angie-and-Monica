extends Node2D


var tiles = []
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

func set_angel_origin(coord:Vector2):
	angel_origin = coord
	$Angel.position = Vector2(coord.x * 33 + 250, coord.y * 34 + 20)
	
func set_devil_origin(coord:Vector2):
	devil_origin = coord
	$Devil.position = Vector2(coord.x * 33 + 250, coord.y * 34 + 20)

func add_rem_block(coord, type):
	var key = str(coord)
	if type == 0:
		blocks.erase(key)
	else:
		blocks[key] = [type-1, coord.x, coord.y]

func set_tile_type(index, type):
	tiles[index] = type
	
func make_level():
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
	
	$Output.text = JSON.print(output)

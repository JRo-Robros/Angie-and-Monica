extends Node2D
class_name Tile

onready var tile := $Sprite
var type := 0

func _ready():
	if type != 0:
		tile.region_rect = Rect2(type * 34 - 34, 0, 34, 34)
	else:
		tile.visible = false

func _on_Tile_body_entered(body):
	if body.has_method('on_tile'):
		body.on_tile(type)


func _on_Tile_body_exited(body):
	if body.has_method('exit_tile'):
		body.exit_tile(type)

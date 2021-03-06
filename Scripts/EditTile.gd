extends Area2D

var grid_coord =  Vector2(0,0)
var index:int = 0
var tile_type:int = 0
var block_type:int = 0
var active = false
var keyDown = false

onready var tile_sprite = $TileSprite
onready var block_sprite = $BlockSprite
onready var editor = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_tile_type(tile_type)

func set_tile_type(type:int):
	tile_type = type
	editor.set_tile_type(index, type)
	_set_tile_type(type)

func set_block_type(type):
	block_type = type
	editor.add_rem_block(grid_coord, type)
	_set_block_type(type)

func _unhandled_key_input(event):
	if active and event.pressed and not keyDown:
		keyDown = true
		print("scancode: " + String(event.physical_scancode))
		match event.physical_scancode:
			48:
				set_tile_type(0)
			49:
				set_tile_type(1)
			50:
				pass
				#set_tile_type(2)
			51:
				set_tile_type(3)
			52:
				set_tile_type(4)
			53:
				set_tile_type(5)
			54:
				set_tile_type(6)
			57:
				set_block_type(0)
			81:
				set_block_type(1)
			87:
				set_block_type(2)
			69:
				set_block_type(3)
			82:
				set_block_type(4)
			65:
				editor.set_angel_origin(grid_coord)
			68:
				editor.set_devil_origin(grid_coord)


func _on_EditTile_mouse_entered():
	active = true
	$ColorRect.self_modulate = Color(0.2, 0.1, 0.25)


func _on_EditTile_mouse_exited():
	keyDown = false
	active = false
	$ColorRect.self_modulate = Color(0.12, 0.03, 0.14)	
	
func _set_block_type(type:int):
	if type != 0:
		block_sprite.visible = true
		block_sprite.region_rect = Rect2(type * 34 - 34, 0, 34, 34)
	else:
		block_sprite.visible = false
		
func _set_tile_type(type:int):
	if type != 0:
		tile_sprite.visible = true
		tile_sprite.region_rect = Rect2(type * 34 - 34, 0, 34, 34)
	else:
		tile_sprite.visible = false

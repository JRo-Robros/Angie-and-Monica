extends KinematicBody2D
class_name Block

onready var checker:= $moveChecker
onready var tween := $Tween
export var blockType = 0

func _ready():
	$Sprite.region_rect = Rect2(blockType*34, 0, 34, 34)

func _physics_process(delta):
	pass

func check_move(dir:Vector2) -> bool:
	checker.cast_to = dir.normalized() * 20
	checker.force_raycast_update()
	if checker.is_colliding():
		return false
	yield(move(dir), 'completed')
	return true

func push(dir, pusher):
	match pusher:
		'Angel':
			if blockType == 1 or blockType == 3:
				return false
		'Devil':
			if blockType == 0 or blockType == 3:
				return false
	return check_move(dir)
	
func move(dir:Vector2):
	var target_pos = global_position + (dir.normalized() * 33)	
	tween.interpolate_property(
			self,
			"global_position",
			global_position,
			target_pos,
			0.4,
			Tween.TRANS_CUBIC,
			Tween.EASE_OUT
		)
	tween.start()
	yield(tween, 'tween_completed')
	return

func on_tile(tileType):
	match tileType:
		0:
			$AnimationPlayer.play('fall')

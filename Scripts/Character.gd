extends KinematicBody2D
class_name Character

onready var sprite:Sprite = $Sprite
onready var dizzyIndicator := $DizzyIndicator
onready var stuckIndicator := $StuckIndicator
onready var timer:Timer = $Timer
onready var checker:= $Checker
onready var tween := $Tween
onready var animation_player := $AnimationPlayer

export var move_speed := 60
export var move_distance := 33
export var is_reversed := false
var stuck := false
var is_moving := false
var dead := false
var can_move := true
var motion := Vector2.ZERO
var last_pos := Vector2()
var target_pos := Vector2()
var on_goal := false
var is_active := false

signal game_over
signal stop_input

func _ready():
	pass
	
func _physics_process(delta):
	pass

func reset():
	stuck = false
	stuckIndicator.visible = false
	is_reversed = false
	dizzyIndicator.visible = false
	is_moving = false
	dead = false
	can_move = true
	is_active = false
	animation_player.play("Fly")
		
func on_tile(type):
	if !is_active:
		return
	var type_name = [
		'hole',
		'grass',
		'lava',
		'sticky',
		'reverse'
	]
	match type:
		0:
			dead = true
			character_dies()
		3:
			stuck = true
			stuckIndicator.visible = true
		4:
			is_reversed = !is_reversed
			dizzyIndicator.visible = !dizzyIndicator.visible
		5:
			if self.name == 'Angel': on_goal = true
		6:
			if self.name == 'Devil': on_goal = true

func exit_tile(type):
	match type:
		5:
			if self.name == 'Angel': on_goal = false
		6:
			if self.name == 'Devil': on_goal = false
			
func check_move(dir:Vector2, prevent_infinite = false) -> bool:
	if dead:
		return false
	if stuck:
		motion = Vector2.ZERO
		stuckIndicator.visible = false
		stuck = false
		return false
	checker.cast_to = dir.normalized()*20
	checker.force_raycast_update()
	if checker.is_colliding():
		var coll = checker.get_collider()
		match coll.name:
			'Angel', 'Devil':
				if !prevent_infinite:
					if !coll.check_move(dir, true):
						return false
				if is_reversed:
					return coll.is_reversed
				else:
					return !coll.is_reversed
		if coll.has_method('push'):
			return coll.push(dir, self.name)
	return true

func character_dies():
	dead = true
	motion = Vector2.ZERO
	animation_player.play("Die")
	
func _input_received(dir):
	if is_moving:
		get_parent().receive_input += 1
		return
	if is_reversed:
		dir *= -1
	target_pos = position + (dir * 33)
	if check_move(dir):
		last_pos = position		
		sprite.flip_h = dir.x < 0
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
		is_moving = true
		yield(tween, 'tween_completed')
		is_moving = false
	get_parent().receive_input += 1

func _stop_input():
	emit_signal('stop_input')
	
func _game_over():
	position = Vector2.ZERO
	emit_signal("game_over")

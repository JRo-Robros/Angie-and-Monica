extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music3.play()
	$Music3.seek(6.5)
	yield(get_tree().create_timer(2), "timeout")
	$Tween.interpolate_property(
		$dialogue,
		"percent_visible",
		0,
		.36,
		2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	yield($Tween, 'tween_completed')
	yield(get_tree().create_timer(2), "timeout")
	$Tween.interpolate_property(
		$dialogue,
		"percent_visible",
		0.36,
		0.7,
		2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	yield($Tween, 'tween_completed')
	yield(get_tree().create_timer(2), "timeout")
	$Tween.interpolate_property(
		$dialogue,
		"percent_visible",
		0.7,
		1,
		2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_CampaignBtn_pressed():
	get_tree().change_scene("res://Title.tscn")

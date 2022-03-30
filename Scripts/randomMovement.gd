extends TextureRect

var velocity = -10
var chance = 50

func _physics_process(delta):
	chance -= 1
	if chance < 40 && randi() % chance <= 5:
		velocity *= -1
		chance = 50
	rect_position.y += velocity * delta

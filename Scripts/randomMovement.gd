extends AnimatedSprite

var velocity = -10
var chance = 200

func _physics_process(delta):
	chance -= 1
	if chance < 100 && randi() % chance <= 5:
		velocity *= -1
		chance = 150
	position.y += velocity * delta

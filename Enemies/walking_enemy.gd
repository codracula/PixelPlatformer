extends CharacterBody2D


var direction = Vector2.RIGHT
@onready var ledgeCheckRight = $LedgeCheckRight
@onready var sprite = $AnimatedSprite2D
func _physics_process(delta):
	var foundWall = is_on_wall()
	var foundLedge = not ledgeCheckRight.is_colliding()
	if foundWall or foundLedge:
		
		sprite.scale.x *= -1
		var flip = Vector2(12,0)
		if direction.x > 0:
			direction *= -1
			ledgeCheckRight.position -= flip
		elif direction.x < 0:
			direction *= -1
			ledgeCheckRight.position += flip
	#move character
	velocity = direction * 25
	move_and_slide()

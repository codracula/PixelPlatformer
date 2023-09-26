extends Node2D
#class_name Player
enum {
	HOVER, FALL, LAND, RISE
}

var state = HOVER


@onready var timer: = $Timer
@onready var raycast: = $RayCast2D
@onready var animatedSprite = $AnimatedSprite2D
@onready var collision = $hitbox/CollisionShape2D
@onready var particle = $GPUParticles2D

var collision_point = 0
var START_POSITION = 0

func _ready():
	START_POSITION = position
	particle.one_shot = true
func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state()
		RISE: rise_state(delta)
		
func hover_state():
	await get_tree().create_timer(2.0).timeout
	state = FALL

func fall_state(delta): #activate by raycast
	animatedSprite.play("fall")
	if not raycast.is_colliding():
		position.y += 180 * delta * 2
	else:
		collision_point = raycast.get_collision_point()
		position.y = move_toward(position.y, collision_point.y, .1* delta)
		state = LAND
		particle.emitting = true

func land_state(): 	
	await get_tree().create_timer(.5).timeout
	state = RISE
	
func rise_state(delta):
	animatedSprite.play("rise")
	if position.y > START_POSITION.y:
		position.y -= 20 * delta
	else:
		state = HOVER
	
	

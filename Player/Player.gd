extends CharacterBody2D
class_name Player
enum {
	MOVE, CLIMB
}


@export var moveData = Resource
@onready var animatedSprite = $AnimatedSprite2D
@onready var ladderCheck = $LadderCheck
@onready var jumpBufferTimer = $JumpBufferTimer
@onready var delayJumpTimer = $DelayJumpTimer
@onready var remoteTransform2D = $RemoteTransform2D
var camera_path: NodePath = "res://Camera2D"
#var camera_node = get_node(remote_path(camera_path))
var state = MOVE
var double_jump = 1
var bufferJump = false
var delayJump = false
var isDead = false
var input = Vector2.ZERO;
#signal player_died_signal()
func _ready():
	#we can switch sprite by load different resources
	animatedSprite.frames = load("res://Player/playerBlue.tres")



func _physics_process(delta):
	
	if is_on_ladder():
		double_jump_reset()
		state = CLIMB
		
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	if state == MOVE: move_state(input, delta) 
	elif state == CLIMB: climb_state(input)
	
#	match state:
#		MOVE: move_state(input)
#		CLIMB: climb_state(input)

func move_state(input, delta):
	_apply_gravity(delta);
	if input.x == 0:
		_apply_friction(delta)
		animatedSprite.animation = "idle"
	else:
		_apply_acceleration(input.x, delta)
		animatedSprite.play("run")
		if input.x > 0:
			animatedSprite.flip_h = true
			velocity.x = moveData.SPEED
		elif input.x < 0:
			animatedSprite.flip_h = false
			velocity.x = -moveData.SPEED
	
	if is_on_floor():
		double_jump_reset()
	else:
		animatedSprite.animation = "jump"
		
	if is_on_floor() or delayJump:		
		input_jump()
			
	else:		
		input_double_jump()
		jump_delay()

	var wasOnFloor = is_on_floor()
#	var justLanded = is_on_floor() and not wasOnFloor
	var justLeftGround = wasOnFloor and not is_on_floor()
	if justLeftGround and velocity.y >= 0:  #check both slide left and falling
		delayJump = true
		delayJump.start()
	move_and_slide()

func climb_state(input):
	if not is_on_ladder(): state = MOVE	
	velocity = input * moveData.CLIMB_SPEED
	move_and_slide()
	
func is_on_ladder():	
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true
	
func input_double_jump():
	if Input.is_action_just_released("ui_up") and velocity.y < -(moveData.GRAVITY):
		velocity.y += moveData.GRAVITY
	elif Input.is_action_just_pressed("ui_up") and double_jump > 0:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.JUMP_VELOCITY 
		double_jump -= 1
	
func jump_delay():
	if Input.is_action_just_pressed("ui_up"):
		bufferJump = true
		jumpBufferTimer.start()
	
func player_died():
	SoundPlayer.play_sound(SoundPlayer.HURT)
	queue_free()
	isDead = true
	Events.player_died.emit()
	
func connect_camera(camera):
#	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera.get_path()
	
func can_jump():
	return is_on_floor() or delayJump
	
func input_jump():
	if Input.is_action_just_pressed("ui_up") or bufferJump:			
			velocity.y = moveData.JUMP_VELOCITY
			SoundPlayer.play_sound(SoundPlayer.JUMP)
			bufferJump = false
			
func double_jump_reset():
	double_jump = moveData.DOUBLE_JUMP_COUNT;
	
func _apply_gravity(delta):
	velocity.y += moveData.GRAVITY * delta;
	
func _apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION * delta)
	
func _apply_acceleration(inputAmount, delta):
	#move_toward
	velocity.x = move_toward(velocity.x, moveData.SPEED, moveData.FRICTION * delta)
	
func spawn(x,y):
	position = Vector2(x,y)

func _on_jump_buffer_timer_timeout():
	bufferJump = false

func _on_delay_jump_timer_timeout():
	delayJump = false

#lesson
# ctrl-k to comment multiple lines

#we can use fastPlayerMovement.tres as a power up
#func powerUp()
#	moveData = load("res://fastPlayerMovement.tres")

#quick way to assign input to directions
#	input.x = Input.get_axis("ui_left", "ui_right")
#	input.y = Input.get_axis("ui_up", "ui_down")

#we can switch sprite by load different resources
#	animatedSprite.frames = load("res://playerBlue.tres")

#collision layer
#layer: current entity layer
#mask: layer to check collision with

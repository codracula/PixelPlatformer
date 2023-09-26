#@tool 

extends Path2D

enum ANIMATION_TYPE {
	LOOP, 
	BOUNCE
}

#@export var animationType:= ANIMATION_TYPE: set = set_animation_type
#@export var speed: int: set = set_speed
#
#@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.





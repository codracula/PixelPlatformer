extends Area2D


@onready var animatedSpriteF: = $AnimatedSprite2D
#@onready var player = $Player


func _on_body_entered(body):
	print("collide with flag")
#	if body != Player: return
#	print("play flag anim")
	if animatedSpriteF.animation != "checked":
		SoundPlayer.play_sound(SoundPlayer.CHECKED)
	
#	if body is Player and animatedSpriteF.animation == "unchecked":
		animatedSpriteF.play("checked")	
		Events.hit_checkpoint.emit(global_position)
		print("global_checkpoint_position", str(global_position))
	

extends Area2D
#class_name Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
#	if body is Player:
#		body.queue_free()
#		get_tree().reload_current_scene()
	
	
	#this check collision then spawn player
	if body.name == "Player": 
		body.spawn(262.857, 532.381)


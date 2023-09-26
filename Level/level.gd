extends Node2D

var PlayerScene = preload("res://Player/player.tscn").instantiate()
var player_spawn_location = Vector2.ZERO
@onready var camera: = $Camera2D
@onready var player: = $Player
@onready var timer: = $Timer


# Called when the node enters the scene tree for the first time.

func _ready():
	RenderingServer.set_default_clear_color(Color.ANTIQUE_WHITE)
	print("_ready")
	player_spawn_location = player.global_position
	print("player_spawn_location:", str(player_spawn_location))
	Events.player_died.connect(_on_player_player_died_signal)
	Events.hit_checkpoint.connect(_on_checkpoint_hit_checkpoint)
	spawn_player()

func spawn_player():
	player.global_position = player_spawn_location
	player.connect_camera(camera)
	
func _on_player_player_died_signal():
	
	print("player died")
	await get_tree().create_timer(2.0).timeout #wait until timeout signal	
	PlayerScene.global_position = player_spawn_location
	player = PlayerScene
	print("player_spawn_location after died:", str(player_spawn_location))
	add_child(player)  #must be instantiated to add_child to the current scene
	spawn_player()
	PlayerScene = preload("res://Player/player.tscn").instantiate()
	print("done spawn a new player")

func _on_checkpoint_hit_checkpoint(checkpoint_pos):
	player_spawn_location = checkpoint_pos

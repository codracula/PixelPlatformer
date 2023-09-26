extends Node

const HURT = preload("res://sound/hurt.wav")
const JUMP = preload("res://sound/jump.wav")
const CHECKED = preload("res://sound/flagchecked2.wav")
#@onready var audioStreamPlayer: = $AudioPlayers/AudioStreamPlayer
@onready var audioPlayers = $AudioPlayers
func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound 
			audioStreamPlayer.play()
			break
	

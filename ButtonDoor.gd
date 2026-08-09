class_name ButtonDoor
extends Node2D

@export var animation_player: AnimationPlayer
@export var start_open : bool = false

@export_category("Sounds")
@export var door_open: AudioStream
@export var door_close: AudioStream

var audio_controller : AudioController 

func _ready() -> void:
	audio_controller = get_tree().current_scene.get_node("AudioController")
	if start_open:
		animation_player.play("door_open")
	else:
		animation_player.play("door_close")
	SignalController.connect("button_pressed",func(buttons):
		if self in buttons:
			if start_open:
				animation_player.play("door_close")
			else:
				audio_controller.play_sound(door_open)
				animation_player.play("door_open")
		)
	SignalController.connect("button_unpressed",func(buttons):
		if self in buttons:
			if start_open:
				animation_player.play("door_open")
			else:
				animation_player.play("door_close")
		)

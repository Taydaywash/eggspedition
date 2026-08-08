class_name ButtonDoor
extends Node2D

@export var animation_player: AnimationPlayer
@export var start_open : bool = false

func _ready() -> void:
	if start_open:
		animation_player.play("door_open")
	SignalController.connect("button_pressed",func(buttons):
		if self in buttons:
			if start_open:
				animation_player.play("door_close")
			else:
				animation_player.play("door_open")
		)
	SignalController.connect("button_unpressed",func(buttons):
		if self in buttons:
			if start_open:
				animation_player.play("door_open")
			else:
				animation_player.play("door_close")
		)

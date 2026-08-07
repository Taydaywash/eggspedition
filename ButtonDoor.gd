class_name ButtonDoor
extends Node2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	SignalController.connect("button_pressed",func(buttons):
		if self in buttons:
			animation_player.play("door_open")
		)
	SignalController.connect("button_unpressed",func(buttons):
		if self in buttons:
			animation_player.play("door_close")
		)

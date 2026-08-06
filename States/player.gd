extends CharacterBody2D
class_name Player

@export var jump_speed : float = 50
@export var max_fall_speed : float = 50
@export var gravity : float = 50
@export var move_speed : float = 50
@export var state_machine : StateMachine
@export var sprite: Sprite2D

func _ready() -> void:
	state_machine.player = self
	state_machine.sprite = sprite
	await get_tree().process_frame
	state_machine.initialize_state_machine()

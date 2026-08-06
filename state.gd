class_name State
extends Node

var player : Player
var sprite : Sprite2D
var state_machine : StateMachine
@export_color_no_alpha var placeholder_state_color : Color = Color.WHITE

func activate():
	sprite.self_modulate = placeholder_state_color
	return

func process_frame(_delta) -> State:
	return null
func process_physics(_delta) -> State:
	return null
func process_input(_event) -> State:
	return null

func deactivate():
	return

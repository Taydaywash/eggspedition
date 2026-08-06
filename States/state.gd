class_name State
extends Node

var player : Player
var sprite : Sprite2D
var state_machine : StateMachine
@export_color_no_alpha var placeholder_state_color : Color = Color.WHITE

func activate():
	sprite.self_modulate = placeholder_state_color
	return

@warning_ignore("unused_parameter")
func process_frame(delta) -> State:
	return null
@warning_ignore("unused_parameter")
func process_physics(delta) -> State:
	return null
@warning_ignore("unused_parameter")
func process_input(event : InputEvent) -> State:
	return null

func deactivate():
	return

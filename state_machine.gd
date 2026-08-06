extends Node
class_name StateMachine

var state : State
var player : Player
var sprite : Sprite2D
@export var starting_state : State

@export var full_egg_idle_state : State
@export var full_egg_walk_state : State
@export var full_egg_jump_state : State

func initialize_state_machine() -> void:
	for child in get_children():
		child.state_machine = self
		child.player = player
		child.sprite = sprite
	change_state(starting_state)

func change_state(new_state):
	if not new_state:
		return
	if state:
		state.deactivate()
	state = new_state
	state.activate()

func _process(delta: float) -> void:
	if not state:
		return
	change_state(state.process_frame(delta))
func _physics_process(delta: float) -> void:
	if not state:
		return
	change_state(state.process_physics(delta))
func _input(event: InputEvent) -> void:
	if not state:
		return
	change_state(state.process_input(event))

extends Node
class_name StateMachine

var state : State
var player : Player
var sprite : AnimatedSprite2D
@export var starting_state : State

@export var full_egg_idle : State
@export var full_egg_walk : State
@export var full_egg_jump : State
@export var full_egg_jump_from_yolk: State
@export var full_egg_fall: State
@export var full_egg_fast_fall: State
@export var full_egg_hop: State
@export var egg_to_yolk: State
@export var yolk_idle: State
@export var yolk_walk: State
@export var yolk_jump: State
@export var yolk_fall: State
@export var yolk_ascending: State
@export var yolk_climb: State
@export var yolk_climb_idle: State
@export var yolk_to_egg: State


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

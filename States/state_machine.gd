extends Node
class_name StateMachine

@export var starting_state : State
@export var death : State
@export var full_egg_idle : State
@export var full_egg_walk : State
@export var full_egg_jump : State
@export var full_egg_jump_from_yolk: State
@export var full_egg_fall: State
@export var full_egg_hop: State
@export var egg_to_yolk: State
@export var yolk_idle: State
@export var yolk_walk: State
@export var yolk_fall: State
@export var yolk_ascending: State
@export var yolk_climb: State
@export var yolk_climb_idle: State
@export var yolk_to_egg: State

var state : State
var player : Player
var sprite : AnimatedSprite2D
var audio_controller_reference : AudioController
var particle_controller_reference : ParticleController

func initialize_state_machine() -> void:
	audio_controller_reference = player.audio_controller_reference
	particle_controller_reference = player.particle_controller_reference
	for child in get_children():
		child.state_machine = self
		child.player = player
		child.sprite = sprite
		child.audio_controller = audio_controller_reference
		child.particle_controller = particle_controller_reference
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

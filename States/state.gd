class_name State
extends Node

@export_color_no_alpha var placeholder_state_color : Color = Color.WHITE
@export var animation_name : String

@export_category("Audio")
@export_group("Enter sound","enter_sound_")
@export var enter_sound_sounds : Array[AudioStream]
@export var enter_sound_pitch_low : float = 0.7
@export var enter_sound_pitch_high : float = 1.3
@export_group("While in state sound","while_in_state_")
@export var while_in_state_sounds : Array[AudioStream]
@export var while_in_state_sound_low : float = 0.7
@export var while_in_state_sound_high : float = 1.3
@export var while_in_state_repeat_sound_after_seconds: float = 0.1
@export_group("Exit Sound","exit_sound_")
@export var exit_sound_sounds : Array[AudioStream]
@export var exit_sound_pitch_low : float = 0.7
@export var exit_sound_pitch_high : float = 1.3

@export_category("Particles")
@export_group("Enter particle","enter_particle_")
@export var enter_particle_particle : PackedScene
@export var enter_particle_particle_parent_to_player : bool = false
@export_group("While in state particle","while_in_state_")
@export var while_in_state_particle : PackedScene
@export var while_in_state_parent_to_player : bool = false
@export var while_in_state_repeat_particle_after_seconds: float = 0
@export_group("Exit particle","exit_particle_")
@export var exit_particle_particle : PackedScene
@export var exit_particle_parent_to_player : bool = false

var player : Player
var sprite : AnimatedSprite2D
var state_machine : StateMachine
var audio_controller : AudioController
var audio_loop_timer : Timer
var particle_controller : ParticleController
var particle_loop_timer : Timer

func activate():
	sprite.self_modulate = placeholder_state_color
	player.play_animation(animation_name)
	
	if while_in_state_sounds:
		loop_sound()
	elif enter_sound_sounds:
		audio_controller.play_sound(enter_sound_sounds.pick_random(), enter_sound_pitch_low, enter_sound_pitch_high)
	if while_in_state_particle:
		loop_particle()
	elif enter_particle_particle:
		particle_controller.spawn_particle(player,enter_particle_particle,enter_particle_particle_parent_to_player)
	

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
	if audio_loop_timer:
		audio_loop_timer.queue_free()
	if exit_sound_sounds:
		audio_controller.play_sound(exit_sound_sounds.pick_random(),exit_sound_pitch_low,exit_sound_pitch_high)
	if particle_loop_timer:
		particle_loop_timer.queue_free()
	if exit_particle_particle:
		particle_controller.spawn_particle(player,exit_particle_particle,exit_particle_parent_to_player)
	
func loop_sound() -> void:
	audio_loop_timer = Timer.new()
	add_child(audio_loop_timer)
	audio_loop_timer.wait_time = while_in_state_repeat_sound_after_seconds
	audio_loop_timer.start()
	while audio_loop_timer:
		await audio_loop_timer.timeout
		audio_controller.play_sound(while_in_state_sounds.pick_random(), while_in_state_sound_low, while_in_state_sound_high)
		if audio_loop_timer:
			audio_loop_timer.start()

func loop_particle() -> void:
	particle_loop_timer = Timer.new()
	add_child(particle_loop_timer)
	particle_loop_timer.wait_time = while_in_state_repeat_particle_after_seconds
	particle_loop_timer.start()
	while particle_loop_timer:
		await particle_loop_timer.timeout
		particle_controller.spawn_particle(player,while_in_state_particle,while_in_state_parent_to_player)
		particle_loop_timer.start()

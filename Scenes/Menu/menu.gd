extends Control

@export var animation_player: AnimationPlayer
@export var audio_controller: AudioController
@export var scene_change_animations: AnimationPlayer
@export var settings_screen: Panel
@export var credits_menu: Panel

@export_category("Sounds")
@export var yolk_squish_sound : AudioStream
@export var confirm_sound: AudioStream
@export var cancel_sound: AudioStream

var play_squish : bool = true

func _ready():
	play_squish = true
	animation_player.play("yolk_idle_bobbing")

func _on_play_pressed():
	if scene_change_animations.is_playing():
		return
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	scene_change_animations.play("exit_scene")
	await scene_change_animations.animation_finished
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_options_pressed():
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	settings_screen.visible = true
	
func _on_settings_back_pressed():
	audio_controller.play_sound(cancel_sound, 0.95, 1.05)
	settings_screen.visible = false

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if play_squish:
					audio_controller.play_sound(yolk_squish_sound,0.7,0.9)
				play_squish = false
				animation_player.play("yolk_clicked")
				await animation_player.animation_finished
				play_squish = true
				animation_player.play("yolk_idle_bobbing")

func _on_credits_pressed():
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	credits_menu.visible = true

func _on_credits_back_pressed():
	audio_controller.play_sound(cancel_sound, 0.95, 1.05)
	credits_menu.visible = false

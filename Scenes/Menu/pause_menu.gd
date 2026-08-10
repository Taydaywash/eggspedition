extends CanvasLayer

@export var animation_player: AnimationPlayer
@export var settings_screen: Panel
@export var audio_controller: AudioController

@export_category("Sounds")
@export var confirm_sound: AudioStream
@export var cancel_sound: AudioStream

func _ready():
	visible = false
	get_tree().paused = false

func _on_resume_pressed():
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	visible = false
	settings_screen.visible = false
	get_tree().paused = false

func _on_options_pressed():
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	settings_screen.visible = true

func _on_main_menu_pressed():
	audio_controller.play_sound(cancel_sound, 0.95, 1.05)
	get_tree().paused = false
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func _on_settings_back_pressed():
	audio_controller.play_sound(cancel_sound, 0.95, 1.05)
	settings_screen.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

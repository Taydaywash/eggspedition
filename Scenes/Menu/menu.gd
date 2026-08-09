extends Control

@export var animation_player: AnimationPlayer
@export var audio_controller: AudioController
@export var scene_change_animations: AnimationPlayer

@export_category("Sounds")
@export var yolk_squish_sound : AudioStream

var play_squish : bool = true

func _ready():
	play_squish = true
	animation_player.play("yolk_idle_bobbing")

func _on_play_pressed():
	scene_change_animations.play("exit_scene")
	await scene_change_animations.animation_finished
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_options_pressed():
	#get_tree().change_scene_to_file()
	pass

func _on_quit_pressed():
	scene_change_animations.play("exit_scene")
	await scene_change_animations.animation_finished
	get_tree().quit()

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

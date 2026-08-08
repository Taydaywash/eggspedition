extends Control

@export var animation_player: AnimationPlayer

func _ready():
	animation_player.play("yolk_idle_bobbing")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_options_pressed():
	#get_tree().change_scene_to_file()
	pass

func _on_quit_pressed():
	get_tree().quit()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				animation_player.play("yolk_clicked")
				await animation_player.animation_finished
				animation_player.play("yolk_idle_bobbing")

extends CanvasLayer
@export var animation_player: AnimationPlayer

func _ready():
	visible = false
	get_tree().paused = false

func _on_resume_pressed():
	visible = false
	get_tree().paused = false

func _on_main_menu_pressed():
	get_tree().paused = false
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

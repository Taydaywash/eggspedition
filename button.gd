class_name WeightedButton
extends Area2D

var pressed : bool = false
@export var connected_doors : Array[ButtonDoor]
@export var unpressed_sprite: Sprite2D
@export var pressed_sprite: Sprite2D

@export_category("Sounds")
@export var button_press_sound: AudioStream
@export var button_unpressed_sound: AudioStream

var audio_controller : AudioController


func _ready() -> void:
	audio_controller = get_tree().current_scene.get_node("AudioController")
	SignalController.connect("player_died", func():
		await SignalController.screen_is_black
		#button_unpressed()
		)

func button_pressed():
	audio_controller.play_sound(button_press_sound)
	pressed = true
	unpressed_sprite.visible = false
	pressed_sprite.visible = true
	SignalController.emit_signal("button_pressed",connected_doors)

func button_unpressed():
	audio_controller.play_sound(button_unpressed_sound)
	pressed = false
	unpressed_sprite.visible = true
	pressed_sprite.visible = false
	SignalController.emit_signal("button_unpressed",connected_doors)

func _on_body_entered(_body: Node2D) -> void:
	if not pressed:
		button_pressed()

func _on_body_exited(_body: Node2D) -> void:
	await get_tree().create_timer(0.2).timeout
	if not get_overlapping_areas() and not get_overlapping_bodies():
		button_unpressed()

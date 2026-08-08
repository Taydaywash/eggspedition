class_name WeightedButton
extends Area2D

var pressed : bool = false
@export var connected_doors : Array[ButtonDoor]
@export var unpressed_sprite: Sprite2D
@export var pressed_sprite: Sprite2D

func _ready() -> void:
	SignalController.connect("player_died", func():
		await SignalController.screen_is_black
		button_unpressed()
		)

func button_pressed():
	print("buttton pressed")
	SignalController.emit_signal("button_pressed",connected_doors)
	pressed = true
	unpressed_sprite.visible = false
	pressed_sprite.visible = true

func button_unpressed():
	print("buttton unpressed")
	SignalController.emit_signal("button_unpressed",connected_doors)
	pressed = false
	unpressed_sprite.visible = true
	pressed_sprite.visible = false

func _on_body_entered(_body: Node2D) -> void:
	if not pressed:
		button_pressed()

func _on_body_exited(_body: Node2D) -> void:
	if not get_overlapping_areas() and not get_overlapping_bodies():
		button_unpressed()

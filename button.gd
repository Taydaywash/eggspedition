class_name WeightedButton
extends Area2D

var pressed : bool = false
@export var connected_doors : Array[ButtonDoor]
@export var unpressed_sprite: Sprite2D
@export var pressed_sprite: Sprite2D


func button_pressed():
	SignalController.emit_signal("button_pressed",connected_doors)
	unpressed_sprite.visible = false
	pressed_sprite.visible = true

func button_unpressed():
	SignalController.emit_signal("button_unpressed",connected_doors)
	unpressed_sprite.visible = true
	pressed_sprite.visible = false

func _on_body_entered(_body: Node2D) -> void:
	button_pressed()

func _on_body_exited(_body: Node2D) -> void:
	button_unpressed()

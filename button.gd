class_name WeightedButton
extends Area2D

var pressed : bool = false
@export var connected_doors : Array[ButtonDoor]

func button_pressed():
	SignalController.emit_signal("button_pressed",connected_doors)

func button_unpressed():
	SignalController.emit_signal("button_unpressed",connected_doors)

func _on_body_entered(_body: Node2D) -> void:
	button_pressed()

func _on_body_exited(_body: Node2D) -> void:
	button_unpressed()

class_name Room
extends Node2D

@export var room_active : bool = false
@export var camera: Camera2D

func _ready() -> void:
	SignalController.connect("change_room",func (room):
		if room == self:
			room_activated()
		else:
			room_deactivated()
		)
	await get_tree().process_frame
	if room_active:
		SignalController.emit_signal("change_room",self)

func room_activated():
	room_active = true
	camera.enabled = true
	visible = true
func room_deactivated():
	room_active = false
	camera.enabled = false
	visible = false

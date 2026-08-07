@tool
extends Area2D
class_name Door

@export var door_size : Vector2 = Vector2(300,300)
@export var collision_shape_2d: CollisionShape2D
var room : Room
@export var connected_room_spawn_position : Vector2 = Vector2(300,300)

@export var jump_on_enter : bool = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape_2d.shape.set("size",door_size)
func _ready() -> void:
	collision_shape_2d.shape.set("size",door_size)
	room = get_parent()
	
func _on_body_entered(_body: Node2D) -> void:
	SignalController.emit_signal("change_room",room)

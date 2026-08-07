extends Area2D
@export var ray_cast: RayCast2D

func _ready() -> void:
	SignalController.connect("update_respawn_point",func(respawn_point):
		Global.respawn_point = ray_cast.get_collision_point()
		if respawn_point == self:
			modulate = Color.GREEN
		else:
			modulate = Color.WHITE
		)

func _on_body_entered(_body: Node2D) -> void:
	SignalController.emit_signal("update_respawn_point",self)
	

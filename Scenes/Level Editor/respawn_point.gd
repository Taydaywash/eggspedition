extends Area2D
@export var ray_cast: RayCast2D
@export var sprite: AnimatedSprite2D

func _ready() -> void:
	SignalController.connect("update_respawn_point",func(respawn_point):
		if respawn_point == self:
			Global.respawn_room = respawn_point.get_parent()
			Global.respawn_point = ray_cast.get_collision_point() - Vector2(0,64)
			print(Global.respawn_point)
			sprite.play("wave")
		else:
			sprite.play("idle")
		)

func _on_body_entered(_body: Node2D) -> void:
	SignalController.emit_signal("update_respawn_point",self)
	

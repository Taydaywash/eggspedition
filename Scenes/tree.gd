extends AnimatedSprite2D
@export var player: Player

func _process(_delta: float) -> void:
	if player.global_position.y < 1412:
		z_index = 7
		
	else:
		z_index = -2

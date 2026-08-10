extends Area2D
@export var ray_cast: RayCast2D
@export var sprite: AnimatedSprite2D
const CHECKPOINT_CONFETTI = preload("res://Assets/particles/checkpoint_confetti.tscn")
const CHECKPOINT_GET = preload("res://Assets/audio/checkpoint_get.wav")
@export var audio_controller: AudioController

func _ready() -> void:
	SignalController.connect("update_respawn_point",func(respawn_point):
		if respawn_point == self:
			Global.respawn_room = respawn_point.get_parent()
			Global.respawn_point = ray_cast.get_collision_point() - Vector2(0,84)
			print(Global.respawn_point)
			sprite.play("wave")
		else:
			sprite.play("idle")
		)

func _on_body_entered(_body: Node2D) -> void:
	if Global.respawn_point != ray_cast.get_collision_point() - Vector2(0,84):
		audio_controller.play_sound(CHECKPOINT_GET,1.0,1.0)
		var particle_instance = CHECKPOINT_CONFETTI.instantiate()
		add_child(particle_instance)
		particle_instance.global_position = self.global_position
		particle_instance.play()
	SignalController.emit_signal("update_respawn_point",self)
	

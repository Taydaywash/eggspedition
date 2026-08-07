extends CharacterBody2D
class_name Player

@export var jump_speed : float = 50
@export var max_fall_speed : float = 50
@export var gravity : float = 50
@export var move_speed : float = 50

@export_category("References")
@export var state_machine : StateMachine
@export var sprite: AnimatedSprite2D
@export var climbing_detector: Area2D
@export var full_egg_hitbox: CollisionShape2D
@export var yolk_hitbox: CollisionShape2D
@export var full_egg_hurtbox: Area2D
@export var yolk_hurtbox: Area2D

var is_on_climbable: bool = false

func _ready() -> void:
	state_machine.player = self
	state_machine.sprite = sprite
	await get_tree().process_frame
	state_machine.initialize_state_machine()

func _physics_process(_delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	is_on_climbable = climbing_detector.has_overlapping_bodies()
	

func play_animation(animation_name : String):
	if animation_name:
		sprite.play(animation_name)
	else:
		sprite.play("full_egg_idle")

func _on_player_hurtbox_body_entered(_body: Node2D) -> void:
	state_machine.change_state(state_machine.full_egg_idle)
	print(Global.respawn_point)
	position = Global.respawn_point

func change_hitbox(hitbox_name: String) -> void:
	print("hitbox changed")
	if hitbox_name == "egg":
		full_egg_hitbox.set_deferred("disabled", true)
		yolk_hitbox.set_deferred("disabled", false)
	elif hitbox_name == "yolk":
		full_egg_hitbox.set_deferred("disabled", false)
		yolk_hitbox.set_deferred("disabled", true)

func change_hurtbox(hurtbox_name: String) -> void:
	print("hurtbox changes")
	if hurtbox_name == "egg":
		full_egg_hurtbox.set_deferred("monitoring", true)
		full_egg_hurtbox.set_deferred("monitorable", true)
		yolk_hurtbox.set_deferred("monitoring", false)
		yolk_hurtbox.set_deferred("monitorable", false)
	elif hurtbox_name == "yolk":
		full_egg_hurtbox.set_deferred("monitoring", false)
		full_egg_hurtbox.set_deferred("monitorable", false)
		yolk_hurtbox.set_deferred("monitoring", true)
		yolk_hurtbox.set_deferred("monitorable", true)

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
	position = Global.respawn_point

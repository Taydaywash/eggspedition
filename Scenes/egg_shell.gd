extends Area2D

var player: Player = null
var is_moving: bool = false
const move_speed: float = 1500

func _ready() -> void:
	is_moving = false
	player = get_parent().get_node("Player")
	SignalController.connect("recall_egg", move_egg_shell)
	await get_tree().create_timer(0.1).timeout
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	
func _process(delta):
	if player and is_moving:
		rotation += .05
		global_position = global_position.move_toward(player.global_position, move_speed * delta)

func move_egg_shell() -> void:
	is_moving = true
	await get_tree().process_frame
	if get_overlapping_bodies():
		get_overlapping_bodies()[0].egg_shell_detector.emit_signal("area_entered",self)

#func _on_body_entered(_body):
	#if is_moving:
		#await get_tree().process_frame
		#call_deferred("queue_free")

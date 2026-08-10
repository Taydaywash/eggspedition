@tool
extends Door
@export var player: Player
@export var spawn_pos: Node2D
@export var room_04: Room
@export var door_3: Door

func _on_body_entered(_body: Node2D) -> void:
	player.state_machine.change_state(player.state_machine.full_egg_idle)
	player.can_recall = true
	player.set_deferred("global_position",spawn_pos.global_position)
	SignalController.emit_signal("change_room",room_04)
	music_player.stream = door_3.music
	music_player.playing = true

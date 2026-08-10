@tool
extends Door

var door_used : bool = false
@export var player: Player
@export var spawn_position: Node2D
@export var room_man: Room
@export var man_theme : AudioStream

func _on_body_entered(body: Node2D) -> void:
	if not door_used and not room.room_active:
		door_used = true
		player.state_machine.change_state(player.state_machine.yolk_climb)
		player.can_recall = false
		player.set_deferred("global_position",spawn_position.global_position)
		music_player.stream = man_theme
		music_player.playing = true
		SignalController.emit_signal("change_room",room_man)
		return
	else:
		super(body)

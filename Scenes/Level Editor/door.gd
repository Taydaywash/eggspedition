@tool
extends Area2D
class_name Door

@export var door_size : Vector2 = Vector2(300,300)
@export var collision_shape_2d: CollisionShape2D
var room : Room
@export var play_song_on_enter : bool = false
@export var music_player: AudioStreamPlayer2D
@export var music: AudioStream
@export var jump_on_enter : bool = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape_2d.shape.set("size",door_size)
func _ready() -> void:
	collision_shape_2d.shape.set("size",door_size)
	room = get_parent()
	
func _on_body_entered(body: Node2D) -> void:
	if not room.room_active:
		if play_song_on_enter:
			if music_player.stream != music:
				music_player.stream = music
				music_player.playing = true
		if jump_on_enter and get_parent().room_active == false:
			body.velocity.y = -1000
		SignalController.emit_signal("change_room",room)

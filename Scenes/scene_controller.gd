extends Node2D
@export var animation_player: AnimationPlayer

var audio_controller : AudioController

func _ready() -> void:
	animation_player.play("fade_to_clear")
	#SignalController.connect("player_died",fade_to_black)
	SignalController.connect("fade_to_black",fade_to_black)
	SignalController.connect("fade_to_clear",fade_to_clear)

func fade_to_black():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	SignalController.emit_signal("screen_is_black")
	SignalController.emit_signal("change_room",Global.respawn_room)
	SignalController.emit_signal("fade_to_clear")
func fade_to_clear():
	animation_player.play("fade_to_clear")
	await animation_player.animation_finished
	SignalController.emit_signal("screen_is_clear")

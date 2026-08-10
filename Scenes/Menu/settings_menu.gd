extends Panel

@export var audio_controller: AudioController
@export var master_scroll: VScrollBar
@export var sfx_scroll: VScrollBar
@export var music_scroll: VScrollBar

@export_category("Sounds")
@export var confirm_sound: AudioStream
@export var cancel_sound: AudioStream

var options : Dictionary = {
	"master_volume": 1,
	"music_volume": 1,
	"sfx_volume": 1,
}

func _ready() -> void:
	options = SaveLoad.load_options()
	AudioServer.set_bus_volume_linear(0,options.master_volume)
	AudioServer.set_bus_volume_linear(1,options.music_volume)
	AudioServer.set_bus_volume_linear(2,options.sfx_volume)
	master_scroll.value = AudioServer.get_bus_volume_linear(0) * 100.00
	music_scroll.value = AudioServer.get_bus_volume_linear(1) * 100.00
	sfx_scroll.value = AudioServer.get_bus_volume_linear(2) * 100.00

func apply_options():
	AudioServer.set_bus_volume_linear(0,options.master_volume)
	AudioServer.set_bus_volume_linear(1,options.music_volume)
	AudioServer.set_bus_volume_linear(2,options.sfx_volume)
	master_scroll.value = AudioServer.get_bus_volume_linear(0) * 100.00
	music_scroll.value = AudioServer.get_bus_volume_linear(1) * 100.00
	sfx_scroll.value = AudioServer.get_bus_volume_linear(2) * 100.00

func format_options():
	var formatted_options : Dictionary = {
	"master_volume": AudioServer.get_bus_volume_linear(0),
	"music_volume": AudioServer.get_bus_volume_linear(1),
	"sfx_volume": AudioServer.get_bus_volume_linear(2),
	}
	options = formatted_options
	return formatted_options

func _on_master_scroll_value_changed(value):
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	AudioServer.set_bus_volume_linear(0,value/100.00)
	SaveLoad.save_options(format_options())

func _on_music_scroll_value_changed(value):
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	AudioServer.set_bus_volume_linear(1,value/100.00)
	SaveLoad.save_options(format_options())

func _on_sfx_scroll_value_changed(value):
	audio_controller.play_sound(confirm_sound, 0.95, 1.05)
	AudioServer.set_bus_volume_linear(2,value/100.00)
	SaveLoad.save_options(format_options())

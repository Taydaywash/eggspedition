extends Room

var room_entered : bool = false
@export var trophy_egg: Sprite2D

func room_activated():
	if not room_entered:
		room_entered = true
		trophy_egg.visible = false
	else:
		trophy_egg.visible = true
	super()

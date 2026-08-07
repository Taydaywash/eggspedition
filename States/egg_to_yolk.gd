extends State



func activate():
	super()
	player.full_egg_hitbox.set_deferred("disabled", true)
	player.yolk_hitbox.set_deferred("disabled", false)

func process_input(_event : InputEvent) -> State:
	return

func process_physics(_delta):
	return state_machine.yolk_idle

func deactivate():
	super()

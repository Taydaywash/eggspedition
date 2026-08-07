extends State

func activate():
	super()
	player.change_hitbox("egg")
	player.change_hurtbox("egg")

func process_input(_event : InputEvent) -> State:
	return

func process_physics(_delta):
	return state_machine.full_egg_idle

func deactivate():
	super()

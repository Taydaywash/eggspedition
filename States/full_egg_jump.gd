extends State

@export var jump_velocity : int = 50

func activate():
	player.velocity.x = 0
	player.velocity.y = -jump_velocity
	super()

func process_physics(delta):
	player.move_and_slide()
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	if player.velocity.y >= 0:
		return state_machine.full_egg_fall
	return

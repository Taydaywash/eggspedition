extends State

@export var move_speed : int = 50

func process_physics(_delta):
	var input_direction = Input.get_axis("move_left","move_right")
	player.velocity.x = input_direction * move_speed
	player.move_and_slide()
	if player.velocity.x == 0:
		return state_machine.full_egg_idle_state
	return

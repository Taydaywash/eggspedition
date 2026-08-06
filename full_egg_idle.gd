extends State

func process_physics(_delta) -> State:
	var input_direction = Input.get_axis("move_left","move_right")
	if input_direction:
		return state_machine.full_egg_walk_state
	return

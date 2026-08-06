extends State

func activate():
	player.velocity.x = 0
	super()

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		if player.is_on_floor():
			return state_machine.full_egg_jump
	return

func process_physics(delta) -> State:
	var input_direction = Input.get_axis("move_left","move_right")
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if input_direction:
		return state_machine.full_egg_walk
	if player.velocity.y >= 1:
		return state_machine.full_egg_fall
	return

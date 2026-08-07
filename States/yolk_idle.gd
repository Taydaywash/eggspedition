extends State

func activate():
	player.velocity.x = 0
	super()

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		if player.is_on_floor():
			return state_machine.yolk_jump
	if event.is_action_pressed("recall"):
		return state_machine.yolk_to_egg
	return

func process_physics(delta) -> State:
	var input_direction = Input.get_axis("move_left","move_right")
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if input_direction:
		return state_machine.yolk_walk
	if !player.is_on_floor:
		return state_machine.yolk_fall
	if player.is_on_climbable:
			return state_machine.yolk_climb_idle
	return

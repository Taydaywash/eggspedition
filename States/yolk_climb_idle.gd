extends State

func activate():
	player.velocity.x = 0
	player.velocity.y = 0
	super()

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("move_up"):
		if player.is_on_climbable:
			return state_machine.yolk_climb
	return

func process_physics(_delta) -> State:
	var input_direction_x = Input.get_axis("move_left","move_right")
	var input_direction_y = Input.get_axis("move_up","move_down")
	player.move_and_slide()
	if input_direction_x or input_direction_y:
		return state_machine.yolk_climb
	if !player.is_on_climbable:
		return state_machine.yolk_fall
	return

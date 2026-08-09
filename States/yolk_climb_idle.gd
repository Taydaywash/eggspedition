extends State

func activate():
	super()
	player.velocity.x = 0
	player.velocity.y = 0

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("move_up"):
		if player.is_on_climbable:
			return state_machine.yolk_climb
	if event.is_action_pressed("recall"):
		SignalController.emit_signal("recall_egg")
		return state_machine.yolk_to_egg
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

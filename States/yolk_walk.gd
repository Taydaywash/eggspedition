extends State

@export var move_speed : int = 50

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("recall") and player.can_recall:
		SignalController.emit_signal("recall_egg")
		return state_machine.yolk_to_egg
	return

func process_physics(delta) -> State:
	var input_direction = Input.get_axis("move_left","move_right")
	player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if player.velocity.x == 0:
		return state_machine.yolk_idle
	if player.velocity.y >= 1:
		return state_machine.yolk_fall
	if player.is_on_climbable:
		return state_machine.yolk_climb_idle
	return

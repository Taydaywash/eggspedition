extends State

@export var climb_speed : int = 500

@export_category("References")
@export var climbing_detector: Area2D

func activate():
	super()

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return state_machine.yolk_jump
	return

func process_physics(_delta):
	if player.is_on_climbable:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		player.velocity = input_direction.normalized() * climb_speed
		player.move_and_slide()
	else: 
		return state_machine.yolk_fall

	return

func deactivate():
	super()

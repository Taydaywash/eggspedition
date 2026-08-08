extends State

@export var move_speed : int
@export var jump_input_buffer_delay : float = 0.2

@export_category("References")
@export var jump_input_buffer: Timer

var is_cracked: float = false

func activate():
	super()
	jump_input_buffer.wait_time = jump_input_buffer_delay

func process_input(event : InputEvent) -> State:
	#if (event.is_action_pressed("move_left") or event.is_action_pressed("move_right") or
		#event.is_action_pressed("move_up") or event.is_action_pressed("move_down") ):
		#if player.is_on_climbable:
			#return state_machine.yolk_climb_idle
	if event.is_action_pressed("recall"):
		SignalController.emit_signal("recall_egg")
		return state_machine.yolk_to_egg
	return

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if (abs(player.velocity.x) < move_speed) or (sign(input_direction) != sign(player.velocity.x)):
		player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if player.is_on_climbable:
		if player.velocity.x:
			return state_machine.yolk_climb
		return state_machine.yolk_climb_idle
	if player.velocity.y == 0:
		if player.velocity.x:
			return state_machine.yolk_walk
		if jump_input_buffer.time_left > 0:
			return state_machine.yolk_jump
		return state_machine.yolk_idle
	
	return

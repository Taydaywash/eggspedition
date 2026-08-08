extends State

@export_category("Parameters")
@export var move_speed : int
@export var air_move_acceleration : float = 2000
@export var distance_to_crack : float = 100
@export var jump_input_buffer_delay : float = 0.2

@export_category("References")
@export var jump_input_buffer: Timer

var peak_y: float = 0.0
var fall_distance: float = 0.0

func activate():
	super()
	peak_y = player.global_position.y
	jump_input_buffer.wait_time = jump_input_buffer_delay
	
func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		jump_input_buffer.start()
	if event.is_action_released("jump"):
		jump_input_buffer.stop()
	return

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if not input_direction:
		player.velocity.x = move_toward(player.velocity.x,0,delta*1000)
	elif input_direction == sign(player.velocity.x):
		player.velocity.x = move_toward(player.velocity.x,move_speed * input_direction,delta*1000)
	elif abs(player.velocity.x) > move_speed:
		player.velocity.x = move_toward(player.velocity.x,0,delta*2000)
	else:
		player.velocity.x = move_toward(player.velocity.x,move_speed * input_direction,delta*air_move_acceleration)
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
		
	if player.global_position.y < peak_y:
		peak_y = player.global_position.y
	fall_distance = abs(peak_y - player.global_position.y)
	player.fall_distance = fall_distance
	if player.velocity.y == 0:
		if fall_distance > distance_to_crack:
			return state_machine.egg_to_yolk
		if jump_input_buffer.time_left > 0:
			return state_machine.full_egg_jump
		if input_direction:
			return state_machine.full_egg_walk
		return state_machine.full_egg_idle
	return

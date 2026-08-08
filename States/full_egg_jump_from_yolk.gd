extends State

@export_category("Parameters")
@export var jump_velocity : int = 1000
@export var jump_input_buffer_delay : float = 0.2
@export var distance_to_crack : float = 100

@export_category("References")
@export var jump_input_buffer: Timer

var peak_y: float = 0.0
var fall_distance: float = 0.0

func activate():
	super()
	peak_y = player.global_position.y
	jump_input_buffer.wait_time = jump_input_buffer_delay
	jump_input_buffer.stop()
	player.velocity.y = -jump_velocity
	
func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		jump_input_buffer.start()
	if event.is_action_released("jump"):
		jump_input_buffer.stop()
	return null

func process_physics(delta):
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	
	if player.global_position.y < peak_y:
		peak_y = player.global_position.y
	fall_distance = abs(peak_y - player.global_position.y)
	player.fall_distance = fall_distance
	if player.is_on_floor():
		if fall_distance > distance_to_crack:
			return state_machine.egg_to_yolk
		if jump_input_buffer.time_left > 0:
			return state_machine.full_egg_jump
		return state_machine.full_egg_idle
	return

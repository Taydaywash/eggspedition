extends State

@export var move_speed : int
@export var jump_input_buffer_delay : float = 0.2

@export_category("References")
@export var jump_input_buffer: Timer

var peak_y: float = 0.0
var fall_distance: float = 0.0
var is_cracked: float = false

func activate():
	super()
	jump_input_buffer.wait_time = jump_input_buffer_delay
	peak_y = player.global_position.y
	
func process_input(event : InputEvent) -> State:
	#if event.is_action_pressed("recall"):
		#SignalController.emit_signal("recall_egg")
		#return state_machine.yolk_to_egg
	#if event.is_action_released("jump"):
		#player.velocity.y /= 2
	return

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if (abs(player.velocity.x) < move_speed) or (sign(input_direction) != sign(player.velocity.x)):
		player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		return state_machine.yolk_fall
	return

extends State

@export_category("Parameters")
@export var jump_velocity : int = 1000
@export var jump_input_buffer_delay : float = 0.2

@export_category("References")
@export var jump_input_buffer: Timer

func _ready() -> void:
	jump_input_buffer.one_shot = true
	jump_input_buffer.wait_time = jump_input_buffer_delay

func activate():
	super()
	jump_input_buffer.stop()
	player.velocity.y = -jump_velocity
	
func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		jump_input_buffer.start()
	if event.is_action_released("jump"):
		jump_input_buffer.stop()
	return null

func process_physics(delta):
	#var input_direction = Input.get_axis("move_left","move_right")
	#player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		return state_machine.full_egg_fall
	if player.is_on_floor():
		if jump_input_buffer.time_left > 0:
			return
	return

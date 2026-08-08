extends State

@export var jump_velocity : int = 50
@export var move_speed : int = 500
@export var jump_input_buffer_delay : float = 0.2

@export_category("References")
@export var jump_input_buffer: Timer

func _ready() -> void:
	jump_input_buffer.one_shot = true
	jump_input_buffer.wait_time = jump_input_buffer_delay

func activate():
	super()
	jump_input_buffer.stop()
	player.velocity.x = 0
	player.velocity.y = -jump_velocity
	
func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("recall"):
		SignalController.emit_signal("recall_egg")
		return state_machine.yolk_to_egg
	if event.is_action_pressed("jump"):
		jump_input_buffer.start()
	if event.is_action_released("jump"):
		player.velocity.y /= 2
		jump_input_buffer.stop()
	return

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if (abs(player.velocity.x) < move_speed) or (sign(input_direction) != sign(player.velocity.x)):
		player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y, player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if player.is_on_floor():
		if jump_input_buffer.time_left > 0:
			return
	if player.velocity.y >= 0:
		return state_machine.yolk_fall
	return

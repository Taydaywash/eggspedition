extends State

@export var move_speed : int = 50
@export var jump_horizontal_velocity : int = 700
var finishing_roll = false
var can_exit_state = true

func activate():
	finishing_roll = false
	super()

func process_input(event : InputEvent) -> State:
	if (event.is_action_pressed("move_left") and player.velocity.x >= 0 and (sprite.frame == 3 or sprite.frame == 4)):
		if player.is_on_floor():
			player.velocity.x = -jump_horizontal_velocity
			return state_machine.full_egg_jump
	if (event.is_action_pressed("move_right") and player.velocity.x <= 0 and (sprite.frame == 3 or sprite.frame == 4)):
		if player.is_on_floor():
			player.velocity.x = jump_horizontal_velocity
			return state_machine.full_egg_jump
	return

func process_physics(delta):
	var input_direction = 0
	if player.velocity.x == 0 and not finishing_roll:
		input_direction = Input.get_axis("move_left","move_right")
		player.velocity.x = input_direction * move_speed
	if player.velocity.y >= 1:
		return state_machine.full_egg_fall
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if finishing_roll:
		if can_exit_state:
			input_direction = Input.get_axis("move_left","move_right")
			if input_direction == 0:
				return state_machine.full_egg_idle
			else:
				finishing_roll = false
				can_exit_state = true
				player.velocity.x = 0
		return
		
	finishing_roll = true
	can_exit_state = false
	finish_roll()
	
	return

func finish_roll():
	await sprite.animation_looped
	can_exit_state = true

func deactivate():
	finishing_roll = false
	can_exit_state = true
	super()
	

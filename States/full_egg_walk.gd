extends State

@export var move_speed : int = 50
@export var jump_horizontal_velocity : int = 700
var finishing_roll = false
var can_exit_state = true

func activate():
	super()
	print("rolling")
	if abs(player.velocity.x) < move_speed:
		player.velocity.x = 0
	finishing_roll = false

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		if (sprite.frame == 3 or sprite.frame == 4):
			player.velocity.x = sign(player.velocity.x) * jump_horizontal_velocity
			return state_machine.full_egg_jump
		return state_machine.full_egg_hop
	#if (event.is_action_pressed("move_left") and player.velocity.x >= 0):
		#if (sprite.frame == 3 or sprite.frame == 4):
			#player.velocity.x = -jump_horizontal_velocity
			#return state_machine.full_egg_jump
		#else:
			#player.velocity.x = -move_speed
			#sprite.frame = 0
			#return state_machine.full_egg_walk
	#if (event.is_action_pressed("move_right") and player.velocity.x <= 0): 
		#if (sprite.frame == 3 or sprite.frame == 4):
			#player.velocity.x = jump_horizontal_velocity
			#return state_machine.full_egg_jump
		#else:
			#player.velocity.x = move_speed
			#sprite.frame = 0
			#return state_machine.full_egg_walk
	return

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if abs(player.velocity.x) > move_speed:
		player.velocity.x = move_toward(player.velocity.x,move_speed * sign(player.velocity.x),delta*2000)
	if not input_direction:
		player.velocity.x = move_toward(player.velocity.x,0,delta*2000)
	elif player.velocity.x == 0 and not finishing_roll:
		player.velocity.x = input_direction * move_speed
	if player.velocity.y >= 1:
		return state_machine.full_egg_fall
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if finishing_roll:
		if can_exit_state:
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
	

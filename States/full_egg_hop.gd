extends State

@export var jump_velocity : int = 50
@export var move_speed : int

func activate():
	super()
	print("full_egg_hop")
	player.velocity.y = -jump_velocity

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if abs(player.velocity.x) <= move_speed:
		player.velocity.x = input_direction * move_speed
	elif abs(player.velocity.x) > move_speed:
		player.velocity.x = move_toward(player.velocity.x,move_speed * sign(player.velocity.x),delta*500)
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		return state_machine.full_egg_fall
	return

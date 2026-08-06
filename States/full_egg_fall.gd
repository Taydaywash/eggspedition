extends State

@export var move_speed : int

var peak_y: float = 0.0
var fall_distance: float = 0.0

func activate():
	peak_y = player.global_position.y

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
	if player.velocity.y == 0:
		if player.velocity.x:
			return state_machine.full_egg_walk
		return state_machine.full_egg_idle
		
	if player.global_position.y < peak_y:
		peak_y = player.global_position.y
	
	return
	
func deactivate():
	fall_distance = abs(peak_y - player.global_position.y)
	print("Fallen Pixels: ", fall_distance)
	peak_y = player.global_position.y

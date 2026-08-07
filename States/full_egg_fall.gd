extends State

@export var move_speed : int
@export var distance_to_crack : float = 100

var peak_y: float = 0.0
var fall_distance: float = 0.0

func activate():
	super()
	peak_y = player.global_position.y

func process_physics(delta):
	var input_direction = Input.get_axis("move_left","move_right")
	if (abs(player.velocity.x) < move_speed) or (sign(input_direction) != sign(player.velocity.x)):
		player.velocity.x = input_direction * move_speed
	player.velocity.y = move_toward(player.velocity.y,player.max_fall_speed,delta * player.gravity)
	player.move_and_slide()
		
	if player.global_position.y < peak_y:
		peak_y = player.global_position.y
	fall_distance = abs(peak_y - player.global_position.y)
		
	if player.velocity.y == 0:
		if player.velocity.x:
			#return state_machine.full_egg_walk
			pass
		if fall_distance > distance_to_crack:
			return state_machine.egg_to_yolk
		return state_machine.full_egg_idle
	return
	
func deactivate():
	super()
	peak_y = player.global_position.y

extends State

@export var bounce_multiplier: float = 1.0
@export var jump_input_buffer: Timer
@export var egg_shell_scene: PackedScene

var difference_velocity: float

func activate():
	super()
	player.change_hitbox("yolk")
	player.change_hurtbox("yolk")
	difference_velocity = sqrt(player.fall_distance * player.gravity * bounce_multiplier) 
	if jump_input_buffer.time_left:
		player.velocity.y = -difference_velocity
	else:
		player.velocity.y = -500
	spawn_egg_shell()

func process_physics(_delta) -> State:
	player.move_and_slide()
	return state_machine.yolk_ascending

func deactivate():
	super()
	
func spawn_egg_shell() -> void:
	var egg_shell_instance = egg_shell_scene.instantiate()
	player.get_parent().add_child(egg_shell_instance)
	egg_shell_instance.global_position = player.global_position + Vector2(0, 88)

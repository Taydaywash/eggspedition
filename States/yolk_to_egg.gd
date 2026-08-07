extends State

@export var push_speed: float = 1000

var egg_returned: bool = false
var direction: Vector2 = Vector2.ZERO

func activate():
	super()
	egg_returned = false
	player.change_hitbox("egg")
	player.change_hurtbox("egg")
	player.velocity = Vector2.ZERO

func process_input(_event : InputEvent) -> State:
	return

func process_physics(_delta) -> State:
	if egg_returned:
		player.velocity = direction * push_speed
		#player.move_and_slide()
		return state_machine.full_egg_jump
	return

func deactivate():
	super()

func _on_egg_shell_detector_area_entered(area):
	direction = (player.global_position - area.global_position).normalized()
	area.call_deferred("queue_free")
	egg_returned = true
	print(direction)

extends BaseController

var input = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	if not player_ball.is_alive:
		return
		
	var new_input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if new_input != Vector2(0,0):
		input = new_input
		
	player_ball.input = new_input.normalized()
	
	if Input.is_action_pressed("shoot"):
		player_ball.is_pressure = true
	
	if Input.is_action_just_released("shoot"):
		player_ball.shoot()
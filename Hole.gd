extends Area2D

class_name Hole

func _on_Hole_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player_ball"):
		body.kill()
		
	if body.is_in_group("energy_ball"):
		body.destroy()
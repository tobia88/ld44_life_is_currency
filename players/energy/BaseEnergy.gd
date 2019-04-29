extends RigidBody2D

class_name BaseEnergy

var wealth = 1000
var key = null
var last_hit_player = null

signal on_dead(energy)

func init(key: String, data):
	self.key = key
	self.wealth = data.wealth
	contact_monitor = true
	contacts_reported = 1

func destroy():
	if last_hit_player != null:
		last_hit_player.get_energy(self)
		print("Player: " + last_hit_player.name + " get energy " + key)
		
	queue_free()

func _on_BaseBall_body_entered(body: Node) -> void:
	if body.is_in_group("player_ball"):
		last_hit_player = body
		print("Last hit player " + key)
		
	if body.is_in_group("energy_ball"):
		body.last_hit_player = last_hit_player
		print("Body Name: " + body.name)

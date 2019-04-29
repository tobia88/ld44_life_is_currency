extends RigidBody2D

class_name PlayerBall

const MAX_SHOOT_FORCE = 500.0
const MIN_SHOOT_FORCE = 250.0
const MAX_DURATION = 1.5
const DRAG = 0.995

var input = Vector2(0,0)
var is_alive = true
var is_pressure = false
var shoot_timer = 0
var wealth = 0 setget set_wealth

var energies = []

signal on_wealth_changed(player, wealth)
signal on_player_dead(player)

export(NodePath) var controller_path


func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	if is_pressure:
		shoot_timer = shoot_timer + delta
		shoot_timer = min(shoot_timer, MAX_DURATION)
		
	linear_velocity *= DRAG

func shoot() -> void:
	var force = lerp(MIN_SHOOT_FORCE, MAX_SHOOT_FORCE, shoot_timer / MAX_DURATION)
	linear_velocity = input * force
	shoot_timer = 0
	
func get_energy(energy: BaseEnergy):
	wealth += energy.wealth
	energies.append(energy.key)
	
func drop_energies() -> Array:
	var retval = []
	
	if energies.size() <= 0:
		return retval
	
	var drop = max(1, energies.size() / 2)
	
	for i in range(drop):
		var rand_index = rand_range(0, energies.size())
		retval.append(energies[rand_index])
		energies.remove(rand_index)
		
	return retval
	
func reset():
	is_alive = true
	visible = true
	sleeping = false

func kill() -> void:
	is_alive = false
	visible = false
	sleeping = true
	emit_signal("on_player_dead", self)
	
func set_wealth(value) -> void:
	wealth = value
	emit_signal("on_wealth_changed", self, wealth)

func _on_PlayerBall_body_entered(body: Node) -> void:
	print(body.name)

extends Node

const PLAYER_AMOUNT = 3

onready var player_scene = preload("res://players/PlayerControlBall.tscn")
onready var energy_scene = preload("res://players/energy/EnergyBall.tscn")
onready var energy_spawners = $EnergySpawnerGroup.get_children()

onready var energy_group = $EnergyGroup

var players = []
var energies = []
var holes = []

func _ready() -> void:
	randomize()
	for p in get_children():
		if p.is_in_group("player_ball"):
			p.connect("on_wealth_changed", self, "on_player_wealth_changed")
			p.connect("on_player_dead", self, "on_player_dead_handler")
			players.append(p)

	print("Player Count: " + str(players.size()))
	print("Energy Count: " + str(energies.size()))

	init_energies()

func init_energies():
	var keys = DataMng.ENERGIES.keys()
	
	for e in energy_spawners:
		var es = e as EnergySpawner
		for i in range(es.MAX_LENGTH):
			var rand_key = keys[randi() % keys.size()]
			var pos = es.get_pos(i)
			create_energy_by_key(rand_key, pos)
			
func create_energy_by_key(key: String, pos: Vector2) -> void:
	print("Create Energy Ball: " + key + " on " + str(pos))
	var energy = energy_scene.instance()
	energy.global_position = pos
	energy.init(key, DataMng.ENERGIES[key])
	energy_group.add_child(energy)
	energies.append(energy)

func on_player_wealth_changed(player, wealth):
	print(player.wealth)

func on_player_dead_handler(player):
	var drop_list = player.drop_energies()
	for e in drop_list:
		create_energy_by_key(e, Vector2())
		
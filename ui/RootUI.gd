extends Control

onready var status_prefab = preload("res://ui/player_status/PlayerStatus.tscn")

var status_group = []

func create_status(dict: Dictionary) -> void:
	status_group.resize(dict.size())
	
	for i in range(dict.size()):
		var inst = status_prefab.instance()
		inst.init(dict[i]["color"])
		
		status_group[i] = inst
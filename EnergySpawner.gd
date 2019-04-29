tool

extends Node2D

class_name EnergySpawner

export(float) var SPACING = 5 setget set_spacing
export(int, 5, 10) var MAX_LENGTH = 5 setget set_max_length

func set_spacing(value):
	SPACING = value
	update()

func set_max_length(value):
	MAX_LENGTH = value
	update()
	
func get_pos(index):
	var width = SPACING * (MAX_LENGTH - 1)
	var origin_x = global_position.x -width * 0.5
	return Vector2(origin_x + SPACING * index, global_position.y)
	
func _draw() -> void:
	var width = SPACING * (MAX_LENGTH - 1)
	var origin = -width * 0.5
	
	for i in range(MAX_LENGTH):
		var pos = Vector2(origin + i * SPACING, 0)
		draw_circle(pos, SPACING * 0.5, Color("#A6CE5E55"))
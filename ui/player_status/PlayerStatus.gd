extends MarginContainer

var gold setget set_gold

func init(color):
	$ColorRect.color = color
	
func set_gold(gold):
	$Name.text = "$" + str(gold)
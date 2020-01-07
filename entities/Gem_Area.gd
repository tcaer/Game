extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter")

func _on_body_enter(body):
	print('Collision')
	
	match body.get_name():
		'Player':
			body.hit_by_gem()
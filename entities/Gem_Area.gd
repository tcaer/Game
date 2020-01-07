extends Area2D

onready var gem_tracker = get_parent().get_parent().get_node('Gem_Tracker')

func _ready():
	connect("body_entered", self, "_on_body_enter")

func _on_body_enter(body):
	match body.get_name():
		'Player':
			body.hit_by_gem()
			
			gem_tracker.decrease_num_gems(self)
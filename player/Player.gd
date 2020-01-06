extends RigidBody2D

const FORCE_POWER = 380
var is_pressed = false

onready var player_sprite = get_node("Player_Sprite")

func _ready():
	set_process(true)
	
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2

func _input(event):
	if (event.is_pressed() and event is InputEventMouseButton):
		if (!is_pressed):
			Engine.time_scale = 0.5 # No point to set the time scale every frame
			
		is_pressed = true
	elif(!event.is_pressed() and event is InputEventMouseButton and is_pressed):
		is_pressed = false
		handle_mouse_released()
		
func _process(delta):
	update()
		
func _draw():
	if (is_pressed):
		handle_mouse_down()

func handle_mouse_down():
	var to = get_viewport().get_mouse_position()
	var from = position
	
	draw_line(Vector2(), to - from, Color(1, 1, 1), 5)
	
func handle_mouse_released():
	# Reset player velocity
	linear_velocity = Vector2()
	
	var to = get_viewport().get_mouse_position()
	var from = position
	
	var force = from - to
	force = force.normalized() * FORCE_POWER # Set max length of force
	
	apply_impulse(Vector2(), force)
	
	Engine.time_scale = 1

func _physics_process(delta):
	rotate_sprite()
	
func rotate_sprite():
	if (!is_pressed):
		var velocity_angle = linear_velocity.angle()
		player_sprite.rotation = velocity_angle
	if (is_pressed):
		var offset_vector = position - get_viewport().get_mouse_position()
		player_sprite.rotation = offset_vector.angle()
		
func calculate_position_at_time(elapsed_time, launch_velocity):
	var initial_position = position
	
	return weight * elapsed_time * elapsed_time * 0.5 + launch_velocity * elapsed_time + initial_position
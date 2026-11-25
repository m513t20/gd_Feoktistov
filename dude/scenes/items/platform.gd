extends StaticBody2D

@export var amplitude_y: float = 100.0
@export var base_velocity: float = 80.0

var base_position: Vector2
var is_moving_y: bool = false
var moving_up = true

func _ready() -> void:
	base_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_moving_y:
		return
	if moving_up and global_position.y > base_position.y - amplitude_y:
		global_position.y -= delta * base_velocity
		moving_up = global_position.y > base_position.y - amplitude_y
	else:
		global_position.y += delta * base_velocity
		moving_up = global_position.y > base_position.y + amplitude_y
	
	

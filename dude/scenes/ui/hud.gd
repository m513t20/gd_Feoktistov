extends Node2D

@export var max_health: int = 3
@export var health_texture: Texture2D

var current_health: int = max_health:
	set(value):
		current_health = value
		print("SS")
		update_health()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health()

func update_health():
	var contiainer: HBoxContainer = $Panel/HBoxContainer
	if contiainer: 
		for child in contiainer.get_children():
			child.queue_free()
			
		for i in current_health:
			var health = TextureRect.new() 
			health.texture = health_texture
			health.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
			contiainer.add_child(health)

func on_hit():
	if current_health > 0:
		current_health -= 1
	else:
		current_health = 3

extends Node2D

signal got_hit;

var camera: Camera2D
var player: CharacterBody2D

@onready var platforms = $Platforms
@onready var spawn = $Spawn

@export var platform_scene: PackedScene
@export var offscreen_distance: float = 300.
@export var min_gap: float = 50
@export var max_gap: float = 150
@export var min_y: float = 300
@export var max_y: float = 500

var spawned: Array[Node] = []
var right_x: float = 0
var left_x: float = 0

func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	var camera_pos = camera.global_position
	var half_w = screen_size.x / 2
	var left_edge =  camera_pos.x - half_w
	var right_edge = camera_pos.x + half_w
	while right_x < right_edge + offscreen_distance:
		var gap_modifier: int = player.global_position.x / 7
		create_platform(right_x + randf_range(min_gap, max_gap) + gap_modifier)
		right_x = spawned[-1].position.x
	
	for i in  range(spawned.size()-1, -1, -1):
		var platform = spawned[i]
		if platform.position.x < left_edge - offscreen_distance:
			platform.queue_free()
			spawned.remove_at(i)

func _player_fell(body: Node2D) -> void:
	if body.name != player.name:
		return
	got_hit.emit()
	reset_position()

func _on_finish(body: Node2D) -> void:
	reset_position()

func reset_position():
	player.global_position = spawn.global_position
	right_x = 0
	for i in  range(spawned.size()-1, -1, -1):
		var platform = spawned[i]
		platform.queue_free()
		spawned.remove_at(i)
	create_platform(player.global_position.x)

func create_platform(x: float):
	if not platform_scene:
		return
	var platform = platform_scene.instantiate()
	platform.position.x = x 
	platform.position.y = randf_range(min_y, max_y)
	platform.is_moving_y = x > 1500
	platforms.add_child(platform)
	spawned.append(platform)

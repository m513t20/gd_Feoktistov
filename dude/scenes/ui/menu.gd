extends Node2D

signal level_changed(value)

@onready var level_options = $CenterContainer/VBoxContainer/OptionButton
@onready var slider: HSlider = $CenterContainer/VBoxContainer/HBoxContainer/HSlider

func _unpause():
	get_tree().paused = false
	hide()

func _on_exit():
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_pressed() -> void:
	_unpause()

func _on_exit_pressed() -> void:
	_on_exit()
	
func _on_volume_changed(value: float):
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func get_settings() -> Dictionary:
	var settings: Dictionary = {"volume": slider.value}
	return settings

func load_settings(settings: Dictionary):
	var volume = settings.get("volume", 1.0)
	slider.value = volume

func update_levels(levels: Array):
	for level in levels:
		level_options.add_item(level)

func on_level_button(value):
	_unpause()
	level_changed.emit(level_options.get_item_text(value))

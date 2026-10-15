extends Label

var alive_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	alive_time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	alive_time += delta
	self.text = "alive time: %d" % alive_time

func reset():
	alive_time = 0.0

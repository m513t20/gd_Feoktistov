extends Node

signal reset

var speed: float = 0
var max_speed: float = 420
var velocity: Vector2 = Vector2(0,0)
@onready var speed_label: Label = self.get_node("Speedometer")
@onready var shield: Sprite2D = self.get_node("ShipSprite/ShieldSprite")
var shield_restoration: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		speed += 100 * delta
		if speed > max_speed:
			speed = max_speed
	if Input.is_action_pressed("ui_down"):
		speed -= 100 * delta
		if speed < 0:
			speed = 0
	if Input.is_action_pressed("ui_left"):
		self.rotation -= 5.0 * delta
	if Input.is_action_pressed("ui_right"):
		self.rotation += 5.0 * delta
	
	var x = 0.1 * cos(self.rotation + PI / 2)
	var y = 0.1 * sin(self.rotation + PI / 2)
	
	velocity = speed * delta * Vector2(x, y).normalized()
	speed_label.text = "%d" % velocity.length()
	self.position += velocity
	
	if shield_restoration > 0:
		shield_restoration -= delta
	if shield_restoration <= 0:
		shield.visible = true
	
func damaged():
	shield.visible = false
	shield_restoration = 1.0
	reset.emit()

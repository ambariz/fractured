extends AnimatableBody2D

@export var distance := 60.0

@export var speed := 2.0

var start_x: float
var time := 0.0


func _ready() -> void:
	start_x = position.x


func _physics_process(delta: float) -> void:
	time += delta * speed
	position.x = start_x + sin(time) * distance

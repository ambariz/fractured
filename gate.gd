extends StaticBody2D

@export var required_money := 1

var opened := false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var gate_message = get_tree().get_first_node_in_group("gate_message")

var half_texture = preload("res://art/life/gate.png")
var open_texture = preload("res://art/life/gate.png")


func _ready() -> void:
	$Detector.body_entered.connect(_on_detector_body_entered)
	$Detector.body_exited.connect(_on_detector_body_exited)


func _on_detector_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	if opened:
		return

	print("gate closed need money: ", GameManager.money)

	if GameManager.money >= required_money:
		GameManager.money -= required_money
		open_gate()
	else:
		if gate_message:
			gate_message.text = "You need %d to open this gate..." % required_money
			gate_message.show()
		print("Gate locked!")


func open_gate() -> void:
	opened = true

	print("OPENING GATE!")

	sprite.texture = half_texture

	await get_tree().create_timer(0.25).timeout

	sprite.texture = open_texture

	# Disable the physical wall
	collision.set_deferred("disabled", true)
	sprite.hide()
 
	print("GATE OPENED! Money left: ", GameManager.money)

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	if gate_message:
		gate_message.hide()

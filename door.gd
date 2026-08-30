extends Area2D

var opened := false

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

var closed_texture = preload("res://art/life/door_closed_bg.png")
var half_texture = preload("res://art/life/door_half_open_bg.png")
var open_texture = preload("res://art/life/door_full_open_bg.png")


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	if GameManager.keys_collected >= GameManager.total_keys:
		open_door()
	else:
		print("Door locked! Keys: ", GameManager.keys_collected, " / ", GameManager.total_keys)


func open_door() -> void:
	if opened:
		return
	opened = true
	sprite.texture = half_texture
	await get_tree().create_timer(0.25).timeout
	sprite.texture = open_texture
	collision.disabled = true
	print("DOOR OPENED!")

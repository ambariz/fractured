extends Area2D

@export var required_money := 1

var opened := false
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

var half_texture = preload("res://art/life/gate.png")
var open_texture = preload("res://art/life/gate.png")

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	if opened:
		return
		
	if GameManager.money >= required_money:
		GameManager.money -= required_money
		open_gate()
	else:
		print("Gate Locked! Money:",GameManager.money,"/",required_money)
		
func open_gate() -> void:
	opened = true
	sprite.texture = half_texture
	await get_tree().create_timer(0.25).timeout
	sprite.texture = open_texture
	collision.disabled = true 
	print("gate opened")

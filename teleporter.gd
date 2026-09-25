extends Area2D

@export var teleport_x := 60.0
@export var teleport_y := 440.0

var teleporting := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	
	if body.name != "Player":
		return
	if teleporting:
		return

	teleporting = true
	
	AudioManager.play_sfx(("portal"))

	body.global_position = Vector2(teleport_x, teleport_y)
	body.velocity = Vector2.ZERO

	print("Teleported to: ", body.global_position)

	await get_tree().create_timer(0.5).timeout
	teleporting = false

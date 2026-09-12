extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	var target = get_parent().get_node("Teleporter2")

	body.global_position = target.global_position
	body.velocity = Vector2.ZERO

	print("Teleported to: ", body.global_position)

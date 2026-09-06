extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		GameManager.add_money()
		GameManager.money_collected += 1
		queue_free()

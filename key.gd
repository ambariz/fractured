extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		GameManager.add_key()
		print("KEY TOUCHED BY : ",body.name)
		queue_free()


	#if body is CharacterBody2D:
		#GameManager.add_key()
		#queue_free()

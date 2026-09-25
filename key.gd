extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) -> void:
	if body.name != "Player":
		return
		
	GameManager.add_key()
	AudioManager.play_sfx(("key"))
	queue_free()
	
	if GameManager.keys_collected == GameManager.total_keys:
		
		var ending_message = get_tree().get_first_node_in_group("ending_message")
		
		if ending_message:
			ending_message.text = "All keys collected!\nNow find the door!\n\nPress X to close!"
			ending_message.show()
			AudioManager.play_text()
			await get_tree().create_timer(3.0).timeout
	
	print("KEY TOUCHED BY : ",body.name)
		
		
func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
	
		if event.pressed and not event.echo and event.keycode == KEY_X:
			var ending_message = get_tree().get_first_node_in_group("ending_message")
	
			if ending_message:
				ending_message.hide()

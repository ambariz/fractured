extends Area2D

var ending_active := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	GameManager.add_key()
	AudioManager.play_sfx("key")

	if GameManager.keys_collected == GameManager.total_keys:

		var ending_message = get_tree().get_first_node_in_group("ending_message")

		if ending_message:
			ending_message.text = "All keys collected!\nNow find the door!\n\nPress X to close!"
			ending_message.show()
			ending_message.process_mode = Node.PROCESS_MODE_ALWAYS

			AudioManager.play_text()

			ending_active = true
			get_tree().paused = true

			return

	queue_free()

	print("KEY TOUCHED BY : ", body.name)


func _input(event: InputEvent) -> void:

	if not ending_active:
		return

	if event is InputEventKey:
		if event.pressed and not event.echo:
			if event.keycode == KEY_X:

				var ending_message = get_tree().get_first_node_in_group("ending_message")

				if ending_message:
					ending_message.hide()

				get_tree().paused = false
				ending_active = false

				queue_free()

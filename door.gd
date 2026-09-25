extends Area2D

var opened := false

@onready var sprite: Sprite2D = $Sprite2D

@onready var collision: CollisionShape2D = $CollisionShape2D

var closed_texture = preload("res://art/life/door_closed_bg.png")
var half_texture = preload("res://art/life/door_half_open_bg.png")
var open_texture = preload("res://art/life/door_full_open_bg.png")


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_body_entered(body: Node2D) -> void:
	
	if body.name != "Player":
		return

	if GameManager.keys_collected >= GameManager.total_keys:
		open_door()
		
	else:
		var remaining: int = GameManager.total_keys - GameManager.keys_collected
		var gate_message = get_tree().get_first_node_in_group("gate_message")

		if gate_message:
			gate_message.text = "You need %d more key%s!" % [remaining,"" if remaining == 1 else "s"]
			gate_message.show()


func _on_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return

	var gate_message = get_tree().get_first_node_in_group("gate_message")

	if gate_message:
		gate_message.hide()


func open_door() -> void:
	if opened:
		return

	opened = true

	sprite.texture = half_texture

	await get_tree().create_timer(0.5).timeout

	sprite.texture = open_texture
	collision.set_deferred("disabled", true)

	var gate_message = get_tree().get_first_node_in_group("gate_message")

	if gate_message:
		gate_message.hide()

	var ending_message = get_tree().get_first_node_in_group("ending_message")

	if ending_message:
		ending_message.text = "YOU WON!\n\nYou cleared the Level Yaaaaayyy!\n\nPress R to play again"
		ending_message.show()

	get_tree().paused = true


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo:

			if event.keycode == KEY_X:
				var key_message = get_tree().get_first_node_in_group("key_complete_message")

				if key_message:
					key_message.hide()

			if opened and event.keycode == KEY_R:
				GameManager.new_game()
				get_tree().paused = false
				get_tree().reload_current_scene()

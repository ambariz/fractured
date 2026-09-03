extends StaticBody2D

var opened := false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	
	$Detector.body_entered.connect(_on_detector_body_entered)
	$Detector.body_exited.connect(_on_detector_body_exited)
	
	update_gate_display()


func _on_detector_body_entered(body: Node2D) -> void:
	
	if body.name != "Player":
		return

	if opened:
		return

	var gate_message = get_tree().get_first_node_in_group("gate_message")
	var required = GameManager.get_next_gate_cost()

	if GameManager.money >= required:
		GameManager.money -= required
		open_gate()
	else:
		if gate_message:
			gate_message.text = "You need %d bag%s to open this gate!" % [required, "s" if required > 1 else ""]
			gate_message.show()


func _on_detector_body_exited(body: Node2D) -> void:
	
	if body.name != "Player":
		return

	var gate_message = get_tree().get_first_node_in_group("gate_message")
	if gate_message:
		gate_message.hide()


func open_gate() -> void:
	
	if opened:
		return

	opened = true
	
	sprite.hide()
	collision.set_deferred("disabled", true)
	
	GameManager.gates_opened += 1
	
	update_gate_display()
	
	print("GATE OPENED! Next gate will require: ", GameManager.get_next_gate_cost())
	print("Money left: ", GameManager.money)


func update_gate_display() -> void:
	
	var label = get_node_or_null("Label")
	
	if label:
		var next_cost = GameManager.get_next_gate_cost()
		label.text = "Requires: %d" % next_cost

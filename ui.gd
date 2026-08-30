extends Label

func _process(_delta: float) -> void:
	text = "Keys : %d / %d" % [ GameManager.keys_collected, GameManager.total_keys]

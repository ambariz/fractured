extends Label

func _process(_delta: float) -> void:
	text = "Money Bags : %d / %d" % [ GameManager.money_collected, GameManager.money_total]
	

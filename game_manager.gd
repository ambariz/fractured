extends Node

var keys_collected := 0
var total_keys := 4

func add_key() -> void:
	keys_collected += 1
	print("keys: ", keys_collected, " / ", total_keys)

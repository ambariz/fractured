extends Node

var keys_collected := 0
var total_keys := 4
var money:= 0

func add_key() -> void:
	keys_collected += 1
	print("keys: ", keys_collected, " / ", total_keys)

func add_money() -> void:
	money += 1
	print("Money:",money)

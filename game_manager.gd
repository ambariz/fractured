extends Node

var keys_collected := 0
var total_keys := 2
var money := 0
var money_collected := 0
var money_total := 28
var gates_opened := 0


func add_key() -> void:
	keys_collected += 1
	print("keys: ", keys_collected, " / ", total_keys)


func add_money() -> void:
	money += 1
	print("Money:", money)


func get_next_gate_cost() -> int:
	return gates_opened + 1


func new_game() -> void:
	keys_collected = 0
	money = 0
	money_collected = 0
	gates_opened = 0

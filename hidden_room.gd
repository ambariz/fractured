extends TileMapLayer

var player:Node2D
var hidden_state := false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	if player == null:
		return
		
	var cell := local_to_map(to_local(player.global_position))
	var tile_exists := get_used_cells().has(cell)
	if tile_exists:
		player.hide()
		
		if not hidden_state:
			hidden_state = true
			AudioManager.play_bgm(("hidden"))
	else:
		player.show()
		if hidden_state:
			hidden_state = false
			AudioManager.play_bgm(("normal"))
		

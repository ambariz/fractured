extends Node

var bgm_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var text_player: AudioStreamPlayer

var current_bgm := ""

var bgm_tracks := {
	"normal": preload("res://sounds/bgm_normal.mp3"),
	"hidden": preload("res://sounds/bgm_hidden.mp3"),
	"underground": preload("res://sounds/bgm_underground.mp3")
}

var sfx_tracks := {
	"coin": preload("res://sounds/coin.mp3"),
	"door": preload("res://sounds/door_open.ogg"),
	"jump": preload("res://sounds/jump_landing.mp3"),
	"key": preload("res://sounds/key.mp3"),
	"portal": preload("res://sounds/portal.mp3"),
	"text": preload("res://sounds/text.mp3")
}


func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	bgm_player.name = "BGM"
	bgm_player.bus = "Master"
	bgm_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(bgm_player)

	sfx_player = AudioStreamPlayer.new()
	sfx_player.name = "SFX"
	sfx_player.bus = "Master"
	sfx_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(sfx_player)

	text_player = AudioStreamPlayer.new()
	text_player.name = "Text"
	text_player.bus = "Master"
	text_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(text_player)

	play_bgm("normal")

func play_bgm(track:String) -> void:
	if not bgm_tracks.has(track):
		return
	if current_bgm == track and bgm_player[track]:
		return
	current_bgm = track
	bgm_player.stream = bgm_tracks[track]
	bgm_player.play()
	
func stop_bgm() -> void:
	bgm_player.stop()
	current_bgm = ""
	
func play_sfx(sound:String) -> void:
	if not sfx_tracks.has(sound):
		return

	sfx_player.stream = sfx_tracks[sound]
	sfx_player.play()

func play_text() -> void:
	text_player.stream = sfx_tracks["text"]
	text_player.play()

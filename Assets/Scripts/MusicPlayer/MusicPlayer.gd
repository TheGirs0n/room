extends Node
# Автолоад: фоновая музыка с кроссфейдом. Переживает смену сцен.

@export var fade_time: float = 0.6
@export var volume_db: float = -6.0

const SILENCE_DB := -40.0

var _a: AudioStreamPlayer
var _b: AudioStreamPlayer
var _active: AudioStreamPlayer
var _current: AudioStream = null


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # музыка играет и на паузе
	_a = _make_player()
	_b = _make_player()
	_active = _a


func _make_player() -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.bus = "Master"  # при желании заведи отдельную шину "Music"
	p.volume_db = SILENCE_DB
	add_child(p)
	return p


func play(stream: AudioStream) -> void:
	if stream == _current:
		return  # уже играет этот трек — не перезапускаем (важно между уровнями)
	_current = stream

	var from := _active
	var to := _b if _active == _a else _a

	to.stream = stream
	to.volume_db = SILENCE_DB
	to.play()

	var tw := create_tween()
	tw.tween_property(to, "volume_db", volume_db, fade_time)
	tw.parallel().tween_property(from, "volume_db", SILENCE_DB, fade_time)
	tw.chain().tween_callback(from.stop)

	_active = to


func stop() -> void:
	_current = null
	_a.stop()
	_b.stop()

extends Node

@export_group("Sounds")
@export var pickup: AudioStream      # подобрал сыр
@export var deliver: AudioStream     # донёс сыр в выход
@export var blocked: AudioStream     # упёрся в лапу кота
@export var caught: AudioStream      # попался коту
@export var win: AudioStream         # уровень пройден

@export_group("Settings")
@export var pool_size: int = 6
@export var volume_db: float = 0.0

var _players: Array[AudioStreamPlayer] = []
var _next: int = 0

func _ready() -> void:
 process_mode = Node.PROCESS_MODE_ALWAYS  # звук и на паузе (экран результата)
 for i in pool_size:
  var p := AudioStreamPlayer.new()
  p.bus = "SFX"  
  add_child(p)
  _players.append(p)

 EventBus.mouse_cheese_pickup.connect(func(): play(pickup))
 EventBus.cheese_delivered.connect(func(): play(deliver))
 EventBus.mouse_blocked_by_cat.connect(func(): play(blocked))
 EventBus.mouse_spotted_by_cat.connect(func(): play(caught))
 EventBus.level_completed.connect(func(): play(win))

func play(stream: AudioStream) -> void:
 if stream == null:
  return
 var p := _players[_next]
 _next = (_next + 1) % _players.size()
 p.stream = stream
 p.volume_db = volume_db
 p.play()

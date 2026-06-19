extends Node
class_name MainComponent

@export var mouse_main: MouseMain
@export var cat: Cat
@export var main_ui: MainUI
@export var current_level: LevelBase

## Туториальная сцена: кот не включается сразу, нет рестарта/перехода уровней
@export var is_tutorial: bool = false
## Сцена следующего уровня (переход после победы); пусто = последний уровень
@export var next_level: PackedScene
## Финальный экран (показывается после победы на последнем уровне)

@export var win_scene: PackedScene
enum _Pending { NONE, RETRY, NEXT }

var _level_over: bool = false
var _pending: _Pending = _Pending.NONE


func _ready() -> void:
	if not is_tutorial:
		EventBus.mouse_spotted_by_cat.connect(_on_mouse_caught)
		EventBus.level_completed.connect(_on_level_completed)
		main_ui.result_screen.confirmed.connect(_on_result_confirmed)
	setup_level(current_level)


func setup_level(level: LevelBase) -> void:
	var rooms := level.get_rooms()

	mouse_main.setup_components()
	mouse_main.mouse_move_component.set_start_room(level.base_room)
	
	cat.cat_seek_eye_component.setup(rooms)
	cat.cat_put_paw_component.setup(rooms)
	if not is_tutorial:
		cat.enable_eye()
		cat.enable_paw()

	for room in rooms:
		for cheese in room.cheese_array:
			level.cheese_manager.cheese_register(cheese)

	main_ui.cheese_container_ui.set_cheese_start(
		level.cheese_manager.total_cheese
	)


func _on_mouse_caught() -> void:
	if _level_over:
		return
	_level_over = true
	mouse_main.mouse_get_captured()
	get_tree().paused = true
	_pending = _Pending.RETRY
	main_ui.result_screen.show_result("Поражение", "Заново")


func _on_level_completed():
	get_tree().paused = true
	if next_level:
		get_tree().paused = true
		_pending = _Pending.NEXT
		main_ui.result_screen.show_result("Победа!", "Дальше")
	elif win_scene:
		get_tree().paused = false
		get_tree().change_scene_to_packed(win_scene)
	else:
		get_tree().paused = true
		_pending = _Pending.RETRY
		main_ui.result_screen.show_result("Игра пройдена!", "Заново")


func _on_result_confirmed() -> void:
	get_tree().paused = false
	match _pending:
		_Pending.NEXT:
			get_tree().change_scene_to_packed(next_level)
		_:
			get_tree().reload_current_scene()

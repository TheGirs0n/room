extends Node
class_name MainComponent

@export var mouse_main: MouseMain
@export var cat: Cat
@export var main_ui: MainUI
@export var current_level: LevelBase


func _ready() -> void:
	setup_level(current_level)


func setup_level(level: LevelBase) -> void:
	var rooms := level.get_rooms()

	mouse_main.setup_components()
	mouse_main.mouse_move_component.set_start_room(level.base_room)
	
	cat.cat_seek_eye_component.setup(rooms)
	cat.enable_eye()
	cat.cat_put_paw_component.setup(rooms)
	cat.enable_paw()

	for room in rooms:
		for cheese in room.cheese_array:
			level.cheese_manager.cheese_register(cheese)

	main_ui.cheese_container_ui.set_cheese_start(
		level.cheese_manager.all_cheese_array.size()
	)

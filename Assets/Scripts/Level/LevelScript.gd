extends Node
class_name LevelBase

@export var base_room : Room
@export var mouse_main : MouseMain


func _ready() -> void:
	mouse_main.setup_components()
	setup_level()
	
	
func setup_level():
	mouse_main.mouse_move_component.set_start_room(base_room)

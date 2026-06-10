extends Node
class_name LevelBase

@export var base_room : Room
@export var mouse_main : MouseMain


func _ready() -> void:
	setup_level()
	mouse_main.setup_components()
	
	
func setup_level():
	mouse_main.mouse_move_component.current_room = base_room

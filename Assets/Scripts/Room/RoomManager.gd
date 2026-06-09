extends Node
class_name RoomManager

@export var rooms_in_level : Array[Room]

func _ready() -> void:
	EventBus.mouse_enter_new_room.connect(show_all_in_the_room)
	EventBus.mouse_leave_old_room.connect(hide_all_in_the_room)
	

func show_all_in_the_room(new_room : int):
	rooms_in_level[new_room].show_all_in_the_room()


func hide_all_in_the_room(old_room : int):
	rooms_in_level[old_room].hide_all_in_the_room()

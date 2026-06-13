extends Node
class_name LevelBase

@export var room_manager: RoomManager
@export var cheese_manager: CheeseManager
@export var base_room: Room


func get_rooms() -> Array[Room]:
	return room_manager.rooms_in_level

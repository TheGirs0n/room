extends Node2D
class_name Room

@export_group("Room Settings")
@export var room_id : int
@export var is_escape_room : bool = false
@export var cheese_array : Array[Cheese]
@export var room_linked_array : Array[Room]

@export_group("Room UI")
@export var room_id_label : Label

func _ready() -> void:
	room_id_label.text = str(room_id)

# покажет все в комнате
func show_all_in_the_room():
	show_links_in_the_room()
	show_all_items_in_the_room()

# скроет все в комнате
func hide_all_in_the_room():
	hide_links_in_the_room()
	hide_all_items_in_the_room()
	
	
func show_links_in_the_room():
	pass
	
	
func show_all_items_in_the_room():
	for i in cheese_array:
		i.visible = true


func hide_links_in_the_room():
	pass
	
	
func hide_all_items_in_the_room():
	for i in cheese_array:
		i.visible = false


func get_linked_room_by_id(id : int) -> Room:
	return room_linked_array.get(id)

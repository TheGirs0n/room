extends Node2D
class_name Room

@export_group("Room Settings")
@export var room_id : int
@export var is_escape_room : bool = false

@export var cheese_array : Array[Cheese]
@export var room_linked_array : Array[Room]

@export_group("Room UI")
@export var room_id_label : Label
@export var color_rect_spot : ColorRect

var visible_items_tween : Tween
var hide_items_tween : Tween

var visible_spot_tween : Tween
var hide_spot_tween : Tween

var is_spot_by_cat : bool = false
var is_block_by_cat : bool = false


func _ready() -> void:
	room_id_label.modulate.a = 0.0
	room_id_label.text = str(room_id)
	
# покажет все в комнате
func show_all_in_the_room():
	show_all_items_in_the_room()

# скроет все в комнате
func hide_all_in_the_room():
	hide_all_items_in_the_room()
	

func show_all_items_in_the_room():
	if visible_items_tween:
		visible_items_tween.kill()
	
	visible_items_tween = create_tween()
	visible_items_tween.set_ease(Tween.EASE_IN_OUT)
	visible_items_tween.set_trans(Tween.TRANS_LINEAR)
	
	for cheese in cheese_array:
		visible_items_tween.parallel().tween_property(cheese, "modulate:a", 1.0, 0.2)
	for room in room_linked_array:
		visible_items_tween.parallel().tween_property(room.room_id_label, "modulate:a", 1.0, 0.2)
	
	
func hide_all_items_in_the_room():
	if hide_items_tween:
		hide_items_tween.kill()
	
	hide_items_tween = create_tween()
	hide_items_tween.set_ease(Tween.EASE_IN_OUT)
	hide_items_tween.set_trans(Tween.TRANS_LINEAR)
	
	for cheese in cheese_array:
		hide_items_tween.parallel().tween_property(cheese, "modulate:a", 0.0, 0.2)
	for room in room_linked_array:
		hide_items_tween.parallel().tween_property(room.room_id_label, "modulate:a", 0.0, 0.2)


func spot_by_cat():
	if visible_items_tween:
		visible_items_tween.kill()
	
	visible_spot_tween = create_tween()
	visible_spot_tween.set_ease(Tween.EASE_IN_OUT)
	visible_spot_tween.set_trans(Tween.TRANS_LINEAR)
	visible_spot_tween.tween_property(color_rect_spot, "modulate:a", 0.5, 0.5)
	is_spot_by_cat = true


func cat_stop_spot():
	if hide_spot_tween:
		hide_spot_tween.kill()
		
	hide_spot_tween = create_tween()
	hide_spot_tween.set_ease(Tween.EASE_IN_OUT)
	hide_spot_tween.set_trans(Tween.TRANS_LINEAR)
	hide_spot_tween.tween_property(color_rect_spot, "modulate:a", 0.0, 0.5)
	is_spot_by_cat = false


func get_open_room_by_id(id : int):
	for room in room_linked_array:
		if room.room_id == id and !room.is_block_by_cat:
			return room
	return null


func get_linked_room_by_id(id: int) -> Room:
	for room in room_linked_array:
		if room.room_id == id:
			return room
	return null

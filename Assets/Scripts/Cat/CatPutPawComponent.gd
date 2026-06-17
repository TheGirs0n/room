extends Node
class_name CatPutPawComponent

@export_group("Paw Timer")
@export var paw_timer : Timer
@export var paw_timer_waittime : float
@export var paw_sprite: Sprite2D

@export_group("Rest Timer")
@export var rest_timer : Timer
@export var rest_timer_waittime : float

var current_paw_pair_room : Array[Room]
var rooms_array : Array[Room]

var paw_tween: Tween

func _ready() -> void:
	paw_timer.stop()
	rest_timer.stop()
	
	paw_timer.wait_time = paw_timer_waittime
	rest_timer.wait_time = rest_timer_waittime
	paw_sprite.modulate.a = 0.0
	

func setup(room_array : Array[Room]):
	rooms_array = room_array


func put_paw() -> void:
	paw_timer.start()
	var room = rooms_array.pick_random()
	var linked_room = room.room_linked_array.pick_random()

	current_paw_pair_room = [room, linked_room]
	
	room.is_block_by_cat = true
	linked_room.is_block_by_cat = true
	_show_paw(room, linked_room)
	

func rest_paw() -> void:
	rest_timer.start()
	for room in current_paw_pair_room:
		room.is_block_by_cat = false
	current_paw_pair_room.clear()
	_hide_paw()
	
	
func _show_paw(room_a: Room, room_b: Room) -> void:
	paw_sprite.global_position = (room_a.global_position + room_b.global_position) / 2.0
	paw_sprite.rotation = (room_b.global_position - room_a.global_position).angle()
	
	if paw_tween:
		paw_tween.kill()
	paw_tween = create_tween()
	paw_tween.tween_property(paw_sprite, "modulate:a", 1.0, 0.3)


func _hide_paw() -> void:
	if paw_tween:
		paw_tween.kill()
	paw_sprite.modulate.a = 0.0  


func enable() -> void:
	disable()
	rest_timer.start()


func disable() -> void:
	paw_timer.stop()
	rest_timer.stop()
	for room in current_paw_pair_room:
		room.is_block_by_cat = false
	current_paw_pair_room.clear()
	_hide_paw()

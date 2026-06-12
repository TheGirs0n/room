extends Node
class_name CatPutPawComponent

@export_group("Paw Timer")
@export var paw_timer : Timer
@export var paw_timer_waittime : float

@export_group("Rest Timer")
@export var rest_timer : Timer
@export var rest_timer_waittime : float

var current_paw_pair_room : Array[Room]
var rooms_array : Array[Room]

func _ready() -> void:
	paw_timer.stop()
	rest_timer.start()
	
	paw_timer.wait_time = paw_timer_waittime
	rest_timer.wait_time = rest_timer_waittime


func setup(room_array : Array[Room]):
	rooms_array = room_array


func put_paw():
	paw_timer.start()
	var room = rooms_array.pick_random()
	var random_linked_room = room.room_linked_array.pick_random()
	
	room.is_block_by_cat = true
	random_linked_room.is_block_by_cat = true
	

func rest_paw():
	rest_timer.start()

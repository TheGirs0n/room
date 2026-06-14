extends Node
class_name CatSeekEyeComponent

@export_group("Seek Timer")
@export var seek_timer : Timer
@export var seek_timer_waittime : float

@export_group("Rest Timer")
@export var rest_timer : Timer
@export var rest_timer_waittime : float

var current_seek_room : Room = null
var rooms_array : Array[Room]

func _ready() -> void:
	seek_timer.stop()
	rest_timer.start()
	
	seek_timer.wait_time = seek_timer_waittime
	rest_timer.wait_time = rest_timer_waittime


func setup(room_array : Array[Room]):
	rooms_array = room_array
	
	
func seek_mouse():
	seek_timer.start()
	current_seek_room = rooms_array.pick_random()
	current_seek_room.spot_by_cat()

	
func rest_over():
	seek_mouse()
	
	
func seek_over():
	rest_timer.start()
	current_seek_room.cat_stop_spot()


func enable() -> void:
	seek_timer.start()   # или paw_timer / rest_timer

func disable() -> void:
	seek_timer.stop()

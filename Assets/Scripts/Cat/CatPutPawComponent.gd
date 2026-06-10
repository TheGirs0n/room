extends Node
class_name CatPutPawComponent

@export_group("Seek Timer")
@export var seek_timer : Timer
@export var seek_timer_waittime : float

@export_group("Rest Timer")
@export var rest_timer : Timer
@export var rest_timer_waittime : float

var current_seek_room : Room = null
var rooms_array : Array[Room]

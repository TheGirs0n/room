extends Node
class_name CatSeekEyeComponent

@export_group("Seek Timer")
@export var seek_timer : Timer
@export var seek_timer_waittime : float

@export_group("Rest Timer")
@export var rest_timer : Timer
@export var rest_timer_waittime : float

@export_group("Watch Light")
@export var watch_light : PointLight2D       # опционально: свет кота
@export var light_calm_energy : float = 0.6  # энергия в покое (0 = погашен)
@export var light_pulse_energy : float = 2.0 # пик пульса при слежке
@export var pulse_time : float = 0.5         # полупериод пульса, сек

var current_seek_room : Room = null
var rooms_array : Array[Room]

var _pulse_tween : Tween

func _ready() -> void:
	seek_timer.stop()
	rest_timer.stop()

	seek_timer.wait_time = seek_timer_waittime
	rest_timer.wait_time = rest_timer_waittime

	if watch_light:
		watch_light.energy = light_calm_energy


func setup(room_array : Array[Room]):
	rooms_array = room_array


func seek_mouse():
	if rooms_array.is_empty():
		return
	seek_timer.start()
	current_seek_room = rooms_array.pick_random()
	current_seek_room.spot_by_cat()
	_start_pulse()


func rest_over():
	seek_mouse()


func seek_over():
	rest_timer.start()
	current_seek_room.cat_stop_spot()
	_stop_pulse()


func enable() -> void:
	disable()
	rest_timer.start()


func disable() -> void:
	seek_timer.stop()
	rest_timer.stop()
	if current_seek_room:
		current_seek_room.cat_stop_spot()
		current_seek_room = null
	_stop_pulse()


func _start_pulse() -> void:
	if watch_light == null:
		return
	if _pulse_tween:
		_pulse_tween.kill()
	_pulse_tween = create_tween().set_loops()
	_pulse_tween.tween_property(watch_light, "energy", light_pulse_energy, pulse_time)\
		.set_trans(Tween.TRANS_SINE)
	_pulse_tween.tween_property(watch_light, "energy", light_calm_energy, pulse_time)\
		.set_trans(Tween.TRANS_SINE)


func _stop_pulse() -> void:
	if _pulse_tween:
		_pulse_tween.kill()
	if watch_light:
		watch_light.energy = light_calm_energy

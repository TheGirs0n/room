extends Node
class_name MousePickupComponent

@export var cheese_sprite : Sprite2D

var is_mouse_full : bool = false
var mouse_main : MouseMain

var visible_cheese_tween : Tween


func setup(mouse : MouseMain):
	mouse_main = mouse
	

func _input(event: InputEvent) -> void:
	if event is InputEventAction:
		if event.action == "pickup" and event.is_pressed():
			try_to_pickup_in_the_room()


func try_to_pickup_in_the_room():
	var current_room = mouse_main.mouse_move_component.current_room
	if current_room.cheese_array.size() > 0:
		if !is_mouse_full:
			var cheese_random = current_room.cheese_array.pop_at(-1)
			cheese_random.queue_free()
			mouse_pickup_cheese()


func mouse_pickup_cheese():
	is_mouse_full = true
	
	visible_cheese_tween = create_tween()
	visible_cheese_tween.set_ease(Tween.EASE_OUT_IN)
	visible_cheese_tween.set_trans(Tween.TRANS_LINEAR)
	visible_cheese_tween.tween_property(cheese_sprite, "modulate:a", 1, 0.2)
	EventBus.mouse_cheese_pickup.emit()
	

func mouse_drop_cheese():
	is_mouse_full = false
	
	visible_cheese_tween = create_tween()
	visible_cheese_tween.set_ease(Tween.EASE_OUT_IN)
	visible_cheese_tween.set_trans(Tween.TRANS_LINEAR)
	visible_cheese_tween.tween_property(cheese_sprite, "modulate:a", 0, 0.2)

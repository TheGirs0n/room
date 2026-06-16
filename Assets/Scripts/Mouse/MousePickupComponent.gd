extends Node
class_name MousePickupComponent

@export var cheese_sprite : Sprite2D

var is_mouse_full : bool = false
var mouse_main : MouseMain

var visible_cheese_tween : Tween


func setup(mouse : MouseMain):
	mouse_main = mouse
	

func _input(event: InputEvent) -> void:
	if mouse_main.mouse_move_component.mouse_is_moving:
		return
	if event.is_action_pressed("pickup"):
		try_to_pickup_in_the_room()


func try_to_pickup_in_the_room():
	var current_room = mouse_main.mouse_move_component.current_room
	if current_room.cheese_array.size() > 0 and !is_mouse_full:
		var cheese = current_room.cheese_array.back()
		cheese.queue_free()
		mouse_pickup_cheese()
		
		if current_room.is_escape_room:
			mouse_deliver_cheese()


func mouse_pickup_cheese():
	is_mouse_full = true
	
	if visible_cheese_tween:
		visible_cheese_tween.kill()
	
	visible_cheese_tween = create_tween()
	visible_cheese_tween.set_ease(Tween.EASE_OUT_IN)
	visible_cheese_tween.set_trans(Tween.TRANS_LINEAR)
	visible_cheese_tween.tween_property(cheese_sprite, "modulate:a", 1, 0.2)
	EventBus.mouse_cheese_pickup.emit()
	

func mouse_drop_cheese():
	is_mouse_full = false
	
	if visible_cheese_tween:
		visible_cheese_tween.kill()
	
	visible_cheese_tween = create_tween()
	visible_cheese_tween.set_ease(Tween.EASE_OUT_IN)
	visible_cheese_tween.set_trans(Tween.TRANS_LINEAR)
	visible_cheese_tween.tween_property(cheese_sprite, "modulate:a", 0, 0.2)
	EventBus.mouse_cheese_dropped.emit()


func mouse_deliver_cheese():
	if not is_mouse_full:
		return
	mouse_drop_cheese()
	EventBus.cheese_delivered.emit()

extends Sprite2D
class_name MouseMain

@export var mouse_move_component : MouseMoveComponent
@export var mouse_pickup_component : MousePickupComponent


func setup_components():
	mouse_move_component.setup(self)
	mouse_pickup_component.setup(self)


func mouse_get_captured():
	pass

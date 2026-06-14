extends Sprite2D
class_name Cat

@export var cat_seek_eye_component: CatSeekEyeComponent
@export var cat_put_paw_component: CatPutPawComponent


func enable_eye() -> void:
	cat_seek_eye_component.enable()

func disable_eye() -> void:
	cat_seek_eye_component.disable()

func enable_paw() -> void:
	cat_put_paw_component.enable()

func disable_paw() -> void:
	cat_put_paw_component.disable()

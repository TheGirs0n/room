extends Node
class_name CheeseManager

var total_cheese : int = 0
var delivered_cheese : int = 0


func _ready() -> void:
	EventBus.cheese_delivered.connect(_on_cheese_delivered)


func cheese_register(_cheese: Cheese) -> void:
	total_cheese += 1


func _on_cheese_delivered() -> void:
	delivered_cheese += 1
	EventBus.cheese_count_update.emit(total_cheese - delivered_cheese)
	if delivered_cheese >= total_cheese:
		EventBus.level_completed.emit()

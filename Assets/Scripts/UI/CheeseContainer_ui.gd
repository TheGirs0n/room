extends HBoxContainer
class_name CheeseContainerUI

@onready var cheese_count_label: Label = $Label

func _ready():
	EventBus.cheese_count_update.connect(set_new_cheese_count)


func set_cheese_start(start_amount : int):
	cheese_count_label.text = str(start_amount)
	

func set_new_cheese_count(new_count : int):
	cheese_count_label.text = str(new_count)

extends Control
class_name SettingsMenu

@export_file("*.tscn") var menu_scene: String

@export_group("Master")
@export var master_slider: HSlider
@export var master_label: Label

@export_group("Music")
@export var music_slider: HSlider
@export var music_label: Label
@export_group("SFX")

@export var sfx_slider: HSlider
@export var sfx_label: Label


func _ready() -> void:
	get_tree().paused = false
	_setup(master_slider, master_label, SaveData.master_volume, SaveData.set_master_volume)
	_setup(music_slider, music_label, SaveData.music_volume, SaveData.set_music_volume)
	_setup(sfx_slider, sfx_label, SaveData.sfx_volume, SaveData.set_sfx_volume)


func _setup(slider: HSlider, label: Label, start_value: float, on_changed: Callable) -> void:
	if slider == null:
		return
	slider.min_value = 0.0
	slider.max_value = 1.0
	slider.step = 0.01
	slider.value = start_value          # до connect, чтобы не дёрнуть колбэк
	_update_label(label, start_value)
	slider.value_changed.connect(on_changed)
	slider.value_changed.connect(func(v: float): _update_label(label, v))


func _update_label(label: Label, v: float) -> void:
	if label:
		label.text = "%d%%" % roundi(v * 100.0)


func _on_back() -> void:
	get_tree().change_scene_to_file(menu_scene)

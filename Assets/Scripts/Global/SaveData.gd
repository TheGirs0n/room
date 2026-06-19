extends Node
# Автолоад: хранит прогресс между сессиями (в вебе — в хранилище браузера)

const SAVE_PATH := "user://save.cfg"

var tutorial_done: bool = false


func _ready() -> void:
	_load()


func mark_tutorial_done() -> void:
	tutorial_done = true
	_save()


func _save() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("progress", "tutorial_done", tutorial_done)
	cfg.save(SAVE_PATH)


func _load() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		tutorial_done = cfg.get_value("progress", "tutorial_done", false)

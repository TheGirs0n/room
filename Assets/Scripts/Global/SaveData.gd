extends Node

const SAVE_PATH := "user://save.cfg"

var tutorial_done: bool = false
var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var locale: String = "ru"


func _ready() -> void:
	_load()
	_apply_volume("Master", master_volume)
	_apply_volume("Music", music_volume)
	_apply_volume("SFX", sfx_volume)
	TranslationServer.set_locale(locale)


func mark_tutorial_done() -> void:
	tutorial_done = true
	_save()


func set_locale(new_locale: String) -> void:
	locale = new_locale
	TranslationServer.set_locale(new_locale)
	_save()


func set_master_volume(v: float) -> void:
	master_volume = v
	_apply_volume("Master", v)
	_save()


func set_music_volume(v: float) -> void:
	music_volume = v
	_apply_volume("Music", v)
	_save()


func set_sfx_volume(v: float) -> void:
	sfx_volume = v
	_apply_volume("SFX", v)
	_save()


func _apply_volume(bus_name: String, v: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(v))


func _save() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("progress", "tutorial_done", tutorial_done)
	cfg.set_value("audio", "master_volume", master_volume)
	cfg.set_value("audio", "music_volume", music_volume)
	cfg.set_value("audio", "sfx_volume", sfx_volume)
	cfg.set_value("locale", "locale", locale)
	cfg.save(SAVE_PATH)


func _load() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		tutorial_done = cfg.get_value("progress", "tutorial_done", false)
		master_volume = cfg.get_value("audio", "master_volume", 1.0)
		music_volume = cfg.get_value("audio", "music_volume", 1.0)
		sfx_volume = cfg.get_value("audio", "sfx_volume", 1.0)
		locale = cfg.get_value("locale", "locale", "ru")

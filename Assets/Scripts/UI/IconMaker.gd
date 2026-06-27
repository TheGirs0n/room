extends Node

func _ready():
	await RenderingServer.frame_post_draw
	await RenderingServer.frame_post_draw
	var img = $SubViewport.get_texture().get_image()
	img.save_png("res://icon_512.png")
	get_tree().quit()

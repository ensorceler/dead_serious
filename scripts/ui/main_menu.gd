extends Control
@onready var play: Button = $ColorRect/CenterContainer/VBoxContainer/Play


func _ready()-> void:
	play.button_pressed=true
	play.toggled.emit()
	


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	#pass # Replace with function body.

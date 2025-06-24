extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

func _ready():
	main_buttons.visible = true
	options.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_options_2_pressed() -> void:
	main_buttons.visible = false
	options.visible = true


func _on_exit_3_pressed() -> void:
	get_tree().quit()


func _on_back_options_pressed() -> void:
	_ready()

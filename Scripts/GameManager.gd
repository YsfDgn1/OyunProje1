extends Node

signal gained_gems(int)
signal gained_cherry(int)

var player_lives := 3
var gems : int = 0
var cherry : int = 0
var invincibility := false
var opened_doors: Array = []

func reset():
	opened_doors.clear()


func reset_game_data():
	player_lives = 3
	gems = 0
	cherry = 0
	opened_doors.clear()

func gain_gems(gems_gained: int):
	gems += gems_gained
	emit_signal("gained_gems", gems_gained)
	print("Gems: ", gems)

func gain_cherry(cherry_gained: int):
	cherry += cherry_gained
	emit_signal("gained_cherry", cherry_gained)
	print("Cherry: ", cherry)

var FeedbackEffectScene = preload("res://Scenes/item_feedback.tscn")

func show_item_feedback(anim_name: String, pos: Vector2) -> void:
	var feedback = FeedbackEffectScene.instantiate()
	feedback.position = pos
	feedback.play_animation(anim_name)
	get_tree().current_scene.add_child(feedback)

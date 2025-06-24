extends Control

func update_hearts(lives: int) -> void:
	for i in range(3):
		var heart = $HBoxContainer.get_child(i)
		heart.texture = preload("res://Assets/Props Items and VFX/Sunnyland items/heart_empty.png")
	
	for i in range(lives):
		var heart = $HBoxContainer.get_child(i)
		heart.texture = preload("res://Assets/Props Items and VFX/Sunnyland items/heart_full.png")

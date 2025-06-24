extends Area2D

@onready var animation_player: AnimationPlayer = $Pickup/AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	GameManager.gain_gems(1)
	GameManager.show_item_feedback("feedback", global_position)
	animation_player.play("pickup")

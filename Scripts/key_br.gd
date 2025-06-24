extends Area2D
@export var door_id: String = "B"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
			GameManager.opened_doors.append(door_id)
			queue_free()

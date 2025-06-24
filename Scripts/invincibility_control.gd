extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	GameManager.invincibility = toggled_on

	if toggled_on:
		GameManager.player_lives = 999
		print("Invicibility is open ! Can: ", GameManager.player_lives)
	else:
		GameManager.player_lives = 3
		print("Yenilmezlik kapalı. Can: ", GameManager.player_lives)

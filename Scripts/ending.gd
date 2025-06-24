extends Control

@onready var label = $VBoxContainer/Label
@onready var label2 = $VBoxContainer/Label2
@onready var rank_label = $VBoxContainer/RankLabel
@onready var button = $Button

func _ready():
	var gems = GameManager.gems
	var cherry = GameManager.cherry
	var lives = GameManager.player_lives

	var rank = calculate_rank(gems, cherry)
	rank_label.text = "RANK: %s" % rank
	rank_label.label_settings = get_rank_style(rank)

	label.text = "Congrats, you finished the game!"
	label2.text = "Collected Gems: %d / 40\nCollected Cherry: %d / 8\nRemaining Lives: %d\nYour Rank: %s" % [
		gems,
		cherry,
		lives,
		rank
	]

	button.text = "Back To Main Menu"
	button.pressed.connect(_on_button_pressed)

func calculate_rank(gems: int, cherry: int) -> String:
	var gem_percentage = float(gems) / 40.0
	var cherry_percentage = float(cherry) / 8.0

	if gem_percentage >= 1.0 and cherry_percentage >= 1.0:
		return "S"
	elif gem_percentage >= 0.8 and cherry_percentage >= 0.75:
		return "A"
	elif gem_percentage >= 0.5 and cherry_percentage >= 0.5:
		return "B"
	else:
		return "C"

func get_rank_style(rank: String) -> LabelSettings:
	var style = LabelSettings.new()
	style.font_size = 64

	var font = load("res://Assets/Grades.ttf")
	style.font = font
 

	match rank:
		"S":
			style.font_color = Color8(255, 215, 0) 
		"A":
			style.font_color = Color.GREEN
		"B":
			style.font_color = Color.ORANGE
		"C":
			style.font_color = Color.RED

	return style

func _on_button_pressed():
	GameManager.reset_game_data()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

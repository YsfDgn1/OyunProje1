extends CanvasLayer

func _ready():
	GameManager.gained_gems.connect(update_gems_display)
	GameManager.gained_cherry.connect(update_cherry_display)
	
	update_gems_display(0)
	update_cherry_display(0)

func update_gems_display(gained_gems: int) -> void:
	$GemsDisplay.text = str(GameManager.gems)
	

func update_cherry_display(gained_cherry: int) -> void:
	$CherryDisplay.text = str(GameManager.cherry)

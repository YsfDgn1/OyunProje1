extends StaticBody2D

@export var door_id: String = "C"
@export var is_open: bool = false

func _ready():
	_check_if_should_open()

func _process(delta):
	if not is_open and GameManager.opened_doors.has(door_id):
		open()

func _check_if_should_open():
	if GameManager.opened_doors.has(door_id):
		open()

func open():
	if not is_open:
		is_open = true
		$AnimatedSprite2D.play("open")
		$CollisionShape2D.set_deferred("disabled", true)

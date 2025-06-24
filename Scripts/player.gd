extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -275.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var is_dying = false


@onready var ladder_raycast = $RayCast2D
@onready var death_timer: Timer = $Death_Timer
@onready var hud = get_node("Camera2D/UI/HUD")


func _ready():
	death_timer.connect("timeout", Callable(self, "_on_DeathTimer_timeout"))

func _physics_process(delta: float) -> void:
	if is_dying:
		return

	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			$AnimatedSprite2D.play("idle")
		move_and_slide()
		return

	var direction := Input.get_axis("ui_left", "ui_right")
	var on_ladder: bool = ladder_raycast and ladder_raycast.is_colliding()

	if on_ladder:
		var vertical := 0.0
		if Input.is_action_pressed("ui_up"):
			vertical = -SPEED
		elif Input.is_action_pressed("ui_down"):
			vertical = SPEED

		velocity = Vector2(direction * SPEED, vertical)

		if direction != 0:
			$AnimatedSprite2D.flip_h = direction < 0

		if vertical != 0 or direction != 0:
			$AnimatedSprite2D.play("climb")
		else:
			$AnimatedSprite2D.play("climb_idle")

		move_and_slide()
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("fall")
	else:
		if direction:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")

	move_and_slide()

func apply_knockback(direction: Vector2, force: float, knockback_duration: float, play_animation := true) -> void:
	if is_dying or GameManager.invincibility:
		return

	GameManager.player_lives -= 1
	get_node("Camera2D/UI/HUD").update_hearts(GameManager.player_lives)

	if GameManager.player_lives <= 0:
		die()
		return

	if hud:
		hud.update_hearts(GameManager.player_lives)

	$Hurt.play()

	knockback = direction * force
	knockback_timer = knockback_duration

	if play_animation:
		$AnimatedSprite2D.play("hurt")

func die():
	if is_dying:
		return

	$Hurt.play()

	is_dying = true
	$AnimatedSprite2D.play("die")

	await move_player_up_and_down()

	if GameManager.player_lives <= 0:
		GameManager.reset_game_data()

	get_tree().reload_current_scene()


func move_player_up_and_down():
	var start_position = position
	var up_position = start_position + Vector2(0, -100)
	var down_position = start_position + Vector2(0, 100)

	while position.y > up_position.y:
		position.y -= 4
		await get_tree().create_timer(0.01).timeout

	while position.y < down_position.y:
		position.y += 4
		await get_tree().create_timer(0.01).timeout

func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()

extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -400.0

var direction := 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead := false

func _physics_process(delta):
	if is_dead:
		return

	if is_on_floor():
		velocity.x = 0
		$AnimatedSprite2D.play("idle")
	else:
		velocity.x = direction * SPEED
		velocity.y += gravity * delta

		if velocity.y > 0:
			$AnimatedSprite2D.play("jump")

	move_and_slide()

	$AnimatedSprite2D.flip_h = direction > 0


func jump():
	velocity.y = JUMP_VELOCITY

func die():
	if is_dead:
		return
	is_dead = true

	$AnimatedSprite2D.play("death")

	if not $AnimatedSprite2D.animation_finished.is_connected(_on_death_animation_finished):
		$AnimatedSprite2D.animation_finished.connect(_on_death_animation_finished)

	set_physics_process(false)
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D.monitoring = false
	$Area2D2.monitoring = false

func _on_death_animation_finished():
	queue_free()

func _on_timer_timeout():
	if is_dead:
		return
	direction *= -1
	jump()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if body.is_in_group("Player"):
		var vertical_diff = body.global_position.y - global_position.y

		if vertical_diff < -10:
			if "velocity" in body:
				body.velocity.y = -250
			die()
		else:
			if body.has_method("apply_knockback"):
				var knockback_direction = (body.global_position - global_position).normalized()
				body.apply_knockback(knockback_direction, 150.0, 0.16, true)

			print("Oyuncu canı: ", GameManager.player_lives)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if body.is_in_group("Player"):
		if "velocity" in body:
			body.velocity.y = -250
		die()

extends Node2D

func play_animation(anim_name: String):
	var anim = $AnimatedSprite2D
	anim.play(anim_name)
	anim.animation_finished.connect(queue_free)  

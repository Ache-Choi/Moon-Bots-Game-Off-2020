extends Spatial

onready var aPlayer = $AnimationPlayer
onready var timer = $Timer

func _ready():
	timer.wait_time = .3
	timer.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'hammer':
		self.queue_free()

func _on_Timer_timeout():
	aPlayer.play("hammer")
	$CPUParticles.emitting = true

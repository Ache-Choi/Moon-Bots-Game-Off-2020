extends CPUParticles

func _ready():
	self.emitting = true
	$Timer.wait_time = 1.5
	$Timer.start()

func _on_Timer_timeout():
	self.queue_free()

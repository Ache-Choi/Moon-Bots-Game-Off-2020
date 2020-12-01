extends CPUParticles

func _ready():
	self.emitting = true
	yield(get_tree().create_timer(1), "timeout")
	self.queue_free()

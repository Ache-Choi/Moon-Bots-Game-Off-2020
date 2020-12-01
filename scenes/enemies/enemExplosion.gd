extends CPUParticles

func _ready():
	self.emitting = true
	$Timer.wait_time = 3
	$Timer.start()

func set_color(sceneColor):
	self.color_ramp = load(sceneColor)
	

func _on_Timer_timeout():
	self.queue_free()

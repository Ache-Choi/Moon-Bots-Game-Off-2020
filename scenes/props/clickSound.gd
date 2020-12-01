extends AudioStreamPlayer


func _ready():
	self.playing = true
	

func _on_hpSound_finished():
	self.queue_free()

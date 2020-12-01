extends AudioStreamPlayer

func _ready():
	self.playing = true

func _on_clickSound_finished():
	self.queue_free()

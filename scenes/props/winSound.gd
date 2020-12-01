extends AudioStreamPlayer

func _ready():
	self.playing = true


func _on_winSound_finished():
	self.queue_free()

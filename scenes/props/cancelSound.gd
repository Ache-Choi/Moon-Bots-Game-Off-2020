extends AudioStreamPlayer


func _ready():
	self.playing = true


func _on_cancelSound_finished():
	self.queue_free()

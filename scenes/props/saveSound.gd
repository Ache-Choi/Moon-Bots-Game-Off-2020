extends AudioStreamPlayer


func _ready():
	self.playing = true


func _on_saveSound_finished():
	self.queue_free()

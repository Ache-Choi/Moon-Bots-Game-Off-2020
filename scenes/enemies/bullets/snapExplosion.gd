extends AudioStreamPlayer


func _ready():
	self.playing = true

func _on_snapExplosion_finished():
	self.queue_free()
	

extends AudioStreamPlayer

func _ready():
	self.playing = true

func _on_coin_finished():
	self.queue_free()



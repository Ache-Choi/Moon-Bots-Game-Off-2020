extends AudioStreamPlayer


func _ready():
	if gVars.musicOnOff:
		self.playing = true
		$AnimationPlayer.play("fadeIn")

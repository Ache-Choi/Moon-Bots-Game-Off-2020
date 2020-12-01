extends AudioStreamPlayer



func _ready():
	if gVars.musicOnOff:
		$AnimationPlayer.play("fadeIn")
		self.playing = true

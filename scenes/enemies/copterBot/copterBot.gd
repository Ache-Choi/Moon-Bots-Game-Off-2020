extends Spatial

onready var heliPlayer = $copterAnim

func _ready():
	heliPlayer.play("copter")
	$AudioStreamPlayer3D.playing = true


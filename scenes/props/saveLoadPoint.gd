extends Spatial

export (String) var savingPointArea

func _ready():
	print($playerSetPos.global_transform.origin)
	$CPUParticles.emitting = true
	$AnimationPlayer.play("rotate")
	$Timer.wait_time = 4

func _on_Area_body_entered(body):
	saveLoad.save_data()
	if body.name == 'playerMesh':
		inst_save_sound()
		$AnimationPlayer2.play("saved")
		$AnimationPlayer3.play("popUp")
		$Timer.start()
		gVars.saveLoadPos = $playerSetPos.global_transform.origin

func _on_Timer_timeout():
	$AnimationPlayer3.play_backwards("popUp")


func inst_save_sound():
	if gVars.soundOnOff:
		var s = preload('res://scenes/props/saveSound.tscn').instance()
		add_child(s)

extends Spatial

var contactPosExplosion

var ggg

func _ready():
	pass # Replace with function body.

func bullet_dist(from, to, time, rotDegY):
	self.rotation_degrees.y = rotDegY
	$Tween.interpolate_property(self, 'translation', from, to, time, Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	self.queue_free()
	ggg = [object, key]

func _on_bulletArea_area_entered(area):
	if area.is_in_group('noBullet') or area.name == 'quadLegsArea' or area.name == 'playerArea':
		return
	else:
		gSoundFunc.inst_sounds('player', 'hitObstacle', false, 0)
		gSignals.bullet_explostion(self.transform.origin)
		self.queue_free()
	print(area.name, '     _on_bulletArea_area_entered(area):')

func _on_bulletArea_body_entered(body):
	if body.is_in_group('coin') or body.name == 'playerMesh' or body.is_in_group('noBullet'):
		return
	elif body.is_in_group('finalBoss'):
		gSoundFunc.inst_sounds('player', 'hitObstacle', false, 0)
		body.get_node('../..').got_hit()
		gSignals.bullet_explostion(self.transform.origin)
		self.queue_free()
	else:
		gSoundFunc.inst_sounds('player', 'hitObstacle', false, 0)
		gSignals.bullet_explostion(self.transform.origin)
		self.queue_free()
	print(body.name, '     _on_bulletArea_body_entered(body)', body.get_parent().name)


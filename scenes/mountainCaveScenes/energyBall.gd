extends Spatial

var asdf

func _ready():
	$AnimationPlayer.play("wobble")
	print(self.translation, '   ', self.global_transform.origin)

func _on_Area_body_entered(body):
	if body.name == 'playerMesh':
		gVars.playerItemArrAcquired[2] = 1
		tween_fx(self.translation, self.translation+ Vector3(0,60,0))
		var s = preload('res://scenes/props/winSound.tscn').instance()
		add_child(s)

func tween_fx(from, to):
	$Tween.interpolate_property(self,'translation',from, to, 2,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	self.queue_free()
	asdf = [object, key]




extends Spatial

var gbbg

func _ready():
	$AnimationPlayer.play("spin")

func _on_Area_body_entered(body):
	if body.name == 'playerMesh':
		gVars.playerItemArrAcquired[1] = 1
		tween_fx(self.global_transform.origin, self.global_transform.origin + Vector3(0,60,0))
		var s = preload('res://scenes/props/winSound.tscn').instance()
		add_child(s)

func tween_fx(from, to):
	$Tween.interpolate_property(self,'translation',from, to, 2,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	self.queue_free()
	gbbg = [object, key]

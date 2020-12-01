extends Spatial


func _ready():
	$AnimationPlayer.play("hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'hit':
		self.queue_free()

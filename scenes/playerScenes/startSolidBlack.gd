extends MeshInstance


func _ready():
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer2.play("startPage")

func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == 'startPage':
		get_parent().get_node("playerMesh/playerUI").transition_scene('Center City')

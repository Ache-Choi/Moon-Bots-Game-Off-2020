extends Spatial

onready var aniPlayer = $rocketArmsArmature/AnimationPlayer
onready var upTween = $upTween
onready var rocketArmMesh = $rocketArmsArmature
onready var timer = $Timer
onready var areaTimer = $areaEnterTimer
var ddbb

func _ready():
#	ddbb = gSignals.connect('goMoon', self, 'launch_moon')
	aniPlayer.play("idle")
	$rocketArmsArmature/BoneAttachment/CPUParticles.emitting = true
	$rocketArmsArmature/BoneAttachment2/CPUParticles.emitting = true
	$rocketArmsArmature/BoneAttachment3/CPUParticles3.emitting = true
	timer.wait_time = 1
	areaTimer.wait_time = 3

func _on_Area_body_entered(body):
	if body.name == 'playerMesh':
		body.visible = false
		body.stop_movement('noText', 5)
		var launchSound = preload('res://scenes/props/shipLAunch.tscn').instance()
		add_child(launchSound)
		gSignals.on_rocket_fx(body.global_transform.origin)
		timer.start()# launchmoon
		areaTimer.start()
		

func _on_areaEnterTimer_timeout():
	if gVars.playerCurrentScene != 'moonScene':
		gSignals.moon_transition('The Moon')
		yield(get_tree().create_timer(1),"timeout")
		gSignals.go_to_scene('moonScene')
	else:
		gSignals.moon_transition('South Desert')## go ing back to south desert transition scene 
		yield(get_tree().create_timer(1),"timeout")
		gSignals.go_to_scene('desertScene')
		gSignals.reset_player_translation(Vector3(134.062 , 6.776, 322.403))

func up_tween(from, to):
	upTween.interpolate_property(self, 'translation', from, to, 3,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	upTween.start()

func _on_upTween_tween_completed(object, key):
	self.queue_free()
	ddbb = [object, key]

func launch_moon():
	aniPlayer.play("liftOff")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'liftOff':
		up_tween(rocketArmMesh.global_transform.origin, rocketArmMesh.global_transform.origin + Vector3(0,80,0))

func _on_Timer_timeout():
	launch_moon()


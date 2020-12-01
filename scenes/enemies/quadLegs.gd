extends Spatial

export (String) var whichScene

onready var coverAnimPlayer = $quadCover/quadCover/AnimationPlayer
onready var animPlayer = $quadLegsAtmature/AnimationPlayer
onready var playerPos
onready var playerEnemDist 
onready var direct
onready var quadSpeed = 4
onready var hpBar = $hpBar/Viewport/TextureProgress
onready var shootTimer = $shootCooldown
var canshoot = true
var followPlayer = false
onready var shootPlayerRayC = $rayCastCont/playerSearch
onready var frontRay = $rayCastCont/frontRay
onready var rightRay = $rayCastCont/rightRay
onready var leftRay = $rayCastCont/leftRay
onready var fromBulletPos = $fromBulletPos
onready var tween = $Tween
onready var gotHitPlayer = $gotHitPlayer
onready var bulletHitArea = $hitArea
onready var quadMesh = $quadLegsAtmature/fallingSky

onready var nexSpawnPosArr =[Vector3(-58,0,371),Vector3(4,0,463),Vector3(140,0,467),Vector3(245,0,419),Vector3(283,0,336)]

var ggbb
func _ready():
	self.set_physics_process(true)
	randomize()
	self.rotation_degrees.y = rand_range(0,360)
	$quadLegsAtmature.visible = false
	$CollisionShape.disabled = true
	coverAnimPlayer.play("incoming")
	shootTimer.wait_time = 1.2
	set_material()
	$Timer.wait_time = .5
	$Timer.start()

func set_material():
	quadMesh.set_surface_material(0, null)
	var newMat = load('res://scenes/enemies/quadLegs.tres').duplicate()
	newMat.flags_transparent = false
	newMat.params_grow_amount = 0
	quadMesh.material_override = newMat

func _physics_process(delta):
	if gVars.player != 'alive':
		self.set_physics_process(false)
		animPlayer.stop()
	# PLAYER POSITION TO FOLLOW
	playerPos = gVars.playerGlobalPos - self.global_transform.origin
	direct = playerPos.normalized()
	
	if followPlayer:
		if frontRay.is_colliding():
			if frontRay.get_collider().is_in_group('obstacle') or frontRay.get_collider().is_in_group('enemyBot'):
				followPlayer  = false
#				print('colide front ')
				if direct.x < 0:
					frontRay.enabled = false
					tween_rot('right')
				else:
					frontRay.enabled = false
					tween_rot('left')
		if rightRay.is_colliding() or leftRay.is_colliding():
#			print('colide side ')
			self.translation -= transform.basis.z * delta * quadSpeed
		
		if !frontRay.is_colliding() and !rightRay.is_colliding() and !leftRay.is_colliding():
#			print('colide no collision ')
			followPlayer = true
			if !shootPlayerRayC.is_colliding():
				animPlayer.play_backwards("walk")
				self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * quadSpeed
				self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)
			else:
				if shootPlayerRayC.get_collider().name == 'playerMesh':
					animPlayer.stop()
					if canshoot:
						shoot()
				else:
					animPlayer.play_backwards("walk")
					self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * quadSpeed
					self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)

func tween_rot(rl):
	if rl == 'left':
		tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y + 90,self.rotation_degrees.z), .5, Tween.TRANS_LINEAR,0,0)
	else:
		tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y - 90,self.rotation_degrees.z), .5, Tween.TRANS_LINEAR,0,0)
	frontRay.enabled = true
	tween.start()

func _on_Tween_tween_completed(object, key):
	followPlayer = true
	ggbb = [object, key]

func shoot():
	gSignals.enemy_bullet('quadLegsBullet',fromBulletPos.global_transform.origin, self.rotation_degrees.y + 180)
	canshoot = false
	shootTimer.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'incoming':
		animPlayer.play("openUp")
		$CollisionShape.disabled = false
		$quadLegsAtmature.visible = true
		$quadParticles.emitting = true
	if anim_name == 'openUp':
		animPlayer.play_backwards("walk")
		followPlayer = true

func _on_hitArea_area_entered(area):
	if area.name == 'playerBulletArea':
		self.gotHitPlayer.play("gotHit")
		hp_bar_tween(hpBar,$hpBarTween)

func hp_bar_tween(node,tweenNode):
	var amountTo = node.value - gVars.bulletDamage
	if amountTo < 0:
		amountTo = 0
	tweenNode.interpolate_property(hpBar, 'value', hpBar.value, amountTo, .1, Tween.TRANS_QUAD,0)
	tweenNode.start()
	node.value -= gVars.bulletDamage
	var twoThirds = ((node.max_value/3)*2)
	var third = node.max_value/3
	if node.value > twoThirds:
		node.tint_progress = '00ff30'
	elif node.value > third and node.value <= twoThirds:
		node.tint_progress = 'fff300'
	else:
		node.tint_progress = 'ff0000'

func _on_hpBarTween_tween_completed(object, key):
	if hpBar.value <= 0:
		self.gotHitPlayer.play("dead")
		gSignals.spawn_coins(7,self.global_transform.origin + Vector3(0,2,0))
		yield(get_tree().create_timer(.15),"timeout")
		gSignals.enemy_explosion('res://assets/particlesColor/enemExplosionPurple.tres', self.global_transform.origin, 'quadLegs')
		gVars.playerExp += 8
		bulletHitArea.disconnect("area_entered",self, '_on_hitArea_area_entered')
		if whichScene == 'desertScene':
			next_spawn()
	ggbb = [object, key]

func _on_shootCooldown_timeout():
	canshoot = true

func next_spawn():
	randomize()
	if self.whichScene == 'desertScene':
		var randN = floor(rand_range(0,nexSpawnPosArr.size()))
		for i in randN:
			gSignals.spawn_enemies('quadLegsBot', nexSpawnPosArr[i], null, null)


func _on_gotHitPlayer_animation_finished(anim_name):
	if anim_name == 'dead':
		self.queue_free()


func _on_Timer_timeout():
	if gVars.soundOnOff:
		$quadCover/quadCover/AudioStreamPlayer3D.playing = true


func _on_AudioStreamPlayer3D_finished():
	if gVars.soundOnOff:
		$quadCover/quadCover/AudioStreamPlayer3D.playing = false
		$quadCover/quadCover/AudioStreamPlayer3D.stream_paused = true

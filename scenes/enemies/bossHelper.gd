extends Spatial

export (String) var whichScene
export (Array, Color) var colorPall

onready var playerHammerAnim = $bossHelperArmature/playerHammerAnim
onready var damageEffectPlayer = $bossHelperArmature/AnimationPlayer2

onready var shootPlayerRayC = $rayCastContainer/hammerCast
onready var frontRay = $rayCastContainer/forwardCast
onready var rightRay = $rayCastContainer/rightCast
onready var leftRay = $rayCastContainer/leftCast

onready var bossMesh = $bossHelperArmature/bossHelper002
onready var hammerTime = true
onready var playerPos
onready var playerEnemDist 
onready var direct# direction
onready var enemySpeed = 5

var followPlayer = true
onready var playerFollowRayCast = $rayCastContainer/forwardCast

onready var hpBar = $hpBar/Viewport/TextureProgress
onready var tween = $Tween
onready var hpBarTween = $hpBarTween

onready var hammerHitPos = $hammerHitPos
onready var hammerCol = $bossHelperArmature/BoneAttachment/hammer002/MeshInstance/hammerArea/CollisionShape

onready var meshMat = $bossHelperArmature/bossHelper002.get('mesh').get('surface_2/material')
onready var bossHelperMesh = $bossHelperArmature/bossHelper002
onready var currentColor = Color() 
onready var nextSpawnPosArrForrestOne = [Vector3(-354,0,-435),Vector3(-124,0,-591),Vector3(80,0,-593),Vector3(-255,0,123),Vector3(-354,0,-325)]
onready var nextSpawnPosArrForrestTwo = [Vector3(-357,0,53),Vector3(-236,0,334),Vector3(-329,0,-116),Vector3(-212,0,-116),Vector3(-212,0,-116),Vector3(-187,0,332)]

var buggggy

func _ready():
	self.set_physics_process(true)
	randomize()
	var randColor = floor(rand_range(0,colorPall.size()))
	currentColor = colorPall[randColor]
	playerHammerAnim.playback_speed = 1.2
	playerHammerAnim.play("walk")
	if gVars.soundOnOff:
		$stomp.playing = true
	hammerCol.disabled = true
	set_material()
	color_change(currentColor)
	print(gVars.playerGlobalPos)

func set_material():
	bossHelperMesh.set_surface_material(0, null)
	var newMat = load('res://scenes/enemies/bossHelper.tres').duplicate()
	newMat.flags_transparent = false
	newMat.params_grow_amount = 0
	bossHelperMesh.material_override = newMat

func _physics_process(delta):
	if gVars.player != 'alive':
		self.set_physics_process(false)
		playerHammerAnim.play("stand")
		if gVars.soundOnOff:
			$stomp.playing = false
		
		
	playerPos = gVars.playerGlobalPos - self.global_transform.origin
	playerEnemDist = playerPos.length()
	direct = playerPos.normalized()
#	print(self.global_transform.origin, '   -- -self- - - ' , self.rotation_degrees)
#	print($bossHelperArea.global_transform.origin, '   -- -bossHelperArea- - - ' , $bossHelperArea.rotation_degrees)
	
	if followPlayer:
		if frontRay.is_colliding():
			if frontRay.get_collider().is_in_group('obstacle') or frontRay.get_collider().is_in_group('enemyBot'):
				followPlayer  = false
				if direct.x < 0:
					frontRay.enabled = false
					tween_rot('right')
				else:
					frontRay.enabled = false
					tween_rot('left')
	
		if !frontRay.is_colliding() and !rightRay.is_colliding() and !leftRay.is_colliding():
			followPlayer = true
			if gVars.soundOnOff:
				$stomp.playing = true
			
		if !frontRay.is_colliding():
			playerHammerAnim.playback_speed = 1.2
			playerHammerAnim.play("walk")
			if gVars.soundOnOff:
				$stomp.playing = true
			self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
			self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)

		if shootPlayerRayC.is_colliding():
			if shootPlayerRayC.get_collider().name == 'playerMesh':
				if hammerTime:
					followPlayer = false
					if gVars.soundOnOff:
						$stomp.playing = false
					var randNum = floor(rand_range(0,2))
					if randNum == 0 and hammerTime:
						hammerTime = false
						hammerCol.disabled = false
						playerHammerAnim.playback_speed = 1
						playerHammerAnim.play("hammer")
						gSignals.hammer_effect(hammerHitPos.global_transform.origin, 'hammer')
						yield(get_tree().create_timer(.2), "timeout")
						gSignals.hammer_side_explosion(hammerHitPos.global_transform.origin)
					elif randNum == 1 and hammerTime:
						hammerTime = false
						hammerCol.disabled = false
						playerHammerAnim.playback_speed = 1
						playerHammerAnim.play('hammerSide')
						
						
	if rightRay.is_colliding() or leftRay.is_colliding():
		self.translation -= transform.basis.z * delta * enemySpeed
	if rightRay.is_colliding() and frontRay.is_colliding():
		self.translation -= transform.basis.z * delta * enemySpeed
	if leftRay.is_colliding() and frontRay.is_colliding():
		self.translation -= transform.basis.z * delta * enemySpeed
	if leftRay.is_colliding() and frontRay.is_colliding() and rightRay.is_colliding():
		self.translation -= transform.basis.z * delta * enemySpeed
		
#			if !shootPlayerRayC.is_colliding():
#				playerHammerAnim.play("walk")
#				self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
#				self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)
#			else:
#				if shootPlayerRayC.get_collider().name == 'playerMesh' :
#					if hammerTime:
#						followPlayer = false
#						var randNum = floor(rand_range(0,2))
#						if randNum == 0 and hammerTime:
#							hammerTime = false
#							hammerCol.disabled = false
#							playerHammerAnim.play("hammer")
#							gSignals.hammer_effect(hammerHitPos.global_transform.origin, 'hammer')
#							gSignals.hammer_side_explosion(hammerHitPos.global_transform.origin)
#						elif randNum == 1 and hammerTime:
#							hammerTime = false
#							hammerCol.disabled = false
#							playerHammerAnim.play('hammerSide')


func _on_Timer_timeout():
	pass

func color_change(color):
	bossHelperMesh.get('material_override').albedo_color = color
	
func tween_rot(rl):
	if rl == 'left':
		$Tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y + 90,self.rotation_degrees.z), 1, Tween.TRANS_LINEAR,0,0)
	else:
		$Tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y - 90,self.rotation_degrees.z), 1, Tween.TRANS_LINEAR,0,0)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	frontRay.enabled = true
	followPlayer = true
	buggggy = [object, key]

func _on_playerHammerAnim_animation_finished(anim_name):
	if anim_name == 'hammer':
		playerHammerAnim.play("stand")
		gSoundFunc.inst_sounds('bossHelper','hammerHit',false,0)
		if gVars.soundOnOff:
			$hammer.playing = true
		hammerCol.disabled = true
		followPlayer = false
		yield(get_tree().create_timer(1), 'timeout')
		playerHammerAnim.play("walk")
		hammerTime = true
		followPlayer = true
	if anim_name == 'hammerSide':
		playerHammerAnim.play("stand")
		hammerCol.disabled = true
		followPlayer = false
		if gVars.soundOnOff:
			$hammer2.playing = true
		yield(get_tree().create_timer(1), 'timeout')
		playerHammerAnim.play("walk")
		if gVars.soundOnOff:
			$stomp.playing = true
		followPlayer = true
		hammerTime = true

func _on_bossHelperArea_area_entered(area):
	if area.name == 'playerBulletArea':
		damageEffectPlayer.play("gotHit")
		hp_bar_tween(hpBar, hpBarTween)
		print(' _on_bossHelperArea_area_entered(area):')

func hp_bar_tween(barNode,tweenNode):
	var amountTo = hpBar.value - gVars.bulletDamage
	if amountTo < 0:
		amountTo = 0
	tweenNode.interpolate_property(hpBar, 'value', hpBar.value, amountTo, .1, Tween.TRANS_QUAD,0)
	tweenNode.start()
	barNode.value -= gVars.bulletDamage
	var twoThirds = ((barNode.max_value/3)*2)
	var third = barNode.max_value/3
	if barNode.value > twoThirds:
		barNode.tint_progress = '00ff30'
	elif barNode.value > third and barNode.value <= twoThirds:
		barNode.tint_progress = 'fff300'
	else:
		barNode.tint_progress = 'ff0000'

func _on_hpBarTween_tween_completed(object, key):
	if hpBar.value <= 0:
		$bossHelperArea.disconnect('area_entered',self,'_on_bossHelperArea_area_entered')
		next_spawn()
		damageEffectPlayer.play("dead")
		self.queue_free()
		gSignals.spawn_coins(20,self.global_transform.origin + Vector3(0,2,0))
		gSignals.enemy_explosion('res://assets/particlesColor/enemExplosionRed.tres', self.global_transform.origin, 'bosshelper')
		gVars.playerExp = 15
	buggggy = [object, key]

func tween_move(from, to):
	tween.interpolate_property(hpBar, 'value', from, to,.1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == 'gotHit':
		color_change(currentColor)
	if anim_name == 'dead':
		self.queue_free()

func next_spawn():
	randomize()
	if whichScene == 'forrestOne':
		var randN = floor(rand_range(0,nextSpawnPosArrForrestOne.size()))
		for i in randN:
			gSignals.spawn_enemies('bossHelper', nextSpawnPosArrForrestOne[i], 'forrestOne', null)
	elif whichScene == 'forrestTwo':
		var randN = floor(rand_range(0,nextSpawnPosArrForrestTwo.size()))
		for i in randN:
			gSignals.spawn_enemies('bossHelper', nextSpawnPosArrForrestTwo[i], 'forrestTwo', null)


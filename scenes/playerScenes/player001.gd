extends KinematicBody

export (PackedScene) var fireExplosion

var gravity = Vector3.DOWN * 250
onready var playerMovSpeed = 35#15
onready var rotSpeed = 2
onready var jumpSpeed = 75
onready var bulletTransitionTime = .7
onready var bulletCoolDown = false
onready var bulletTimer = $bulletCoolDownTimer
onready var can_shoot = true

onready var jump = false 
onready var velocity = Vector3()
onready var aniplayer = get_parent().get_node("AnimationPlayer")
onready var effectPlayer = $Armature/Skeleton/BoneAttachment2/effect.get_node('leftRightAnim')
onready var shootPos = 'still'
onready var rayc = $RayCast
onready var raySeeThroughRay = $RayCast2
onready var sceneFloorRay = $RayCast3
onready var seethroughMesh
onready var seeTrigger = true
onready var playerUICoinLabel = $playerUI/coinCount
onready var shootCoolDownBar = $shootCoolDown
onready var playerUi = $playerUI
onready var seeThroughRayTimer = $seeThroughTimer

var dbug

func _ready():
	print(self.translation)
	dbug = gSignals.connect('stopPlayerMov', self, 'stop_movement')
	bulletTimer.wait_time = .5
	set_physics_process(false)
	yield(get_tree().create_timer(2),"timeout")
	aniplayer.play("liftOff")
	seeThroughRayTimer.wait_time = 3

#transition_scene('The Moon')
#stop_movement
func stop_movement(text, time):
	raySeeThroughRay.enabled = false
	set_physics_process(false)
	if text != 'noText':
		playerUi.transition_scene(text)
	yield(get_tree().create_timer(time),"timeout")
	set_physics_process(true)
	raySeeThroughRay.enabled = false
	seeThroughRayTimer.start()
	
func _physics_process(delta):
	if gVars.player != 'alive':
		self.set_physics_process(false)
	velocity += gravity * delta
	velocity.x = 0
	velocity.z = 0
	player_movement()
	var snap = Vector3.DOWN  if is_on_floor() else Vector3.ZERO

	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, false,4,.78)
	if jump and is_on_floor():  # or jump and is_on_wall():
		if gVars.soundOnOff:
			gSoundFunc.inst_sounds('player', 'jump', false, 0)
		effectPlayer.play('jumpFX')
		velocity.y = jumpSpeed
		jump = false
	
	gVars.playerGlobalPos = self.global_transform.origin
	gVars.playerRot= self.rotation_degrees

	see_through_wall()

onready var originalColor = 'ffffff'

func see_through_wall():
	if raySeeThroughRay.is_colliding() and seeTrigger:
		seethroughMesh = raySeeThroughRay.get_collider().get_parent()
#		print(seethroughMesh.name)
		if seethroughMesh.name.begins_with('floor') or seethroughMesh.name.begins_with('small') or seethroughMesh.is_in_group('enemyBot'):
			return
		else:
			seeTrigger = false
			if seethroughMesh.name.begins_with('cityGate'):
				raySeeThroughRay.get_collider().get_node('../..').see_through_gate('on', seethroughMesh, 'cityGate')
			elif seethroughMesh.name.begins_with('gateWall'):
				raySeeThroughRay.get_collider().get_node('../..').see_through_gate('on', seethroughMesh, 'gateWallTree')
			elif seethroughMesh.name.begins_with('wallCactus'):
				raySeeThroughRay.get_collider().get_node('../..').see_through_gate('on', seethroughMesh, 'wallCactus')
			else:
				if seethroughMesh.name == 'bin' or seethroughMesh.is_in_group('enemyBot') or seethroughMesh.name == 'enemyCont':
					return
				else:
#					print(seethroughMesh.name)
#					print(raySeeThroughRay.get_collider().get_node('../..').name)
					if !raySeeThroughRay.name == 'RayCast2': # or !raySeeThroughRay.is_in_group('enemyBot')
						if seethroughMesh.get('mesh').get('surface_1/material') != null:
							originalColor = seethroughMesh.get('mesh').get('surface_1/material').get('albedo_color')
						else:
							originalColor = 'ffffff'
#						if originalColor == null:
#							originalColor = 'ffffff'
#						else:
#							originalColor = seethroughMesh.get('mesh').get('surface_1/material').get('albedo_color')

					raySeeThroughRay.get_collider().get_node('../..').see_through('on', seethroughMesh, Color(originalColor))
	elif !raySeeThroughRay.is_colliding() and seeTrigger == false:
		seeTrigger = true
		if seethroughMesh.name == null:
			return
#		print(seethroughMesh.name)
		if seethroughMesh.name.begins_with('cityGate'):
			if sceneFloorRay.is_colliding():
				sceneFloorRay.get_collider().get_node('../..').see_through_gate('off', seethroughMesh, 'cityGate')
		elif seethroughMesh.name.begins_with('gateWall'):
			if sceneFloorRay.is_colliding():
				sceneFloorRay.get_collider().get_node('../..').see_through_gate('off', seethroughMesh, 'gateWallTree')
		elif seethroughMesh.name.begins_with('wallCactus'):
			if sceneFloorRay.is_colliding():
				sceneFloorRay.get_collider().get_node('../..').see_through_gate('off', seethroughMesh, 'wallCactus')
		else:
			if seethroughMesh.name == 'bin' or seethroughMesh.name == 'enemyCont' or seethroughMesh.name == null or seethroughMesh.name == 'bulletCont':
				return
			else:
				if sceneFloorRay.is_colliding():
					print(sceneFloorRay.get_collider().name)
					print(sceneFloorRay.get_collider().get_node('../..').name)
					if originalColor == null:
						sceneFloorRay.get_collider().get_node('../..').see_through('off', seethroughMesh, 'ffffff')
					else:
						sceneFloorRay.get_collider().get_node('../..').see_through('off', seethroughMesh, Color(originalColor))

func player_movement():
	move_forward()
	move_backward()
	rot_right()
	rot_left()
	side_right()
	side_left()
	shoot()

	if Input.is_action_just_pressed("jump") and is_on_floor() or Input.is_action_just_pressed("jump") and is_on_wall():
		aniplayer.playback_speed = 1
		aniplayer.stop()
		aniplayer.play("jump")
		jump = true

func move_forward():
	if Input.is_action_just_pressed("forw"):
		shootPos = 'forward'
		aniplayer.play("forward")
	if Input.is_action_pressed("forw"):
		velocity += transform.basis.z * playerMovSpeed
		if Input.is_action_just_pressed("shoot") and can_shoot:
			gSoundFunc.inst_sounds('player', 'fire', false, 0)
			can_shoot = false
			bulletTimer.start()
			shootCoolDownBar.shoot_coolDown_bar(bulletTimer.wait_time)
			aniplayer.stop()
			aniplayer.play("forwardShoot")
			inst_fire_explosion()
			gSignals.shoot_gun_bullet($bulletPosFrom.global_transform[3], $bulletPosTo.global_transform[3],
			bulletTransitionTime, self.rotation_degrees.y+180)
	if Input.is_action_just_released("forw"):
		aniplayer.stop()
		shootPos = 'still'
		aniplayer.play("forwardStop")

func move_backward():
	if Input.is_action_just_pressed("backw"):
		shootPos = 'backwards'
		aniplayer.play("backwards")
	if Input.is_action_pressed("backw"):
		velocity -= transform.basis.z * playerMovSpeed
		if Input.is_action_just_pressed("shoot") and can_shoot:
			gSoundFunc.inst_sounds('player', 'fire', false, 0)
			can_shoot = false
			bulletTimer.start()
			shootCoolDownBar.shoot_coolDown_bar(bulletTimer.wait_time)
			aniplayer.stop()
			aniplayer.play("backwardShoot")
			inst_fire_explosion()
			gSignals.shoot_gun_bullet($bulletPosFrom.global_transform[3], $bulletPosTo.global_transform[3],
			bulletTransitionTime, self.rotation_degrees.y+180)
	if Input.is_action_just_released("backw"):
		aniplayer.stop()
		shootPos = 'still'
		aniplayer.play("backwardStop")

func rot_right():
	if Input.is_action_pressed("right"):
		$Armature.rotation_degrees.z = lerp($Armature.rotation_degrees.z,25, .2)
		rotation_degrees.y -= rotSpeed
	if Input.is_action_just_released("right"):
		$Tween.interpolate_property($Armature,'rotation_degrees', Vector3(0,0,$Armature.rotation_degrees.z),Vector3(0,0,0),.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
		$Tween.start()
		
func side_right():
	if Input.is_action_pressed("sideRight"):
		$Armature.rotation_degrees.z = lerp($Armature.rotation_degrees.z,25, .2)
		velocity -= transform.basis.x * (playerMovSpeed/2)
	if Input.is_action_just_released("sideRight"):
		$Tween.interpolate_property($Armature,'rotation_degrees', Vector3(0,0,$Armature.rotation_degrees.z),Vector3(0,0,0),.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
		$Tween.start()
		
func rot_left():
	if Input.is_action_pressed("left"):
		rotation_degrees.y += rotSpeed
		$Armature.rotation_degrees.z = lerp($Armature.rotation_degrees.z,-25, .2)
	if Input.is_action_just_released("left"):
		$Tween.interpolate_property($Armature,'rotation_degrees', Vector3(0,0,$Armature.rotation_degrees.z),Vector3(0,0,0),.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
		$Tween.start()

func side_left():
	if Input.is_action_pressed("sideLeft"):
		$Armature.rotation_degrees.z = lerp($Armature.rotation_degrees.z,-25, .2)
		velocity += transform.basis.x * (playerMovSpeed/2)
	if Input.is_action_just_released("sideLeft"):
		$Tween.interpolate_property($Armature,'rotation_degrees', Vector3(0,0,$Armature.rotation_degrees.z),Vector3(0,0,0),.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
		$Tween.start()

func shoot():
	if Input.is_action_just_pressed("shoot") and shootPos == 'still' and can_shoot:
		if gVars.soundOnOff:
			gSoundFunc.inst_sounds('player', 'fire', false, 0)
		inst_fire_explosion()
		can_shoot = false
		bulletTimer.start()
		shootCoolDownBar.shoot_coolDown_bar(bulletTimer.wait_time)
		aniplayer.stop()
		aniplayer.play("shoot")
		gSignals.shoot_gun_bullet($bulletPosFrom.global_transform[3], $bulletPosTo.global_transform[3], bulletTransitionTime, self.rotation_degrees.y+180)

func inst_fire_explosion():
	var f = fireExplosion.instance()
	f.translation = $bulletPosFrom.translation - Vector3(0,0,.5)
	add_child(f)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'forwardStop' or anim_name == 'backwardStop' or anim_name == 'shoot' or anim_name == 'jump':
		aniplayer.play("idle")
	if anim_name == 'liftOff':
		set_physics_process(true)
		aniplayer.play("idle")
	if anim_name == 'dead':
		set_physics_process(false)
		gSignalUI.try_again()

func _on_playerArea_body_entered(body):
	if body.name != self.name:
		if body.is_in_group('coin'):
			gVars.coins += 1
			playerUICoinLabel.text = str('x ', gVars.coins)
			body.queue_free()
			var c = preload('res://scenes/props/coinSound.tscn').instance()
			add_child(c)
		if body.is_in_group('hpPlus'):
			if gVars.playerCurrHp < gVars.playerMaxHp:
				gVars.playerCurrHp += 10
				if gVars.playerCurrHp > gVars.playerMaxHp:
					gVars.playerCurrHp = gVars.playerMaxHp
			playerUi.textProgress.value = gVars.playerCurrHp
			body.queue_free()
			var c = preload('res://scenes/props/coinSound.tscn').instance()
			add_child(c)
				
#		print(body.name, '     - _on_playerArea_body_entered(body):     ', body.get_parent().name)

func _on_playerArea_area_entered(area):
	if area.is_in_group('bossHelperHammer'):
		velocity.y = 60
		var hitDist = area.global_transform.origin - self.global_transform.origin
		tween_hit(self.translation, self.translation - Vector3(hitDist.x, 0, hitDist.z))
		got_hit(30)
		gSignals.hammer_effect(self.global_transform.origin, 'sideHammer')
		gSignals.hammer_side_explosion(self.global_transform.origin)
#		print('damage')

func _on_bulletCoolDownTimer_timeout():
	can_shoot = true

#hammer hit from bossHelper
func tween_hit(from, to):
	$Tween.interpolate_property(self, 'translation', from, to, .1,Tween.TRANS_BOUNCE,0)
	$Tween.start()

func got_hit(damagePoints):
	aniplayer.play("gotHit")
	$playerUI.player_hp(damagePoints)

func _on_seeThroughTimer_timeout():
	raySeeThroughRay.enabled = true

func disable_all_ray(tof):
	rayc.enabled =  tof
	raySeeThroughRay.enabled =  tof
	sceneFloorRay.enabled =  tof

#####TESTING
#func rayCast_get_collision():
#	if sceneFloorRay.is_colliding():
#		print(sceneFloorRay.get_collider().get_parent().name)
#	var colNormal = rayc.get_collision_normal()
#	var floor_angle = rad2deg(acos(colNormal.dot(Vector3(0,1,0))))
#	print(floor_angle, ' ---> sceneFloorRay contact angle ')

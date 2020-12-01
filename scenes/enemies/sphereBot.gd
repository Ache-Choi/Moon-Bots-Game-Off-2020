extends RigidBody

export (String) var whichScene

onready var targetInRange = false
onready var enemySpeed = 5

onready var aniWeaponPlayer = $Armature002/AnimationPlayer
onready var wheelPlayer   = $Armature002/wheelAnim
onready var hitDeadPlayer = $Armature002/hitDeadAnim

onready var rayFollowPlayer = $RayCast
onready var rayObjectColFront = $obstacleCheckRay/front
onready var rayObjectColbackRight = $obstacleCheckRay/rightDiagBack
onready var rayObjectColbackLeft = $obstacleCheckRay/leftDiagBack
onready var hpBar = $healthBar/Viewport/TextureProgress
onready var timer = $Timer
onready var followingPlayer = true

onready var playerPos
onready var playerEnemDist 
onready var direct# direction

onready var ddgg

onready var canshoot = true
onready var shootTimer = $shootTimer
onready var fromBulletPos = $bulletPosfrom
onready var fromBulletPos2 = $bulletPosfrom2
onready var sphereMesh = $Armature002/sphereEnem006

onready var nexSpawnPosArr =[Vector3(348,0,-63),Vector3(365,0,3)]

var ggbug
onready var followPriority = 'player'

func _ready():
	wheelPlayer.play('wheelRot')
	hpBar.value = 700
	timer.wait_time = 2.5
	set_material()

func set_material():
	sphereMesh.set_surface_material(0, null)
	var newMat = load('res://scenes/enemies/sphereBot.tres').duplicate()
	newMat.flags_transparent = false
	newMat.params_grow_amount = 0
	sphereMesh.material_override = newMat

func _physics_process(delta):
	if gVars.player != 'alive':
		self.set_physics_process(false)
		wheelPlayer.play("stop")
	# PLAYER POSITION TO FOLLOW
	if followPriority == 'player':
		playerPos = gVars.playerGlobalPos - self.global_transform.origin
		playerEnemDist = playerPos.length()
		direct = playerPos.normalized()
		
		if rayObjectColFront.is_colliding():
			followingPlayer  = false
			if rayObjectColFront.get_collider().is_in_group('obstacle') or rayObjectColFront.get_collider().is_in_group('enemyBot'):
	#			print(rayObjectColFront.get_collider().name)
				if direct.x < 0:
					rayObjectColFront.enabled = false
					tween_rot('right')
	#				print('right')
				else:
					rayObjectColFront.enabled = false
					tween_rot('left')
	#				print('left')
		if rayObjectColbackRight.is_colliding() or rayObjectColbackLeft.is_colliding():
			self.translation -= transform.basis.z * delta * enemySpeed

		if !rayObjectColFront.is_colliding() and !rayObjectColbackLeft.is_colliding() and !rayObjectColbackRight.is_colliding():
#			followingPlayer = true
			if !rayFollowPlayer.is_colliding():
				wheelPlayer.play('wheelRot')
				self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
				self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)
			else:
#				print(rayFollowPlayer.get_collider().name)
				if rayFollowPlayer.get_collider().name == 'playerMesh' :
					wheelPlayer.play('stop')
					if canshoot:
						aniWeaponPlayer.play("openWeapon")
				else:
					self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
					self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)

func shoot():
	if canshoot:
		gSignals.enemy_bullet('smallCubeBot',fromBulletPos.global_transform.origin, self.rotation_degrees.y + 176)
		gSignals.enemy_bullet('smallCubeBot',fromBulletPos2.global_transform.origin, self.rotation_degrees.y - 176 )
		canshoot = false
		shootTimer.start()

func _on_aphereArea_area_entered(area):
	if area.name == 'playerBulletArea':
		hp_bar_tween(hpBar,$hpBarTween, gVars.bulletDamage)
		hitDeadPlayer.play("gotHit")
	if area.name == 'laveAreaForEnemies':
		hp_bar_tween(hpBar,$hpBarTween, hpBar.value)

func hp_bar_tween(node,tweenNode, damage):
	var amountTo = hpBar.value - damage
	if amountTo < 0:
		amountTo = 0
	tweenNode.interpolate_property(hpBar, 'value', hpBar.value, amountTo, .1, Tween.TRANS_QUAD,0)
	tweenNode.start()
	node.value -= damage
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
		gSignals.spawn_coins(1,self.global_transform.origin + Vector3(0,2,0))
		gSignals.enemy_explosion('res://assets/particlesColor/enemExplosionPurple.tres', self.global_transform.origin, 'sphereBot')
		gVars.playerExp += 30
		hitDeadPlayer.play("dead")
		aniWeaponPlayer.play("openWeapon")
		self.set_physics_process(false)
		canshoot = false
		$aphereArea.disconnect('area_entered', self , '_on_aphereArea_area_entered')
		if whichScene == 'caveScene':
			next_spawn()
		if whichScene == 'desertScene':
			next_spawn()
		self.queue_free()
	ggbug = [object, key]

func next_spawn():
	randomize()
	if self.whichScene == 'caveScene':
		var randN = floor(rand_range(0,2))
		if randN == 0:
			gSignals.spawn_enemies('sphereBot', Vector3(324.5,0,33.1)+ Vector3(56,0,60), 'caveScene', Vector3(0,0,0))
		else:
			gSignals.spawn_enemies('sphereBot', Vector3(324.5,0,33.1)+ Vector3(56,0,60), 'caveScene', Vector3(0,0,0))
			gSignals.spawn_enemies('sphereBot', Vector3(350.235,0,-62.7)+ Vector3(56,0,60), 'caveScene', Vector3(0,90,0))


	if self.whichScene == 'desertScene':
		gSignals.spawn_enemies('sphereBot', Vector3(266,0, 459), 'desertScene', Vector3(0,37.978,0))
		timer.start()
		
func _on_Timer_timeout():
	gSignals.spawn_enemies('sphereBot', Vector3(266,0, 459), 'desertScene', Vector3(0,37.978,0))

	
func tween_rot(rl):
	if rl == 'left':
		$Tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y + 90,self.rotation_degrees.z), .2, Tween.TRANS_LINEAR,0,0)
	else:
		$Tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees,
			Vector3(self.rotation_degrees.x,self.rotation_degrees.y - 90,self.rotation_degrees.z), .2, Tween.TRANS_LINEAR,0,0)
	rayObjectColFront.enabled = true
	$Tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'openWeapon':
		shoot()
	
func _on_shootTimer_timeout():
	canshoot = true
	aniWeaponPlayer.play("closeWeapon")


func _on_hitDeadAnim_animation_finished(anim_name):
	if anim_name == 'dead':
		self.queue_free()


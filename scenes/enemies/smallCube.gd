extends RigidBody

onready var animplayer = $AnimationPlayer
onready var targetInRange = false
onready var enemySpeed = 4

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
onready var toBulletPos = $bulletPosTo

var ggbug
onready var followPriority = 'player'

func _ready():
	set_physics_process(false)
	hpBar.value = 100
	timer.wait_time = 2.5
	timer.start()

func _on_Timer_timeout():
	animplayer.play("pop")

func _physics_process(delta):
	if gVars.player != 'alive':
		self.set_physics_process(false)
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
				self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
				self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)
			else:
				if rayFollowPlayer.get_collider().name == 'playerMesh':
#					self.global_transform.origin 
					if canshoot:
						shoot()
				else:
					self.global_transform.origin += Vector3(direct.x,0,direct.z) * delta * enemySpeed
					self.look_at(Vector3(gVars.playerGlobalPos.x,0,gVars.playerGlobalPos.z),Vector3.UP)

func shoot():
	gSignals.enemy_bullet('smallCubeBot',fromBulletPos.global_transform.origin, self.rotation_degrees.y + 180)
	canshoot = false
	shootTimer.start()

func _on_Area_area_entered(area):
	if area.name == 'playerBulletArea':
		hp_bar_tween(hpBar,$hpBarTween)

func hp_bar_tween(node,tweenNode):
	var amountTo = hpBar.value - gVars.bulletDamage
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
		gSignals.spawn_coins(1,self.global_transform.origin + Vector3(0,2,0))
		gSignals.enemy_explosion('res://assets/particlesColor/enemExplosionPurple.tres', self.global_transform.origin, 'smallCube')
		gVars.playerExp += 5
		self.queue_free()
	ggbug = [object, key]

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
	if anim_name == 'pop':
		animplayer.play("search")
		if gVars.soundOnOff:
			$searchSound.playing = true
		ddgg = $smallCubeArea.connect('area_entered', self, '_on_Area_area_entered')
	if anim_name == 'search':
		set_physics_process(true)

func _on_shootTimer_timeout():
	canshoot = true




extends Spatial

export (PackedScene) var rocketArms

onready var quadTimer = $quadLegSpawnTimer
onready var quadSpawnPosCont = $quadSpawnPos
onready var copterSpawnPosCont = $copterSpawnPos
onready var bossHelperCont = $bossHelperSpawnPos

onready var hpBar = $hpBar/Viewport/TextureProgress
onready var hpBar2 = $hpBar/Viewport2/TextureProgress2
onready var tween1 = $hpBar/TweenHP
onready var tween2 = $hpBar/TweenHP2
onready var aniPl = $AnimationPlayer
onready var rocketPos = $rocketPos.global_transform.origin
onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin
var sdsd


func _ready():
	gVars.saveLoadPos = saveLoadPoint
	gVars.saveLoadRot = Vector3(0,20,0)
	gSignals.change_light(1)
	gSignals.reset_player_translation(Vector3(0,60,60))
	inst_rocketArms()
	if gVars.musicOnOff:
		$bgMusic/AnimationPlayer.play("fadeIn")
		$bgMusic.playing = true

func inst_rocketArms():
	var r = rocketArms.instance()
	r.translation = rocketPos
	r.rotation_degrees.y = 180
	add_child(r)

func see_through(onOff, mesh, color):
	if onOff == 'on':
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 1)
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color(color), Color('808080'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
	else:
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('808080'), Color(color), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		yield(get_tree().create_timer(.3), 'timeout')
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 0)

func see_through_gate(onOff, mesh, type):
##############CITY WALLLLLLLL
	if onOff == 'on' and type == 'cityGate' :
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 1)
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('ffffff') , Color('aaaaaa'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 1)
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('3432a4'), Color('232272'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
	elif onOff == 'off' and type == 'cityGate' :
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('aaaaaa'), Color('ffffff'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 0)
		
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('232272'), Color('3432a4'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 0)
########################TREE WAALLLLLLLLLLLLL
	if onOff == 'on' and type == 'gateWallTree' :
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 1)
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('00ca11') , Color('169821'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 1)
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('ffffff'), Color('a2a2a2'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
	elif onOff == 'off' and type == 'gateWallTree' :
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('169821'),Color('00ca11'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 0)
		
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('a2a2a2'), Color('ffffff'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 0)
########################CACTUS  WAALLLLLLLLLLLLL
	if onOff == 'on' and type == 'wallCactus' :
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 1)
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('ffffff') , Color('a7a7a7'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 1)
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('00be2f'), Color('00721c'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
	elif onOff == 'off' and type == 'wallCactus' :
		var mat = mesh.get('mesh').get('surface_1/material')
		$Tween.interpolate_property(mat, 'albedo_color', Color('a7a7a7'),Color('ffffff'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_1/material').set('params_blend_mode', 0)
		
		var mat2 = mesh.get('mesh').get('surface_2/material')
		$Tween2.interpolate_property(mat2, 'albedo_color', Color('00721c'), Color('00be2f'), .2,Tween.TRANS_QUAD,Tween.EASE_OUT,0)
		$Tween2.start()
		yield(get_tree().create_timer(.2), 'timeout')
		mesh.get('mesh').get('surface_2/material').set('params_blend_mode', 0)

func spawn_quadLegs():
	var posX = rand_range(-15, 15)
	var posZ = rand_range(-20, 20)
	var randN = rand_range(.1, .3)
	var numCount = floor(rand_range(1,quadSpawnPosCont.get_child_count()))
	for i in numCount:
		yield(get_tree().create_timer(randN),"timeout")
		gSignals.spawn_enemies('quadLegsBot', quadSpawnPosCont.get_child(i).global_transform.origin + Vector3(posX,0,posZ), 'moon', Vector3(0,rand_range(0,360),0))

func _on_quadSpawnArea_body_entered(body):
	if body.name == 'playerMesh':
		spawn_quadLegs()

func spawn_copter_bots():
	randomize()
	var posx = rand_range(-15,15)
	var posz = rand_range(-15,15)
	var randN = rand_range(.1, .3)
	var numCount = floor(rand_range(1,copterSpawnPosCont.get_child_count()))
	for i in numCount:
		yield(get_tree().create_timer(randN),"timeout")
		gSignals.inst_copter_bot('copterBot',copterSpawnPosCont.get_child(i).global_transform.origin + Vector3(posx,0,posz))

func _on_copterSpawnArea_body_entered(body):
	if body.name == 'playerMesh':
		spawn_copter_bots()

func _on_bossHelperArea_body_entered(body):
	if body.name == 'playerMesh':
		spawn_boss_helper()

func spawn_boss_helper():
	randomize()
	var randCount = floor(rand_range(1,bossHelperCont.get_child_count()))
	var randN = rand_range(.1, .3)
	for i in randCount:
		yield(get_tree().create_timer(randN),"timeout")
		gSignals.spawn_enemies('bossHelper', bossHelperCont.get_child(i).global_transform.origin, 'moon', bossHelperCont.get_child(i).rotation_degrees)

func _on_TweenHP_tween_completed(object, key):
	if hpBar.value <= 0:
		gSignals.enemy_explosion('res://assets/particlesColor/enemExplosionBlue.tres', self.global_transform.origin, 'moonScene')
		gVars.playerExp += 1000
		aniPl.play("ending")
	sdsd = [object, key]

func got_hit():
	hp_bar_tween(hpBar,tween1)
	hp_bar_tween(hpBar2,tween2)
	print(hpBar2.value, ' value')

func hp_bar_tween(node,tweenNode):
	aniPl.play("gotHit")
	var amountTo = node.value - gVars.bulletDamage
	print(amountTo, 'amount to')
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

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'ending':
		self.get_node('deadBoss2').queue_free()
		self.get_node('deadBoss003').queue_free()
		print('game finished')


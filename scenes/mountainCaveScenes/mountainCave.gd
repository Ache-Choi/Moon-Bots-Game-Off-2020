extends Spatial

export (PackedScene) var energyBall

onready var boxSpawnPos = $boxPosCont
onready var quadSpawnPos = $quadSpawnPos
onready var spawnQuadTimer = $quadSpawnTimer
var spawnQuadCount = int()
var buugy
onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin

func _ready():
	gVars.saveLoadPos = saveLoadPoint + Vector3(56.572,0,60.393)
	gVars.saveLoadRot = Vector3(0,101,0)
	$CPUParticles.emitting = true
	if gVars.playerItemArrAcquired[2] == 0:
		spawn_energy_ball(energyBall)
	self.translation = Vector3(56.572,0,60.393)
	spawn_boxes()
	if gVars.musicOnOff:
		$bgMusic/AnimationPlayer.play("fadeIn")
		$bgMusic.playing = true
		

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

func _on_citySceneArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('Center City', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('cityScene')

func spawn_energy_ball(scene):
	var r = scene.instance()
#	r.translation = Vector3(334,31,-195)
	r.translation = $energyBallpos.translation
	add_child(r)
		
func spawn_boxes():
	for i in boxSpawnPos.get_children():
		gSignals.spawn_boxes(i.global_transform.origin)

func spawn_quadLegs():
	randomize()
	spawnQuadTimer.wait_time = 1
	var randN = floor(rand_range(0,quadSpawnPos.get_child_count()))
	spawnQuadCount = randN
	spawnQuadTimer.start()

func _on_quadSpawnTimer_timeout():
	randomize()
	var randTime = rand_range(.1,.4)
	spawnQuadCount -= 1
	spawnQuadTimer.wait_time = randTime
	if spawnQuadCount <= 0:
		spawnQuadTimer.one_shot = true
	var randN = floor(rand_range(0,quadSpawnPos.get_child_count()))
	gSignals.spawn_enemies('quadLegsBot', quadSpawnPos.get_child(randN).translation, 'caveScene', Vector3(0,rand_range(0,360),0))

func _on_quadSpawnArea_body_entered(body):
	if body.name  == 'playerMesh':
		spawn_quadLegs()

func _on_copterSpawnArea_body_entered(body):
	if body.name == 'playerMesh':
		randomize()
		var randCount = floor(rand_range(1,5))
		for i in randCount:
			var posx = rand_range(97,137)
			var posz = rand_range(-55,-136)
			yield(get_tree().create_timer(.2),"timeout")
			gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz) + Vector3(56,0,60))


func _on_lavaArea_body_entered(body):
	if body.name == 'playerMesh':
		print('you dead')


func _on_Area_body_entered(body):
	if body.name == 'playerMesh':
		gSignals.change_light(.2)

func _on_Area_body_exited(body):
	if body.name == 'playerMesh':
		gSignals.change_light(2.5)

func _on_spawnSphereBotArea_body_entered(body):
	if body.name == 'playerMesh':
		gSignals.spawn_enemies('sphereBot', Vector3(324.5,0,30)+ Vector3(56,0,60), 'caveScene', Vector3(0,0,0))
		gSignals.spawn_enemies('sphereBot', Vector3(344.235,0,-62.7)+ Vector3(56,0,60), 'caveScene', Vector3(0,90,0))
		$spawnSphereBotArea.disconnect("body_entered",self,'_on_spawnSphereBotArea_body_entered')


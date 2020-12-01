extends Spatial

onready var checkCompCharac = $checkCompCharac

onready var boxPosCont = $treasureBoxPos
onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin

func _ready():
	gVars.saveLoadPos = saveLoadPoint
	gVars.saveLoadRot = Vector3(0,-180,0)
	gSignals.inst_comp_character(4)
	checkCompCharac.wait_time = 60
	checkCompCharac.start()
	spawn_boxes(5)

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

func _on_copterInstArea_body_entered(body):
	if body.name == 'playerMesh':
		randomize()
		var randCount = floor(rand_range(1,5))
		for i in randCount:
			var posx = rand_range(70,90)
			var posz = rand_range(-10,10)
			yield(get_tree().create_timer(.2),"timeout")
			gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))

func _on_copterInstArea2_body_entered(body):
	if body.name == 'playerMesh':
		randomize()
		var randCount = floor(rand_range(1,5))
		for i in randCount:
			var posx = rand_range(-14,14)
			var posz = rand_range(-70,-90)

			yield(get_tree().create_timer(.2),"timeout")
			gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))

func _on_copterInstArea3_body_entered(body):
	if body.name == 'playerMesh':
		randomize()
		var randCount = floor(rand_range(1,5))
		for i in randCount:
			var posx = rand_range(-70,-90)
			var posz = rand_range(12,-12)
			yield(get_tree().create_timer(.2),"timeout")
			gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))

func _on_copterInstArea4_body_entered(body):
	if body.name == 'playerMesh':
		randomize()
		var randCount = floor(rand_range(1,5))
		for i in randCount:
			var posx = rand_range(-30,30)
			var posz = rand_range(70,90)
			yield(get_tree().create_timer(.2),"timeout")
			gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))

func _on_forrestOne_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('North Forrest', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('northForrest')

func _on_westForrestArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('West Forrest',3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('westForrest')

func _on_desertArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('South Desert', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('desertScene')

func _on_caveArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('East Cave',3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('caveScene')

func _on_checkCompCharac_timeout():
	gSignals.inst_comp_character(2)

func spawn_boxes(num):
	randomize()
	var randX = rand_range(-7,7)
	var randZ = rand_range(-7,7)
	for i in num:
		var boxPos = floor(rand_range(0,boxPosCont.get_child_count()))
		gSignals.spawn_boxes(boxPosCont.get_child(boxPos).global_transform.origin+ Vector3(randX,0,randZ))






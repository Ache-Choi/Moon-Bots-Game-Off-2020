extends Spatial

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



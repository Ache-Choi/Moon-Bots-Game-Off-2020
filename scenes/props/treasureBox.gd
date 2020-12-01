extends Spatial


onready var aniPlayer = $AnimationPlayer
onready var hpBar = $healthBar/Viewport/TextureProgress 
onready var tween = $Tween

onready var topBox = $mesh/floorBoxTop
onready var bottomBox = $mesh/floorBoxBottom

onready var boxTim = $boxTimer
var asd

func _ready():
	randomize()
	hpBar.value = 200
	set_material(topBox, bottomBox, 'res://assets/images/colors.jpg')
	boxTim.wait_time = .2

func tween_move(from, to):
	tween.interpolate_property(hpBar, 'value', from, to,.1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func _on_treasureBoxArea_area_entered(area):
	if area.name == 'playerBulletArea':
		aniPlayer.play("boxHit")
		var amountTo = hpBar.value - gVars.bulletDamage
		if amountTo <= 0:
			$treasureBoxArea.disconnect('area_entered',self,'_on_treasureBoxArea_area_entered')
			amountTo = 0
			tween_move(hpBar.value, amountTo)
			boxTim.start()
		else:
			tween_move(hpBar.value, amountTo)

func _on_Tween_tween_completed(object, key):
	if hpBar.value <= 0:
		aniPlayer.play("boxOpen")
	asd = [object, key]

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'boxOpen':
		fade_out_tween(topBox, bottomBox)

func set_material(node1, node2, image):
	var mat = SpatialMaterial.new()
	node1.set('material_override', mat)
	mat.albedo_texture = load(image)
	var mat2 = SpatialMaterial.new()
	node2.set('material_override', mat2)
	mat2.albedo_texture = load(image)

func fade_out_tween(mesh,mesh2):
	mesh.get('material_override').set('params_blend_mode', 1)
	var mat = mesh.get('material_override')
	$fadeOutTween.interpolate_property(mat, 'albedo_color', Color(1,1,1,1), Color(0,0,0,0), 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$fadeOutTween.start()
	
	mesh2.get('material_override').set('params_blend_mode', 1)
	var mat2 = mesh.get('material_override')
	$fadeOutTween.interpolate_property(mat2, 'albedo_color',Color(1,1,1,1), Color(0,0,0,0), 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$fadeOutTween.start()

func _on_fadeOutTween_tween_completed(object, key):
	self.queue_free()
	asd = [object, key]

func _on_boxTimer_timeout():
	randomize()
	var coinAmount = floor(rand_range(2,10))
	gSignals.spawn_coins(coinAmount,$coinSpawnPos.global_transform.origin)
	var hpPlusCount = floor(rand_range(0,4))
	gSignals.spawn_hp_plus(hpPlusCount, $coinSpawnPos.global_transform.origin)













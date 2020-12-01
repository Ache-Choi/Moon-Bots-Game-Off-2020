extends Spatial

export (PackedScene) var gunBullet
export (PackedScene) var bulletExplosion

export (Array,PackedScene) var scenes
onready var sceneNameArr = ['cityScene', 'northForrest', 'westForrest', 'desertScene', 'caveScene' , 'moonScene'] 

export (Array,PackedScene) var enemyScenes
onready var enemyScenesNameArr  = ['bossHelper', 'quadLegsBot', 'sphereBot']

onready var playerCont = $playerContainer

export (PackedScene) var player
export (PackedScene) var transporterPath
export (PackedScene) var cubeBot
export (PackedScene) var enemExplosion
export (PackedScene) var quadBulletExplosion

export (PackedScene) var coin
export (PackedScene) var hpPlus
export (PackedScene) var treasureBox
export (PackedScene) var enemyBullet
export (PackedScene) var enemyBulletExplosion
export (PackedScene) var hammerFX
export (PackedScene) var hammerSideFX
export (PackedScene) var hammerSideHit
export (PackedScene) var quadLegsBullet
export (PackedScene) var onRocketFx
export (PackedScene) var compCharacterPath

#UI
export (PackedScene) var tryAgainPage

export (PackedScene) var uiSound

onready var bin = $bin
onready var sceneCont = $sceneContainer
onready var enemCont = $enemyCont
onready var bulletCont = $bulletCont
onready var lightChange = $lightContainer/DirectionalLight
var ddbuug

# yield(function(), 'completed')
# try again test
# side hp concord with playerui hp  bar 


func _ready():
	saveLoad.load_data()
	saveLoad.save_data()
	ddbuug = gSignals.connect('shootGunBullet', self, 'bullet_instance')
	ddbuug = gSignals.connect('bulletExplosion', self, 'bullet_explosion_instance')
	ddbuug = gSignals.connect('instCopterBot', self, 'inst_copter_bot')
	ddbuug = gSignals.connect('spawnCoins', self, 'spawn_coins')
	ddbuug = gSignals.connect('spawnHpPlus', self, 'spawn_hp_plus')
	ddbuug = gSignals.connect('enemExplosion', self, 'inst_enem_explosion')
	ddbuug = gSignals.connect('goToScene', self, 'go_to_scene')
	ddbuug = gSignals.connect('spawnEnemies', self, 'spawn_enemy')
	ddbuug = gSignals.connect('spawnBoxes', self, 'spawn_box')
	ddbuug = gSignals.connect('enemBullet', self, 'spawn_enemy_bullet')
	ddbuug = gSignals.connect('enemBulletExplosion', self, 'spawn_enem_bullet_explosion')
	ddbuug = gSignals.connect('enemQuadBulletExplosion', self, 'spawn_quad_bullet_explosion')
	ddbuug = gSignals.connect('instCompCharacter', self, 'inst_comp_character')
	ddbuug = gSignals.connect('hammerEffect', self, 'hammer_effect')
	ddbuug = gSignals.connect('hammerSideExplosion', self, 'hammer_side_explo')
	ddbuug = gSignals.connect('resetPlayerPos', self, 'reset_player_pos')
	ddbuug = gSignals.connect('onRocketFX', self, 'on_rocket_FX')
	ddbuug = gSignals.connect('lightChange', self, 'light_change')
	ddbuug = gSignalUI.connect('tryAgain', self, 'try_again_page')

	go_to_scene(gVars.playerCurrentScene)
	set_player_position()

func inst_sound(type,soundName,loopSet,volu):
	var  s = uiSound.instance()
	if type == 'ui':
		s.set_ui_audio(soundName,loopSet,volu)
	elif type == 'player':
		s.set_player_audio(soundName,loopSet,volu)
	elif type == 'bossHelper':
		s.set_bossHelper_audio(soundName,loopSet,volu)
	elif type == 'enemies':
		s.set_enemies_audio(soundName,loopSet,volu)
		
	bin.add_child(s)

func try_again_page():
	var t = tryAgainPage.instance()
	bin.add_child(t)

func set_player_position():
	if $playerContainer.get_child_count() > 0:
		$playerContainer.get_node("player").translation = gVars.saveLoadPos
		$playerContainer.get_node('player').get_child(0).rotation_degrees = gVars.saveLoadRot

func _process(delta):
	ddbuug = delta
	if Input.is_action_just_pressed("testInput"):
		if sceneCont.get_child_count() > 0:
			for i in sceneCont.get_children():
				print(i.name, ' ------ sceneCont' )
		if enemCont.get_child_count() > 0:
			for i in enemCont.get_children():
				print(i.name, ' ------ enemCont' )
		if bin.get_child_count() > 0:
			for i in bin.get_children():
				print(i.name, ' ------ bin' )
		if bulletCont.get_child_count() > 0:
			for i in bulletCont.get_children():
				print(i.name, ' ------ bulletCont' )
		if $playerContainer.get_child_count() > 0:
			for i in $playerContainer.get_children():
				print(i.name, ' ------ playerContainer' , i.global_transform.origin)

func save_load_point(savingPoint):
	pass

func light_change(energy):
	lightChange.light_energy = energy

func bullet_instance(from, to, time, rotDegY):
	var b = gunBullet.instance()
	bulletCont.add_child(b)
	b.bullet_dist(from, to, time, rotDegY)

func bullet_explosion_instance(pos):
	var ex = bulletExplosion.instance()
	ex.translation = pos
	bulletCont.add_child(ex)

func inst_copter_bot(scene, pos):
	if scene == 'copterBot':
		var c = transporterPath.instance()
		c.translation = pos
		bin.add_child(c)
	if scene == 'cubeBot':
		var c = cubeBot.instance()
		c.translation = pos+ Vector3(0,-1,0)
		bin.add_child(c)

func spawn_coins(counts,pos):
	randomize()
	if bin.get_child_count() < 500: 
		for i in counts:
			var c = coin.instance()
			c.translation = pos
			yield(get_tree().create_timer(rand_range(.01,.07)),"timeout")
			bin.add_child(c)

func spawn_hp_plus(counts,pos):
	randomize()
	if bin.get_child_count() < 500: 
		for i in counts:
			var h = hpPlus.instance()
			h.translation = pos
			yield(get_tree().create_timer(rand_range(.01,.07)),"timeout")
			bin.add_child(h)

func inst_enem_explosion(sceneColor, pos, type):
	var ex = enemExplosion.instance()
	ex.set_color(sceneColor)
	ex.translation = pos
	bulletCont.add_child(ex)
	
	if type == 'smallCube':
		var soundExp = preload('res://scenes/enemies/bullets/snapExplosion.tscn').instance()
		bin.add_child(soundExp)
	elif type == 'moonScene':
		var soundExp = preload('res://scenes/enemies/bullets/snapExplosion.tscn').instance()
		soundExp.volume_db = 3
		soundExp.pitch_scale = .4
		bin.add_child(soundExp)
	else:
		var soundExp = preload('res://scenes/enemies/bullets/snapExplosion.tscn').instance()
		soundExp.volume_db = 0
		soundExp.pitch_scale = .8
		bin.add_child(soundExp)

func go_to_scene(sceneName):
	clear_scene()
	gVars.playerCurrentScene = sceneName
	if sceneName != 'moonScene':
		for i in sceneNameArr.size():
			if sceneNameArr[i] == str(sceneName):
				var s = scenes[i].instance()
				sceneCont.add_child(s)
	else:
		var s = scenes[5].instance()
		sceneCont.add_child(s)
		print(s.translation)

func reset_player_pos(pos):
	$playerContainer/player/playerMesh.translation = pos
	$playerContainer/player/playerMesh.rotation_degrees = Vector3(0,180,0)
	$playerContainer/player/playerMesh.visible = true

func clear_scene():
	if sceneCont.get_child_count() > 0:
		for i in sceneCont.get_children():
			i.queue_free()
	if enemCont.get_child_count() > 0:
		for i in enemCont.get_children():
			i.queue_free()
	if bin.get_child_count() > 0:
		for i in bin.get_children():
			i.queue_free()
	if bulletCont.get_child_count() > 0:
		for i in bulletCont.get_children():
			i.queue_free()

func spawn_enemy(enemyType, pos, which_scene, rot):
	if enemCont.get_child_count() < 20:
		var instScene
		for i in enemyScenesNameArr.size():
			if enemyScenesNameArr[i] == str(enemyType):
				instScene = enemyScenes[i]
		var inst = instScene.instance()
		if which_scene != null:
			inst.whichScene = which_scene
		if which_scene == 'moon' or which_scene == 'caveScene':
			inst.rotation_degrees = rot
		inst.translation = pos
		enemCont.add_child(inst)

func spawn_box(pos):
	var b = treasureBox.instance()
	b.translation = pos
	bulletCont.add_child(b)

func spawn_enemy_bullet(type, from, rot):
	if type == 'smallCubeBot':
		var b = enemyBullet.instance()
		b.translation = from
		b.rotation_degrees.y = rot
		bulletCont.add_child(b)
	if type == 'quadLegsBullet':
		var b = quadLegsBullet.instance()
		b.translation = from
		b.rotation_degrees.y = rot
		bulletCont.add_child(b)

func spawn_enem_bullet_explosion(pos):
	var ex = enemyBulletExplosion.instance()
	ex.translation = pos
	bulletCont.add_child(ex)

func spawn_quad_bullet_explosion(pos):
	var ex = quadBulletExplosion.instance()
	ex.translation = pos
	bulletCont.add_child(ex)

func inst_comp_character(num):
	var count = 0 
	for i in bin.get_children():
		if i.is_in_group('compCharacters'):
			count += 1
	if count < 15 :
		for i in num:
			var c = compCharacterPath.instance()
			bin.add_child(c)
			yield(get_tree().create_timer(5),"timeout")

func hammer_effect(pos, type):
	if type == 'hammer':
		var h = hammerFX.instance()
		h.translation = pos
		bulletCont.add_child(h)
	elif type == 'sideHammer':
		var h = hammerSideHit.instance()
		h.translation = pos
		bulletCont.add_child(h)

func hammer_side_explo(pos):
	var ex = hammerSideFX.instance()
	ex.translation = pos
	bulletCont.add_child(ex)

func on_rocket_FX(pos):
	var r = onRocketFx.instance()
	r.translation = pos
	bulletCont.add_child(r)



extends Spatial

export (PackedScene) var arms

onready var boxposCont = $boxPosCont
onready var spawnCopterTimer = $spawnTimer
var copterCounts = int()

onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin

func _ready():
	gVars.saveLoadPos = saveLoadPoint
	gVars.saveLoadRot = Vector3(0,43,0)
	randomize()
	var randNN = rand_range(.1, .4)
	spawnCopterTimer.wait_time = randNN
	if gVars.musicOnOff:
		$bgMusic/AnimationPlayer.play("fadeIn")
		$bgMusic.playing = true

	if gVars.playerItemArrAcquired[1] == 0:
		spawn_rocket_arms(arms)
	spawn_boxes()
	gSignals.spawn_enemies('bossHelper', $firstBot.global_transform.origin, 'forrestOne', null)

func _on_citySceneArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('Center City', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('cityScene')

func _on_spawnCopterArea_body_entered(body):
	if body.name == 'playerMesh':
		var randN = floor(rand_range(0,5))
		copterCounts = randN
		spawnCopterTimer.start()

func spawn_boxes():
	for i in boxposCont.get_children():
		gSignals.spawn_boxes(i.global_transform.origin)

func spawn_rocket_arms(scene):
	var r = scene.instance()
	r.translation = $rocketArmsPos.global_transform.origin
	add_child(r)

func _on_spawnTimer_timeout():
	randomize()
	var randNN = rand_range(.1, .4)
	spawnCopterTimer.wait_time = randNN
	copterCounts -= 1
	if copterCounts <= 0:
		spawnCopterTimer.one_shot = true
	var posx = rand_range(-50,-100)
	var posz = rand_range(-300,-240)
	gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))



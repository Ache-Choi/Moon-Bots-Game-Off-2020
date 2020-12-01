extends Spatial


onready var boxPosCont = $boxSpawnPos
onready var firstPos = $firstBossHelperPos
onready var copterTimer = $spawnCopterTimer
var copterCounts = int()

onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin

func _ready():
	gVars.saveLoadPos = saveLoadPoint
	gVars.saveLoadRot = Vector3(0,142,0)
	gSignals.spawn_enemies('bossHelper', firstPos.global_transform.origin, 'forrestTwo', null)
	spawn_boxes()
	if gVars.musicOnOff:
		$bgMusic/AnimationPlayer.play("fadeIn")
		$bgMusic.playing = true

func _on_citySceneArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('Center City', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('cityScene')

func spawn_boxes():
	for i in boxPosCont.get_children():
		gSignals.spawn_boxes(i.global_transform.origin)


func _on_spawnCopterArea_body_entered(body):
	if body.name == 'playerMesh':
		var randN = floor(rand_range(0,8))
		copterCounts = randN
		copterTimer.start()

func _on_spawnCopterTimer_timeout():
	randomize()
	var randNN = rand_range(.1, .4)
	copterTimer.wait_time = randNN
	copterCounts -= 1
	if copterCounts <= 0:
		copterTimer.one_shot = true
	var posx = rand_range(-220,-150)
	var posz = rand_range(99,54)
	gSignals.inst_copter_bot('copterBot',Vector3(posx,0,posz))

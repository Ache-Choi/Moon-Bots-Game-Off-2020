extends Spatial

export (PackedScene) var rocket
export (PackedScene) var rocketArms

onready var fourItems
onready var rocketSpawnPos = $rocketSpawnPos

onready var saveLoadPoint = $saveLoadPoint.get_node('playerSetPos').global_transform.origin

func _ready():
	gVars.saveLoadPos = saveLoadPoint
	gVars.saveLoadRot = Vector3(0,-37,0)
	gVars.playerCurrentScene = 'South Desert'
	fourItems = 0
	spawn_boxes()
	if gVars.playerItemArrAcquired[0] == 0:
		spawn_rocket(rocket)
	for i in gVars.playerItemArrAcquired:
		if i == 1:
			fourItems += 1
	if fourItems == 4:
		spawn_rocketArms(rocketArms)
	gSignals.spawn_enemies('sphereBot', Vector3(266,0, 459), 'desertScene', Vector3(0,37.978,0))

func _on_citySceneArea_body_entered(body):
	if body.name == 'playerMesh':
		body.stop_movement('Center City', 3)
		yield(get_tree().create_timer(.4),"timeout")
		gSignals.go_to_scene('cityScene')

func spawn_rocket(scene):
	var r = scene.instance()
	r.translation = rocketSpawnPos.global_transform.origin
	add_child(r)

func spawn_rocketArms(scene):
	var r = scene.instance()
	r.translation = rocketSpawnPos.global_transform.origin 
	add_child(r)

func spawn_boxes():
	for i in $boxPos.get_children():
		gSignals.spawn_boxes(i.global_transform.origin)





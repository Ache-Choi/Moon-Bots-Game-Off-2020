extends Spatial

onready var posFive = $posFive.global_transform.origin
onready var posSix  = $posSix.global_transform.origin
onready var posSeven = $posSeven.global_transform.origin
onready var timer5  = $posFiveArea/Timer
onready var timer6 = $posSixArea/Timer2
onready var timer7 = $posSevenArea/Timer3
#	gSignals.spawn_enemies('quadLegsBot', Vector3(-58,2,235))

func _ready():
	timer5.wait_time = 2
	timer6.wait_time = 2
	timer7.wait_time = 2

func _on_posFiveArea_body_entered(body):
	if body.name == 'playerMesh':
		timer5.start()

func _on_posSixArea_body_entered(body):
	if body.name == 'playerMesh':
		timer6.start()

func _on_posSevenArea_body_entered(body):
	if body.name == 'playerMesh':
		timer7.start()

func _on_Timer_timeout():
	randomize()
	var randX = rand_range(-15,15)
	var randZ = rand_range(-15,15)
	gSignals.spawn_enemies('quadLegsBot', posFive + Vector3(randX,0,randZ), null, null)
	
func _on_Timer2_timeout():
	randomize()
	var randX = rand_range(-15,15)
	var randZ = rand_range(-15,15)
	gSignals.spawn_enemies('quadLegsBot', posSix + Vector3(randX,0,randZ), null, null)
	
func _on_Timer3_timeout():
	randomize()
	var randX = rand_range(-15,15)
	var randZ = rand_range(-15,15)
	gSignals.spawn_enemies('quadLegsBot', posSeven + Vector3(randX,0,randZ), null, null)

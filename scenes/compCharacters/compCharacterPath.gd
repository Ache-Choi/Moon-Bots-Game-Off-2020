extends Spatial

export (PackedScene) var fatBunny
export (PackedScene) var tallBunny
export (PackedScene) var mechanicBunny

onready var goingComing = true
onready var tweenTime = 100

onready var path1 = 80
onready var path2 = 100
onready var path3 = 120
onready var path4 = 100
onready var path5 = 100

onready var pathArr = [$Path1/PathFollow,$Path2/PathFollow,$Path3/PathFollow,$Path4/PathFollow,$Path5/PathFollow]

onready var currentPath 

var qwer
func _ready():
	randomize()
	var tof = floor(rand_range(0, 2))
	var randNum = floor(rand_range(0, pathArr.size()-1))
	currentPath = pathArr[randNum]
	if tof == 0:
		goingComing = true
	else:
		goingComing = false
		currentPath.unit_offset = 1
	inst_bunny(randNum)
	player_walk(currentPath)

func inst_bunny(num):
	randomize()
	var randn = floor(rand_range(0, 3))
	if randn == 0:
		var f = fatBunny.instance()
		pathArr[num].add_child(f)
	elif randn == 1:
		var f = tallBunny.instance()
		pathArr[num].add_child(f)
	else:
		var f = mechanicBunny.instance()
		pathArr[num].add_child(f)

func player_walk(path):
	if goingComing:
		path.get_child(0).rotation_degrees.y = 0
		var unitOffset = path.unit_offset
		var pathTime
		if unitOffset != 0:
			pathTime = tweenTime-(tweenTime * unitOffset)
		else: 
			pathTime = tweenTime
		$Tween.interpolate_property(path, 'unit_offset', unitOffset, 1, pathTime ,Tween.TRANS_LINEAR,0)
		$Tween.start()
	else:
		path.get_child(0).rotation_degrees.y = 180
		var unitOffset = path.unit_offset
		var pathTime
		if unitOffset != 1:
			pathTime = tweenTime-(tweenTime * (1 - unitOffset))
		else: 
			pathTime = tweenTime
		$Tween.interpolate_property(path, 'unit_offset', unitOffset, 0 , pathTime,Tween.TRANS_LINEAR,0)
		$Tween.start()

func tween_stop():
	$Tween.stop_all()

func _on_Tween_tween_completed(object, key):
	self.queue_free()
	qwer = [object, key]
	

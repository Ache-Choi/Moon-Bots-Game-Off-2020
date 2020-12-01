extends Spatial

export (PackedScene) var copterBot

onready var pathFollow = $Path/PathFollow
onready var pathCont = $Path/PathFollow/path1Container
onready var tweenOne
onready var tweenTwo
onready var beginTimer = $beginTimer
onready var botOutTimer = $botOutTimer

onready var readyOut = false
var buggy

func _ready():
	beginTimer.wait_time = 1.5
	botOutTimer.wait_time = 3
#	buggy = gSignals.connect('copterBotOut', self, 'move_path_out')
	var newCurve = load('res://scenes/enemies/copterBot/copterPath01.tres').duplicate()
	$Path.curve = newCurve
	inst_tween()
	inst_copter(copterBot, pathCont)
	beginTimer.start()

func inst_tween():
	var tween1 = Tween.new()
	add_child(tween1)
	tween1.connect("tween_completed", self, '_on_Tween_tween_completed')
	tweenOne = tween1
	var tween2 = Tween.new()
	add_child(tween2)
	tween2.connect("tween_completed", self, '_on_Tween2_tween_completed')
	tweenTwo = tween2

func move_path(tweeNode):
	tweeNode.interpolate_property(pathFollow, 'unit_offset', 0, 0.5,2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tweeNode.start()

func move_path_out():
	tweenTwo.interpolate_property(pathFollow, 'unit_offset', pathFollow.unit_offset, 1,2,Tween.TRANS_QUAD,Tween.EASE_IN)
	tweenTwo.start()

func _on_Tween_tween_completed(object, key):
	if pathCont.get_child_count() > 0:
		pathCont.get_child(0).get_node('AnimationPlayer').play('open')
		gSignals.inst_copter_bot('cubeBot',pathCont.get_child(0).get_node('smallBot003').global_transform.origin)
	buggy = [object, key]
	botOutTimer.start()

func _on_Tween2_tween_completed(object, key):
	print(self.get_parent().name)
	self.get_parent().queue_free()
	buggy = [object, key]

func inst_copter(scene, cont):
	var c = scene.instance()
	c.translation = Vector3(.155,-0.969,0.034)
	c.rotation_degrees = Vector3(-3.419,-0.256,11.14)
	cont.add_child(c)

func _on_beginTimer_timeout():
	move_path(tweenOne)

func _on_botOutTimer_timeout():
	move_path_out()

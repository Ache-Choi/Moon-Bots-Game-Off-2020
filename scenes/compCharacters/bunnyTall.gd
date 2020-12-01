extends Spatial

export (Array, Color) var colorPal

onready var aPlayer = $tallBunny2/AnimationPlayer
onready var messagePanel = $messagePanel/AnimationPlayer
onready var meshBody =  $tallBunny2/mainPlayer001

onready var textTimer = $messagePanel/Timer
onready var timer = $Timer

func _ready():
	disabled_col(true)
	randomize()
	var randNum = floor(rand_range(0, colorPal.size()-1))
	if randNum < 0:
		randNum = 0
	color_change(colorPal[randNum])
	if self.get_node('../..').is_in_group('characterPath'):
		aPlayer.play("walk")
	timer.wait_time = 5
	timer.start()

func _on_Timer_timeout():
	disabled_col(false)

#msg pop up
func _on_compCharacter_area_entered(area):
	if area.name == 'playerArea':
		aPlayer.play("stand")
		self.get_node('../..').get_parent().tween_stop()
		messagePanel.play("popMessage")
		textTimer.start()
#msg hide
func _on_compCharacter_area_exited(area):
	if area.name == 'playerArea':
		var currPath = self.get_node('../..').get_parent().currentPath
		self.get_node('../..').get_parent().player_walk(currPath)
		aPlayer.play("walk")
		messagePanel.play("closeMessage")
		textTimer.stop()

func color_change(color):
	meshBody.get('mesh').get('surface_1/material').albedo_color = color

func disabled_col(torf):
	$StaticBody/CollisionShape.disabled = torf




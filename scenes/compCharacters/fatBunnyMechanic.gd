extends Spatial

onready var aPlayer = $fatBunny/AnimationPlayer
onready var messagePanelPlayer = $messagePanel/AnimationPlayer
onready var timer = $Timer

func _ready():
	disabled_col(true)
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
		$messagePanel._ready()
		messagePanelPlayer.play("popMessage")
		gVars.playerItemArrAcquired[3] = 1
		var s = preload('res://scenes/props/winSound.tscn').instance()
		add_child(s)
#msg hide
func _on_compCharacter_area_exited(area):
	if area.name == 'playerArea':
		var currPath = self.get_node('../..').get_parent().currentPath
		self.get_node('../..').get_parent().player_walk(currPath)
		aPlayer.play("walk")
		messagePanelPlayer.play("closeMessage")

func disabled_col(torf):
	$StaticBody/CollisionShape.disabled = torf




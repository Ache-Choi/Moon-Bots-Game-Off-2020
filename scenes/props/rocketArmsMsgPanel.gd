extends Spatial

export (String) var currentLocation

onready var textLabel = $Viewport/Label
onready var aniPlayer = $AnimationPlayer
onready var textPlayer = $textPlayer

onready var gotoMoonMsg = 'Ready to go to the moon?'
onready var gobackHomeMsg = 'Ready to go back home?'
var goToMoon = false


func _ready():
	$Timer.wait_time = 3

func set_message(strText):
	textLabel.text = strText


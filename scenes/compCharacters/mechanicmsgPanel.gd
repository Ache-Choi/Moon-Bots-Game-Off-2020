extends Spatial

onready var textLabel = $Viewport/Label
onready var aniPlayer = $AnimationPlayer

onready var msg1 = 'Hi, I am the mechanic, do you need to fix the Rocket Ship? Let me know when you have the parts'
onready var msg2 = 'Collect these three items: Rocket, Rocket Arms and the energy ball and let me know'
onready var msg3 = 'The rocket is ready to launch in the South Desert'

onready var textArr = [msg1, msg2]

onready var fourItems

func _ready():
	randomize()
	fourItems = 0
	var randNum = floor(rand_range(0,2))
	set_message(textArr[randNum])
	for i in gVars.playerItemArrAcquired:
		if i == 1:
			fourItems += 1
	if fourItems == 4:
		set_message(msg3)


func set_message(strText):
	textLabel.text = strText




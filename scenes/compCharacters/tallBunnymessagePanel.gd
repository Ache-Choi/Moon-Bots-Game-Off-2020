extends Spatial

onready var textLabel = $Viewport/Label
onready var aniPlayer = $AnimationPlayer
onready var textPlayer = $textPlayer

onready var saveTheWorldInfo1 = 'To destroy the Bots, you will need to collect 4 items. Rocket, Rocket Arms, Energy Ball and find the mechanic.'
onready var saveTheWorldInfo2 = 'If you have all four items, go to South Desert and the Rocket Ship will be ready to launch to the moon'
onready var saveTheWorldInfo3 = 'Destroy the main System on the Moon'
onready var saveTheWorldInfo4 = 'Our planet has been invaded by alien Bots.'

onready var textVarArr = [saveTheWorldInfo1,saveTheWorldInfo2,saveTheWorldInfo3,saveTheWorldInfo4]

onready var textMsgNum = 0

func _ready():
	set_message(saveTheWorldInfo1)
	$Timer.wait_time = 4

func set_message(strText):
	textLabel.text = strText
	
func _on_Timer_timeout():
	textPlayer.play("textFadeOut")
	yield(get_tree().create_timer(.3),"timeout")
	if textMsgNum == 3:
		textMsgNum = 0
	else:
		textMsgNum  += 1
	set_message(textVarArr[textMsgNum])
	textPlayer.play("textFadeIn")

func _on_textPlayer_animation_finished(anim_name):
	if anim_name == 'textFadeIn':
		pass

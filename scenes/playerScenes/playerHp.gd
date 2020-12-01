extends Spatial

onready var textP = $Viewport/TextureProgress
onready var tween = $Tween

func shoot_coolDown_bar(time):
	tween.interpolate_property(textP, 'value', 0, 100, time,Tween.TRANS_LINEAR,0)
	tween.start()

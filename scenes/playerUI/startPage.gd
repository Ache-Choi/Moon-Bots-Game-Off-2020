extends Control

onready var aniPlayer = $AnimationPlayer
onready var btnCont = $playSetBtns/btnContainer

func _ready():
	aniPlayer.play("openGame")

func _on_playBtn_button_up():
	inst_sound('click')
	aniPlayer.play("playPressed")
	btn_disabled(true)

func _on_settingsBtn_button_up():
	inst_sound('click')
	aniPlayer.play("settingsPressed")
	btn_disabled(true)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'playPressed':
		get_tree().change_scene('res://scenes/main.tscn')

func btn_disabled(torf):
	for i in btnCont.get_children():
		i.disabled = torf

func inst_sound(type):
	if gVars.soundOnOff:
		if type == 'click':
			var s = preload('res://scenes/props/clickSound.tscn').instance()
			add_child(s)
		else:
			var sc = preload('res://scenes/props/cancelSound.tscn').instance()
			add_child(sc)
	

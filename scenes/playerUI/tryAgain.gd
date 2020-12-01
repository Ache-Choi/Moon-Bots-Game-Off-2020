extends Control

onready var animPl = $AnimationPlayer

func _ready():
	disabled_btns(false)
	animPl.play("popIn")

func _on_oBtn_pressed():
	gVars.playerCurrentScene = gVars.lastSavedScene
	inst_sound('click')
	disabled_btns(true)
	animPl.play("popOut")
	get_tree().reload_current_scene()
	gVars.player = 'alive'
	gSignals.reset_player_translation(gVars.saveLoadPos)

func _on_xBtn_pressed():
	inst_sound('cancel')
	disabled_btns(true)
	animPl.play("popOut")
	get_tree().change_scene('res://scenes/playerUI/startPage.tscn')

func disabled_btns(torf):
	$container/oBtn.disabled = torf
	$container/xBtn.disabled = torf

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'popOut':
		self.queue_free()

func inst_sound(type):
	if gVars.soundOnOff:
		if type == 'click':
			var s = preload('res://scenes/props/clickSound.tscn').instance()
			add_child(s)
		else:
			var sc = preload('res://scenes/props/cancelSound.tscn').instance()
			add_child(sc)
	

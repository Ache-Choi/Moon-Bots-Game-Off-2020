extends Node2D

export (String) var type
onready var aniPlayer = $AnimationPlayer

func _ready():
	if type == 'hpPlus':
		$hpPlus.visible = true
		$bulletPlus.visible = false
	else:
		$hpPlus.visible = false
		$bulletPlus.visible = true
	aniPlayer.play("sideIn")

func _on_hpBtn_button_down():
	if gVars.coins > 500:
		gVars.coins -= 500
		gSignals.hp_purchase(10)
		aniPlayer.play("sideOut")
	else:
		aniPlayer.play("notEnough")
	enable_bts()
	saveLoad.save_data()

func _on_cancelHpBtn_button_down():
	enable_bts()
	aniPlayer.play("sideOut")

func _on_bulletBtn_button_down():
	if gVars.coins > 500:
		gVars.coins -= 500
		gSignals.bullet_purchase(10)
		aniPlayer.play("sideOut")
	else:
		aniPlayer.play("notEnough")
	enable_bts()
	saveLoad.save_data()

func _on_cancelBulletBtn_button_down():
	enable_bts()
	aniPlayer.play("sideOut")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'sideOut':
		self.queue_free()

func enable_bts():
	if self.get_parent().name == 'playerUI':
		self.get_parent().disabled_btns(false)
		self.get_parent().pauseTrigger = true

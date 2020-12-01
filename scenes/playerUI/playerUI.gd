extends Control

export (PackedScene) var purchasePanel

onready var tween = $Tween
onready var textProgress = $TextureProgress
onready var hpValue = 100
onready var hpMaxValue = 100
onready var sidePanelAnimP = $sidePanel

onready var sideHpCount      = $Control/sideContCounts/hp
onready var expCount     = $Control/sideContCounts/exp
onready var bulletDamage = $Control/sideContCounts/bulletDamage
onready var sideCoinCount    = $Control/sideContCounts/coins
onready var itemCardCont = $Control/needItems
onready var sceneText    = $ColorRect/Label
onready var animPlayer   = $sceneChangePlayer
onready var coinCountMain =  $coinCount
onready var openSceneFadeOut = $AnimationPlayer

onready var sidePanel = false
var bbbgg
var pauseTrigger = true

func _ready():
	saveLoad.load_data()
	update_player_data()
	openSceneFadeOut.play("fadeOut")
	textProgress.tint_progress = '00ff30'
	bbbgg = gSignals.connect('hpPurchase', self, 'purchase_hp')
	bbbgg = gSignals.connect('bulletPurchase', self, 'purchase_bullet')
	bbbgg = gSignals.connect('theMoonTransition', self, 'transition_scene')


func update_player_data():
	textProgress.max_value = gVars.playerMaxHp
	textProgress.value = gVars.playerCurrHp
	coinCountMain.text = str(gVars.coins)
	textProgress.rect_scale.x = gVars.playerHpBarX

func _process(delta):
	bbbgg = delta
	if Input.is_action_just_pressed("pause") and pauseTrigger:
		get_tree().paused = not get_tree().paused

	if get_tree().paused and sidePanel == false:
		update_side_panel()
		sidePanel = true
		sidePanelAnimP.play("sidePanel")
	elif get_tree().paused == false  and sidePanel == true:
		sidePanel = false
		sidePanelAnimP.play("sidePanelHide")

func player_hp(damagePts):
	var amountTo = textProgress.value - damagePts
	if amountTo < 0:
		amountTo = 0
	tween.interpolate_property(textProgress, 'value', textProgress.value, amountTo, .1, Tween.TRANS_QUAD,0)
	tween.start()
	var twoThirds = ((textProgress.max_value/3)*2)
	var third = textProgress.max_value/3
	if textProgress.value > twoThirds:
		textProgress.tint_progress = '00ff30'
	elif textProgress.value > third and textProgress.value <= twoThirds:
		textProgress.tint_progress = 'fff300'
	else:
		textProgress.tint_progress = 'ff0000'
	gVars.playerCurrHp = textProgress.value
	gVars.playerMaxHp = textProgress.max_value

func _on_Tween_tween_completed(object, key):
	if textProgress.value <= 0:
		print('dead player ui scene')
		gVars.player = 'dead'
		self.get_parent().aniplayer.play('dead')
	bbbgg = [object, key]

func update_side_panel():
	sideHpCount.text = str(gVars.playerMaxHp,'/',gVars.playerMaxHp)
	expCount.text = str(gVars.playerExp)
	bulletDamage.text = str(gVars.bulletDamage)
	sideCoinCount.text = str(gVars.coins)
	card_opacity_change()

func card_opacity_change():
	for i in gVars.playerItemArrAcquired.size():
		if gVars.playerItemArrAcquired[i] == 1:
			itemCardCont.get_child(i).modulate = 'ffffff'

func _on_plusHp_button_down():
	var p = purchasePanel.instance()
	p.type = 'hpPlus'
	p.position = $Control/plusHp.rect_global_position
	add_child(p)
	disabled_btns(true)
	pauseTrigger = false

func _on_plusBullet_button_down():
	var p = purchasePanel.instance()
	p.type = 'bulletPlus'
	p.position = $Control/plusBullet.rect_global_position
	add_child(p)
	disabled_btns(true)
	pauseTrigger = false

func purchase_hp(amount):
	gVars.playerMaxHp += amount
	textProgress.max_value = gVars.playerMaxHp
	textProgress.value = textProgress.max_value
	gVars.playerCurrHp = gVars.playerMaxHp
	gVars.playerHpBarX += .03
	textProgress.rect_scale.x = gVars.playerHpBarX
	update_side_panel()
	update_player_data()
	saveLoad.save_data()

func purchase_bullet(amount):
	gVars.bulletDamage += amount
	update_side_panel()
	
func disabled_btns(torf):
	$Control/plusHp.disabled = torf
	$Control/plusBullet.disabled = torf

func transition_scene(text):
	sceneText.text = str(text)
	animPlayer.play("solidBlackFadeIn")

func _on_sceneChangePlayer_animation_finished(anim_name):
	if anim_name == 'solidBlackFadeIn':
		yield(get_tree().create_timer(2.2),"timeout")
		animPlayer.play("solidBlackFadeOut")


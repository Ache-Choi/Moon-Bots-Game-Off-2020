extends Node2D

onready var musicCheck = $check
onready var soundCheck = $check2
onready var musicOnPos = $musicOn
onready var musicOffPos = $musicOff
onready var soundOnPos = $soundOn
onready var soundOffPos = $soundOff

onready var btnCont = $btnCont

func _ready():
	btn_disabled(false)

func _on_musicOnBtn_pressed():
	inst_sound('click')
	if musicCheck.position != musicOnPos.position:
		musicCheck.position = musicOnPos.position
		gVars.musicOnOff = true

func _on_musicOffBtn_pressed():
	inst_sound('click')
	if musicCheck.position != musicOffPos.position:
		musicCheck.position = musicOffPos.position
		gVars.musicOnOff =  false

func _on_soundOnBtn_pressed():
	inst_sound('click')
	if soundCheck.position != soundOnPos.position:
		soundCheck.position = soundOnPos.position
		gVars.soundOnOff =  true

func _on_soundOffBtn_pressed():
	inst_sound('click')
	if soundCheck.position != soundOffPos.position:
		soundCheck.position = soundOffPos.position
		gVars.soundOnOff =  false

func _on_xBtn_pressed():
	inst_sound('cancel')
	saveLoad.save_data()
	btn_disabled(true)
	self.get_parent().aniPlayer.play_backwards('settingsPressed')
	get_parent().btn_disabled(false)

func btn_disabled(torf):
	for i in btnCont.get_children():
		i.disabled = torf


func inst_sound(type):
	if type == 'click':
		var s = preload('res://scenes/props/clickSound.tscn').instance()
		add_child(s)
	else:
		var sc = preload('res://scenes/props/cancelSound.tscn').instance()
		add_child(sc)
	

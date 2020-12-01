extends Node

export (String) var soundType
export (String) var soundName
export (bool) var loopOn
export (int) var volu

onready var audioSt = $AudioStreamPlayer
#
#onready var soundUiArr = [
#						'res://assets/soundMusic/sounds/menu-click.wav',
#						'res://assets/soundMusic/sounds/cancelSound.ogg'
#]
#
#onready var soundUiArrName = [
#						'click',
#						'cancel',
#]

onready var soundPlayerArr = [
						'res://assets/soundMusic/sounds/playerJump.wav',
						'res://assets/soundMusic/sounds/playerFire2.wav',
						'res://assets/soundMusic/sounds/playerBulletPuff.wav',
						'res://assets/soundMusic/sounds/coin.wav',
						'res://assets/soundMusic/sounds/hpUp.wav'
]

onready var soundPlayerArrName = [
						'jump',
						'fire',
						'hitObstacle',
						'coinGrab',
						'hpUp',
						'gotHit'
]
##enemy sounds
#onready var bossHelperSoundArr = [
#						'res://assets/soundMusic/sounds/stomp.ogg',
#						'res://assets/soundMusic/sounds/bossHelperHammerHit.wav',
#						'hitObstacle',
#]
#
#onready var bossHelperSoundArrName = [
#						'stomp',
#						'hammerHit',
#						'hammerSideHit',
#]
#
#onready var enemiesSoundArr = [
#						'res://assets/soundMusic/sounds/smalCubePopUp.wav',
#						'res://assets/soundMusic/sounds/smallCubeLaser.wav',
#
#						'res://assets/soundMusic/sounds/finalBossBlast.wav',
#
#						'res://assets/soundMusic/sounds/quadLegShoot.wav',
#						'res://assets/soundMusic/sounds/quadLegIncomingWhistle.wav'
#
#]
#
#onready var enemiesSoundArrName = [
#						'smallCubeSearch',
#						'smallCubeLaser',
#
#						'finalBossBlast',
#
#						'quadLegShot',
#						'quadLegIncomeWhistle'
#
#]

func _ready():
#	if soundType == 'ui':
#		self.set_ui_audio(soundName,loopOn,volu)
	if soundType == 'player':
		self.set_player_audio(soundName,loopOn,volu)
#	elif soundType == 'bossHelper':
#		self.set_bossHelper_audio(soundName,loopOn,volu)
#	elif soundType == 'enemies':
#		self.set_enemies_audio(soundName,loopOn,volu)

#
#
#func set_ui_audio(soundName,loopSet,volu):
#	var path
#	for i in soundUiArrName.size():
#		if soundName == soundUiArrName[i]:
#			path = soundUiArr[i]
#
#	if audioSt.stream is AudioStreamOGGVorbis:
#		audioSt.stream.loop_mode = loopSet
#	else:
#		audioSt.stream = load(path)
#
#	if soundName == 'click':
#		audioSt.volume_db = 0
#		audioSt.pitch_scale = 0.5
#	else:
#		audioSt.pitch_scale = 1
#		audioSt.volume_db = volu
#	audioSt.play()

func set_player_audio(soundName,loopSet,volu):
	var path
	for i in soundPlayerArrName.size():
		if soundName == soundPlayerArrName[i]:
			path = soundPlayerArr[i]

	audioSt.stream = load(path)

	if audioSt.stream is AudioStreamOGGVorbis:
		audioSt.stream.loop = bool(loopSet)

	if soundName == 'fire':
		audioSt.volume_db = -15
		audioSt.pitch_scale = 2.2
	elif soundName == 'jump':
		audioSt.volume_db = -15
		audioSt.pitch_scale = .77
	elif soundName == 'hitObstacle':
		audioSt.volume_db = -20
		audioSt.pitch_scale = .5
	elif soundName == 'coinGrab':
		audioSt.volume_db = -10
		audioSt.pitch_scale = .5
	else:
		audioSt.pitch_scale = 1
		audioSt.volume_db = volu

	audioSt.play()
#
#func set_bossHelper_audio(soundName,loopSet,volu):
#	var path
#	for i in bossHelperSoundArrName.size():
#		if soundName == bossHelperSoundArrName[i]:
#			path = bossHelperSoundArr[i]
#
#	audioSt.stream = load(path)
#
#	if audioSt.stream is AudioStreamOGGVorbis:
#		audioSt.stream.loop = bool(loopSet)
#
#	if soundName == 'hammerHit':
#		audioSt.pitch_scale = 1.18
#		audioSt.volume_db = -10
#	elif soundName == 'stomp':
#		audioSt.pitch_scale = 1.2
#		audioSt.volume_db = -8
#	else:
#		audioSt.pitch_scale = 1
#		audioSt.volume_db = volu
#
#	audioSt.play()
#
#func set_enemies_audio(soundName,loopSet,volu):
#	var path
#	for i in enemiesSoundArrName.size():
#		if soundName == enemiesSoundArrName[i]:
#			path = enemiesSoundArr[i]
#
#	audioSt.stream = load(path)
#	if audioSt.stream is AudioStreamOGGVorbis:
#		audioSt.stream.loop = bool(loopSet)
#
#	if soundName == 'quadLegIncomeWhistle':
#		audioSt.volume_db = -10
#		audioSt.pitch_scale = .82
#	elif soundName == 'smallCubeSearch':
#		audioSt.volume_db = -15
#		audioSt.pitch_scale = 1
#	else:
#		audioSt.volume_db = volu
#		audioSt.pitch_scale = 1
#
#	audioSt.play()
#
func _on_AudioStreamPlayer_finished():
	self.queue_free()

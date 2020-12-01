extends Node

onready var playerGlobalPos = Vector3.ZERO
onready var playerRot = Vector3.ZERO
onready var playerCurrentScene = String()

onready var playerMaxHp
onready var playerCurrHp
onready var playerHpBarX
onready var playerExp
onready var bulletDamage
onready var coins

onready var musicOnOff 
onready var soundOnOff

onready var playerItemArr = ['Rocket', 'Rocket Arms', 'Energy Ball', 'Mechanic']
onready var playerItemArrAcquired = [0,0,0,0]

onready var saveLoadPos = Vector3(-38.6,5.45,-10.93)
onready var saveLoadRot = Vector3(0,-180,0)

onready var player =  'alive'
onready var lastSavedScene 

func _ready():
	playerMaxHp   = 100
	playerCurrHp  = 100
	playerHpBarX  = 0.5
	playerExp     = 0
	bulletDamage  = 50
	coins         = 0
	playerCurrentScene = 'cityScene'
	lastSavedScene = 'cityScene'


# SETTINGS
	musicOnOff = true
	soundOnOff = true

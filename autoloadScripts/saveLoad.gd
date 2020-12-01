extends Node
#
const SAVE_PATH = 'res://save.json'
#const SAVE_PATH = 'user://saveFile.json'

var default_data = {
			 player = {
						playerMaxHp          = 0,
						playerCurrHp         = 0,
						playerHpBarX         = 0,
						playerExp            = 0,
						bulletDamage         = 0,
						coins                = 0,
						playerCurrentScene   = '',
						lastSavedScene       = '',
						playerItemArrAcquired = [0,0,0,0],
						saveLoadPos          = [0,0,0],
						saveLoadRot          = [0,-180,0]
							 },
			  settingsData = {
						musicOnOff = true,
						soundOnOff = true
							 }
				   }

var player_data = {}

func save_data():
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)

	save_data_function()

	save_file.store_line(to_json(player_data))
	save_file.close()


func save_data_function():
	for i in player_data:
		for j in player_data[i]:
###  PLAYER DATA
			if j == 'playerMaxHp':
				player_data[i][j] = gVars.playerMaxHp
			if j == 'playerCurrHp':
				player_data[i][j] = gVars.playerCurrHp
			if j == 'playerHpBarX':
				player_data[i][j] = gVars.playerHpBarX
			if j == 'playerExp':
				player_data[i][j] = gVars.playerExp
			if j == 'bulletDamage':
				player_data[i][j] = gVars.bulletDamage
			if j == 'coins':
				player_data[i][j] = gVars.coins
			if j == 'playerCurrentScene':
				player_data[i][j] = gVars.playerCurrentScene
			if j == 'playerCurrentScene':
				player_data[i][j] = gVars.playerCurrentScene
			if j == 'lastSavedScene':
				player_data[i][j] = gVars.lastSavedScene
			if j == 'saveLoadPos':
				player_data[i][j][0] = gVars.saveLoadPos.x
				player_data[i][j][1] = gVars.saveLoadPos.y
				player_data[i][j][2] = gVars.saveLoadPos.z
			if j == 'saveLoadRot':
				player_data[i][j][0] = gVars.saveLoadRot.x
				player_data[i][j][1] = gVars.saveLoadRot.y
				player_data[i][j][2] = gVars.saveLoadRot.z

###  SETTINGS DATA
			if j == 'musicOnOff':
				player_data[i][j] = gVars.musicOnOff
			if j == 'soundOnOff':
				player_data[i][j] = gVars.soundOnOff


func load_data():
	var load_file = File.new()
	if not load_file.file_exists(SAVE_PATH):
		reset_data()
		return

	load_file.open(SAVE_PATH, load_file.READ)
	player_data = parse_json(load_file.get_as_text())
	load_data_function()

	load_file.close()

func reset_data():
	player_data = default_data.duplicate(true)

func load_data_function():
	for i in player_data:
		for j in player_data[i]:
###  PLAYER DATA
			if j == 'playerMaxHp':
				gVars.playerMaxHp = player_data[i][j]
			if j == 'playerCurrHp':
				gVars.playerCurrHp = player_data[i][j]
			if j == 'playerHpBarX':
				gVars.playerHpBarX = player_data[i][j]
			if j == 'playerExp':
				gVars.playerExp = player_data[i][j]
			if j == 'bulletDamage':
				gVars.bulletDamage = player_data[i][j]
			if j == 'coins':
				gVars.coins = int(player_data[i][j])
			if j == 'playerCurrentScene':
				gVars.playerCurrentScene = player_data[i][j]
			if j == 'playerItemArrAcquired':
				gVars.playerItemArrAcquired = player_data[i][j]
			if j == 'lastSavedScene':
				gVars.lastSavedScene = player_data[i][j]
			if j == 'saveLoadPos':
				gVars.saveLoadPos.x = float(player_data[i][j][0])
				gVars.saveLoadPos.y = float(player_data[i][j][1])
				gVars.saveLoadPos.z = float(player_data[i][j][2])
			if j == 'saveLoadRot':
				var posArr = str(player_data[i][j]).split(',')
				gVars.saveLoadRot.x = float(player_data[i][j][0])
				gVars.saveLoadRot.y = float(player_data[i][j][1])
				gVars.saveLoadRot.z = float(player_data[i][j][2])

####  SETTINGS DATA
			if j == 'musicOnOff':
				gVars.musicOnOff = player_data[i][j]
			if j == 'soundOnOff':
				gVars.soundOnOff = player_data[i][j]



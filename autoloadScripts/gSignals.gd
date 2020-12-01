extends Node

signal shootGunBullet
func shoot_gun_bullet(from, to, time, rotDeg):
	emit_signal('shootGunBullet', from, to, time, rotDeg)

signal bulletExplosion
func bullet_explostion(pos):
	emit_signal('bulletExplosion', pos)

signal instCopterBot
func inst_copter_bot(scene, pos):
	emit_signal('instCopterBot', scene, pos )

signal copterBotOut
func copter_bot_out():
	emit_signal('copterBotOut')

signal spawnCoins
func spawn_coins(count,pos):
	emit_signal("spawnCoins", count, pos)

signal spawnHpPlus
func spawn_hp_plus(count,pos):
	emit_signal("spawnHpPlus", count, pos)

signal enemExplosion
func enemy_explosion(color,pos, type):
	emit_signal("enemExplosion", color,pos, type)

signal stopPlayerMov
func stop_player_mov():
	emit_signal("stopPlayerMov")

signal goToScene
func go_to_scene(sceneName):
	emit_signal('goToScene', sceneName)

signal spawnEnemies
func spawn_enemies(type, pos, whichScene, rot):
	emit_signal("spawnEnemies", type, pos, whichScene,rot)

signal spawnBoxes
func spawn_boxes(pos):
	emit_signal("spawnBoxes", pos)

signal enemBullet
func enemy_bullet(type, fromPos, toPos):
	emit_signal("enemBullet",type, fromPos, toPos)
	
signal enemBulletExplosion
func enem_bullet_explosion(pos):
	emit_signal('enemBulletExplosion', pos)
	
signal enemQuadBulletExplosion
func enem_quad_bullet_explosion(pos):
	emit_signal('enemQuadBulletExplosion', pos)
	
signal hammerSideExplosion
func hammer_side_explosion(pos):
	emit_signal('hammerSideExplosion', pos)

signal instCompCharacter
func inst_comp_character(num):
	emit_signal("instCompCharacter",num)

signal hpPurchase
func hp_purchase(amount):
	emit_signal("hpPurchase", amount)

signal bulletPurchase
func bullet_purchase(amount):
	emit_signal("bulletPurchase", amount)

signal hammerEffect
func hammer_effect(pos, type):
	emit_signal('hammerEffect', pos ,type)

signal theMoonTransition
func moon_transition(text):
	emit_signal("theMoonTransition", text)

signal onRocketFX
func on_rocket_fx(pos):
	emit_signal("onRocketFX", pos)

signal resetPlayerPos
func reset_player_translation(pos):
	emit_signal("resetPlayerPos", pos)

signal lightChange
func change_light(energy):
	emit_signal("lightChange", energy)








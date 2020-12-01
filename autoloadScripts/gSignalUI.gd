extends Node

signal tryAgain
func  try_again():
	emit_signal("tryAgain")

#signal bgMusicInst
#func  bg_music_inst():
#	emit_signal("bgMusicInst")
 
#signal soundInst
#func  sound_inst(type, soundName, loopSet, volu):
#	emit_signal("soundInst",type , soundName,loopSet,volu)

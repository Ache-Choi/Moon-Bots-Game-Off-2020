extends Node


func inst_sounds(type,soundName,loopSet,volu):
	if gVars.soundOnOff == true:
		var s = preload('res://scenes/soundMusic/playerSound.tscn').instance()
		s.soundType = type
		s.soundName = soundName
		s.loopOn = loopSet
		s.volu = volu
		self.add_child(s)
		

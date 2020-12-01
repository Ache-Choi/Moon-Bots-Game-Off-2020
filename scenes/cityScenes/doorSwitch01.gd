extends Spatial

onready var switchOnOff = true
onready var doorAnimPlayer = get_node('../..').get_node("doorAnimPlayer")

func _on_Area_area_entered(area):
	if area.is_in_group('playerGunBullet') and switchOnOff:
		switchOnOff = false
		color_change('14ff00')
		
		var selfNum1 = str(self.name[-1])
		var selfNum2 = str(self.name[-2])
		var strname =  str("door%s"%selfNum2,selfNum1)
		doorAnimPlayer.play(strname)
	elif area.is_in_group('playerGunBullet') and switchOnOff == false:
		switchOnOff = true
		color_change('ff0000')
		var selfNum1 = str(self.name[-1])
		var selfNum2 = str(self.name[-2])
		var strname =  str("door%s"%selfNum2,selfNum1)
		doorAnimPlayer.play_backwards(strname)


func color_change(setCol):
	$Cube048.get('mesh').get('surface_2/material').albedo_color = setCol

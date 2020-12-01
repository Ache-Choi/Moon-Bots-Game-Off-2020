extends Spatial

export (PackedScene) var pathFollow01

var dbdbdb

func _ready():
	inst_path(pathFollow01)

func inst_path(scene):
	var p = scene.instance()
	self.add_child(p)

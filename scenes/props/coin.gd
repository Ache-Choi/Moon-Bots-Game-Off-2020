extends RigidBody

var dbdb

func _ready():
	randomize()
	self.set('linear_velocity', Vector3(float(rand_range(-10,10)),float(rand_range(15,25)),float(rand_range(-10,10))))
	self.rotation_degrees.y = rand_range(0,360)
	set_physics_process(false)
	
func _physics_process(delta):
	self.global_transform.origin += (gVars.playerGlobalPos - self.global_transform.origin + Vector3(0,1.7,0)) * delta * 5

func _on_Area_body_entered(body):
	if body.name == 'playerMesh':
		set_physics_process(true)

func tween_motion(from, to):
	$Tween.interpolate_property(self,'translation',from, to, .3,Tween.TRANS_QUART,Tween.EASE_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	dbdb = [object, key]
	$coin2.playing = true
	self.queue_free()

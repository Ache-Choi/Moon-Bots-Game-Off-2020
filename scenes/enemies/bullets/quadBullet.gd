extends Spatial

onready var bulletTravelTime = $Timer
var quadBulletDamage = 20
var qwer


func _ready():
	bulletTravelTime.wait_time = 1
	bulletTravelTime.start()
	$AudioStreamPlayer3D.playing = true

func _physics_process(delta):
	self.translation += transform.basis.z * 1
	qwer = delta

func _on_Area_body_entered(body):
	if !body.is_in_group('quadBot'):
		self.queue_free()
		gSignals.enem_quad_bullet_explosion(self.global_transform.origin)
	if body.name == 'playerMesh':
		body.got_hit(quadBulletDamage)
#	print(body.name)

func _on_Timer_timeout():
	self.queue_free()

	

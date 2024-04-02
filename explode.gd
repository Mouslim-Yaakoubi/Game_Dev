extends Node2D

func _physics_process(_delta):
	$explode.play("death")
	if $explode.frame == 10:
		self.queue_free()

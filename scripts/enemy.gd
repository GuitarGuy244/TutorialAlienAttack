extends Area2D

signal died

@export var speed = 300

#@onready var visible_notifier = $VisibleNotifier

#func _ready():
#	#visible_notifier.connect("screen_exited", _on_screen_exited)
#	pass

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	global_position.x += -speed*delta
	
#func _on_screen_exited():
#	queue_free()

func die():
	queue_free()
	emit_signal("died")


func _on_body_entered(body):
	body.take_damage()
	die()

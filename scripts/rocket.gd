extends Area2D

@export var speed = 500

@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.connect("screen_exited", _on_screen_exited)

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	#global_position.x = global_position.x + speed
	global_position.x += speed*delta
	# 120px @ 120fps 1
	# 120px @ 60fps 2
	# 120px @ 30fps 4
	# 120px @ 10fps 12
func _on_screen_exited():
	queue_free()


func _on_area_entered(area):
	queue_free()
	area.die()

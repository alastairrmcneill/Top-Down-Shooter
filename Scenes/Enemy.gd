extends KinematicBody2D
class_name Enemy

var moveSpeed = 1
var direction = Vector2()
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	
	
	direction = player.position - position
	velocity = direction * moveSpeed
	if velocity.length() < 150:
		velocity = velocity.normalized()*150
	
	move_and_slide(velocity)
	look_at(player.position)
	
	


func _on_Hitbox_body_entered(body):
	if "Bullet" in body.name:
		body.queue_free()
		queue_free()

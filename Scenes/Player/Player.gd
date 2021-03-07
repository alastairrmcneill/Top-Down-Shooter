extends KinematicBody2D

var moveSpeed = 500
var bulletSpeed = 1000
var bullet = preload("res://Scenes/Bullet/Bullet.tscn")

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		fire()

func _physics_process(delta):
	var direction = Vector2()
	
	if Input.is_action_pressed("up"):
		direction.y -= 1
		
	if Input.is_action_pressed("down"):
		direction.y += 1
		
	if Input.is_action_pressed("left"):
		direction.x -= 1
		
	if Input.is_action_pressed("right"):
		direction.x += 1
		
	direction = direction.normalized()
	move_and_slide(direction * moveSpeed)
	
	look_at(get_global_mouse_position())


func fire():
	var bulletInstance = bullet.instance()
	bulletInstance.position = position
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(rotation))
	
	get_tree().get_root().call_deferred("add_child", bulletInstance)
	
	
func kill():
	get_tree().reload_current_scene()


func _on_Hitbox_body_entered(body):
	if body is Enemy:
		kill()


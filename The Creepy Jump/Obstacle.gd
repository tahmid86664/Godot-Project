extends Area2D

var obstacles_types = ["bomb"]
var velocity = Vector2()
var boundary = Vector2(1,0)

var can_jump = false

func _ready():
	$AnimatedSprite.play("bomb")
	pass # Replace with function body.

#func _process(delta):
#	_jump()
#	pass
	
#func _jump():
#	var temp_position = position
#	if can_jump:
#		velocity.x = 1
#		velocity.y = -1
#		print("can jump")
#		can_jump = false
#	position += velocity
#	yield(get_tree().create_timer(0.5), "timeout")
##	position -= velocity
#	position.y = temp_position.y
##	if position < boundary:
##		position.y = temp_position.y
##		can_jump = false
#	pass


func _on_Visibility_screen_exited():
	queue_free()
	pass # Replace with function body.

func _clear_all():
	queue_free()


func _on_Obstacle_body_entered(body):
#	if "Deck" in body.name:
#		can_jump = true
#		velocity = Vector2()
#		print("in deck")
	if "Player" in body.name:
		can_jump = false
		$AnimatedSprite.play("explosion")
		body.dead()
		print("yes player")
	pass # Replace with function body.

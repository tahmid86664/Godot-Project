extends Area2D

func _ready():
	$AnimatedSprite.play("knife")
	
func _clear_all():
	queue_free()
	



func _on_Visibility_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Weapon_body_entered(body):
	if "Player" in body.name:
		Global.knife_number += 1
		queue_free()
	pass # Replace with function body.

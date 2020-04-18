extends Area2D

signal hit_coin

func _ready():
	$AnimatedSprite.play("coin1")
	pass # Replace with function body.
	


func _on_Visibility_screen_exited():
	queue_free()
	pass # Replace with function body.
	
func _clear_all():
	queue_free()



func _on_Coin_body_entered(body):
	if "Player" in body.name:
		emit_signal("hit_coin")
		#connect("hit_signal", self, "_update_score()")
		#yield(get_tree().create_timer(0.4), "timeout")
		queue_free()
		
	pass # Replace with function body.

func _update_score():
	Global.score += 1
	pass

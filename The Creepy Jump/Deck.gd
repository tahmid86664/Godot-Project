extends StaticBody2D

var deck_types = ["normal"]

func _ready():
	$AnimatedSprite.play(deck_types[0])
	set_process(true)
	pass # Replace with function body.

func _start(pos):
	position = pos


func _on_Visibility_screen_exited():
	queue_free()
	pass # Replace with function body.
	
func _clear_all():
	queue_free()
	

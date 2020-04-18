extends Area2D

var play_again = false

func _ready():
	if Global.level == 1:
		$AnimatedSprite.play("girl1_1")
		$Message.play("help")
	if Global.level == 2:
		$AnimatedSprite.play("girl2_1")
		$Message.play("help")
	if Global.level == 3:
		$AnimatedSprite.play("girl3_1")
		$Message.play("help")
	hide()
	pass # Replace with function body.

func _clear_all():
	queue_free()

func _show():
	show()


func _on_People_body_entered(body):
	if "Player" in body.name and Global.level == 1:
		# I have to move the girl1_2 animation cause without changing position it will move upper little bit because of the size of image
		if Global.knife_number >= Global.LEVEL_ONE_KNIFE_NEED:
			$AnimatedSprite.position.y += 10
			$AnimatedSprite.play("girl1_2")
			$Message.play("greeting")
			Global.score += Global.EVERY_SAVE_SCORE
			Global.knife_number -= Global.LEVEL_ONE_KNIFE_NEED
			yield(get_tree().create_timer(1.5), "timeout")
			level_up()
			print(Global.level)
		else:
			$Message.play("knife_need")
			play_again = true
	elif "Player" in body.name and Global.level == 2:
		# I have to move the girl1_2 animation cause without changing position it will move upper little bit because of the size of image
		if Global.knife_number >= Global.LEVEL_TWO_KNIFE_NEED:
			$AnimatedSprite.position.y += 10
			$AnimatedSprite.play("girl2_2")
			$Message.play("greeting")
			Global.score += Global.EVERY_SAVE_SCORE
			Global.knife_number -= Global.LEVEL_TWO_KNIFE_NEED
			yield(get_tree().create_timer(1.5), "timeout")
			level_up()
			print(Global.level)
		else:
			$Message.play("knife_need")
			play_again = true
	elif "Player" in body.name and Global.level == 3:
		# I have to move the girl1_2 animation cause without changing position it will move upper little bit because of the size of image
		if Global.knife_number >= Global.LEVEL_THREE_KNIFE_NEED:
			$AnimatedSprite.position.y += 10
			$AnimatedSprite.play("girl3_2")
			$Message.play("greeting")
			Global.score += Global.EVERY_SAVE_SCORE
			Global.knife_number -= Global.LEVEL_THREE_KNIFE_NEED
			yield(get_tree().create_timer(1.5), "timeout")
			$Message.play("marry")
			yield(get_tree().create_timer(1.5), "timeout")
			Global.show_final_player_msg = true
			# now game should be finished
			print(Global.level)
		else:
			$Message.play("knife_need")
			play_again = true
	pass # Replace with function body.



func _on_People_body_exited(body):
	if "Player" in body.name and Global.level == 1 and play_again:
		$AnimatedSprite.play("girl1_1")
		$Message.play("help")
	if "Player" in body.name and Global.level == 2 and play_again:
		$AnimatedSprite.play("girl2_1")
		$Message.play("help")
	if "Player" in body.name and Global.level == 3 and play_again:
		$AnimatedSprite.play("girl3_1")
		$Message.play("help")
	pass # Replace with function body.

func level_up():
	if Global.level_up == false:
		Global.level += 1
		Global.level_up = true

extends CanvasLayer

signal start_game

func _ready():
	pass # Replace with function body.

func _show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_StartButton_pressed():
	$ColorRect.hide()
	$InstructionButton.hide()
	$HighScoreLabel.hide()
	$PlayerScoreLabel.hide()
	$StartButton.hide()
	emit_signal("start_game")
	
	_show_message("Get\nReady")
	
	yield(get_tree().create_timer(1), "timeout")
	$ScoreLabel.show()
	$Knife.show()
	$KnifeLabel.show()
	#yield(get_tree().create_timer(1), "timeout")
	#emit_signal("game_over")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	pass # Replace with function body.
	
func _game_over_show():
	$ScoreLabel.hide()
	$Knife.show()
	$KnifeLabel.show()
	#yield(get_tree().create_timer(0.5), "timeout")
	_show_message("Game\nOver")
	yield($MessageTimer, "timeout")
	$ColorRect.show()
	$MessageLabel.text = "The Creepy\nJump!!!"
	$MessageLabel.show()
	$MessageTimer.stop()
	
	yield(get_tree().create_timer(0.5), "timeout")
	$HighScoreLabel.show()
	$PlayerScoreLabel.show()
	$StartButton.show()
	


func _on_HUD_game_over():
	_game_over_show()
	pass # Replace with function body.
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func set_high_score(high_score):
	$HighScoreLabel.text = "High Score: " + str(high_score)
	
func set_final_score(score):
	$PlayerScoreLabel.text = "Your Score: " + str(score)
	
func _update_knife(knife_number):
	$KnifeLabel.text = "×" + str(knife_number)
	


func _on_InstructionButton_pressed():
	$MessageLabel.hide()
	$HighScoreLabel.hide()
	$PlayerScoreLabel.hide()
	$ScoreLabel.hide()
	$StartButton.hide()
	$Knife.hide()
	$KnifeLabel.hide()
	$FinishMessage.hide()
	$InstructionButton.hide()
	
	$InstructionPanel.show()


func _on_Button_pressed():
	$MessageLabel.show()
	$HighScoreLabel.show()
	$PlayerScoreLabel.show()
	$ScoreLabel.hide()
	$StartButton.show()
	$Knife.hide()
	$KnifeLabel.hide()
	$FinishMessage.hide()
	$InstructionButton.show()
	
	$InstructionPanel.hide()

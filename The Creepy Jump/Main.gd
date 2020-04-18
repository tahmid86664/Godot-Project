extends Node

export (PackedScene) var Deck
var width
var deck_limit = -100
const MAX_DECK_DIF = 200
const MIN_DECK_DIF = 110
#var score = 0
var high_score = 0
#var count_deck_num = 0
#const MAX_DECK_NUM = 10

#===================obstacles================
export (PackedScene) var Obstacle
var deck_position_where_obs
var is_obstacle_showing = false
var temp_obs_position

#===================coin================
export (PackedScene) var Coin
var is_coin_showing = false

#===================people===============
export (PackedScene) var People
#export (NodePath) var People
var people
var is_people_showing = false
signal level_up


#====================weapon variable=============
export (PackedScene) var Weapon
var is_weapon_showing = false

func _ready():
	randomize()
#	people = get_node(People)
	set_process(true)



func new_game():
	
	#====================First deck base add=================
	var deck = Deck.instance()
	add_child(deck)
	#===============================================

	#==========Position setting when start=========
	$Player._start($PlayerPosition.position)
	$Camera._start($PlayerPosition.position)
	$HUD.update_score(Global.score)
	#===============================================
	
	$GameOver.stop()
	$NewGame.play()
	#=======all variable initializing when start=========
	Global.is_control_enable = true
	Global.show_final_player_msg = false
	Global.score = 0
	Global.level = 1
	Global.knife_number = 0
	deck_limit = -100
	Global.count_deck_num = 0
	Global.level_up = false
	is_obstacle_showing = true
	is_coin_showing = true
	is_weapon_showing = true
	is_people_showing = false
	#===============================================
	
	#==========all timers start when start=========
	$DeckTimer.start()
	$ObstacleTimer.start()
	$ScoreTimer.start()
	$CoinTimer.start()
	$LevelUpTimer.start()
	$KnifeTimer.start()
	$KnifeCount.start()
	#===============================================



func game_over():
	Global.is_control_enable = false
	$ScoreTimer.stop()
	$DeckTimer.stop()
	$ObstacleTimer.stop()
	$CoinTimer.stop()
	$LevelUpTimer.stop()
	$KnifeTimer.stop()
	$KnifeCount.stop()
	
	if Global.score > high_score:
		high_score = Global.score
		$HUD.set_high_score(high_score)
	$HUD.set_final_score(Global.score)
	$HUD._game_over_show()


func _on_game_over():
	$NewGame.stop()
	$GameOver.play()
	game_over()
	
func _show_finished_game():
	Global.show_final_player_msg = false
	$NewGame.stop()
	$GameOver.stop()
	yield(get_tree().create_timer(0.5), "timeout")
	$FinishedGameSound.play()
	$HUD/FinishMessage.show()
	yield(get_tree().create_timer(2), "timeout")
	$HUD/FinishMessage.hide()
	game_over()


func _on_DeckTimer_timeout():	# add and show deck
	if Global.count_deck_num > Global.MAX_DECK_NUM:
		$DeckTimer.stop()
		is_obstacle_showing = false
		is_coin_showing = false
		is_weapon_showing = false
	else:
		width = get_viewport().size.x
		var deck = Deck.instance()
		deck.position = Vector2(rand_range(-width/3, width/3), deck_limit)
		add_child(deck)
		Global.count_deck_num += 1
		print(Global.count_deck_num)
		# ==================show help seeking people=======
		if Global.count_deck_num == Global.MAX_DECK_NUM + 1:
			people = People.instance()
			var pos = deck.position
			people.position = Vector2(pos.x + 30, pos.y - 45)
			add_child(people)
			people.show()
			# the coin and the obstackle should not be shown where people
			is_people_showing = true
			is_coin_showing = false
			is_obstacle_showing = false
			is_weapon_showing = false
			$HUD.connect("start_game", people, "_clear_all")	 # clear the queue of people when start game
		#===============================================
	#	#==========followings are for obstacles=========
	#	var obstacle = Obstacle.instance()
	#	obstacle.position = deck.position
	#	add_child(obstacle)
		deck_position_where_obs = deck.position 	#deck position store for showing a obstacle on it's corresponding deck
	#	#===============================================
		
		deck_limit -= rand_range(MIN_DECK_DIF, MAX_DECK_DIF)	#actually the height between one and another deck
		
		$HUD.connect("start_game", deck, "_clear_all")	# clearing all deck when start game





func _show_obstacle():
	if is_obstacle_showing:
		var obstacle = Obstacle.instance()
		var pos = deck_position_where_obs
		obstacle.position = Vector2(pos.x + rand_range(-40, 40), pos.y - 20)
		add_child(obstacle)
		#temp_obs_position = obstacle.position
		
		$HUD.connect("start_game", obstacle, "_clear_all")	# clear all obstacle when start game
	else:
		$ObstacleTimer.stop()


func _on_count_score():
	#Global.score += 1
	$HUD.update_score(Global.score)



func _show_coin():
	if is_coin_showing:
		var coin = Coin.instance()
		var pos = deck_position_where_obs
		coin.position = Vector2(pos.x + rand_range(-40, 40) + 10, pos.y - 25)
		add_child(coin)
		
		$HUD.connect("start_game", coin, "_clear_all")	# clear all obstacle when start game
	else:
		$CoinTimer.stop()




func _on_LevelUpTimer_timeout():
	if Global.level_up:
		$LevelUpTimer.stop()
		$ScoreTimer.stop()
		$DeckTimer.stop()
		$ObstacleTimer.stop()
		$CoinTimer.stop()
		$KnifeTimer.stop()
		$KnifeCount.stop()
		
		level_up()
		
		
func level_up():
	print(Global.level)
	Global.level_up = false
	remove_child(people)
	$HUD._show_message("Level\nUP!")
	
	#=======all variable initializing when level up=========
	Global.count_deck_num = 0
	is_obstacle_showing = true
	is_coin_showing = true
	is_weapon_showing = true
	is_people_showing = false
#	#===============================================
#
#	#==========all timers start when start=========
	$DeckTimer.start()
	$ObstacleTimer.start()
	$ScoreTimer.start()
	$CoinTimer.start()
	$LevelUpTimer.start()
	$KnifeTimer.start()
	$KnifeCount.start()
	#===============================================



func _on_KnifeTimer_timeout():
	if is_weapon_showing:
		var weapon = Weapon.instance()
		var pos = deck_position_where_obs
		weapon.position = Vector2(pos.x + rand_range(-40, 40) + 10, pos.y - 20)
		add_child(weapon)
		
		$HUD.connect("start_game", weapon, "_clear_all")
	else:
		$KnifeTimer.stop()


func _on_KnifeCount_timeout():
	$HUD._update_knife(Global.knife_number)

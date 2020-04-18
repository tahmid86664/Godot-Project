extends Node

var count_deck_num = 0
const MAX_DECK_NUM = 50

var score = 0
const EVERY_SAVE_SCORE = 2000
var knife_number = 0

var level = 1
var life = 3
var level_up = false

const LEVEL_ONE_KNIFE_NEED = 3
const LEVEL_TWO_KNIFE_NEED = 5
const LEVEL_THREE_KNIFE_NEED = 7
const FINAL_LEVEL = 3

var show_final_player_msg = false

#enabling the control system
var is_control_enable = false
#===============signals==================

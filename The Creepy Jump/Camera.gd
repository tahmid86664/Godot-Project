extends Camera2D

export (NodePath) var Player
var player

func _ready():
	player = get_node(Player)
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	var player_y = player.position.y
	if player_y <= position.y:
		position = Vector2(position.x, player_y)
		
func _start(pos):
	position = pos

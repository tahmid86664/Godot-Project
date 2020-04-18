extends KinematicBody2D

signal game_over
# finished game signal
signal game_finish

var screen_size

var speed = 400
var jump_speed = 400
var gravity = 9.81
var velocity = Vector2()
const FLOOR = Vector2(0, -1)
var is_flying = false
var second_jump = false
const MAX_JUMP_COUNT = 1
var jump_count = 0
var on_ground = false

var is_dead = false
#export (NodePath) var Cam
#var cam
var score = 0
var touched_ground_once = false


func _start(pos):
	position = pos
	velocity = Vector2()
	$AnimatedSprite.play("idle")
	$Message.stop()
	$Message.hide()
	show()
	pass

func _ready():
	screen_size = get_viewport().size
	hide()
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	if Global.is_control_enable:
		if is_dead:
			$AnimatedSprite.stop()
		if Input.is_action_pressed("ui_right"):
			velocity.x += 10
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("run")
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 10
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("run")
		elif jump_count < MAX_JUMP_COUNT and Input.is_action_just_pressed("ui_up"):
			jump_count += 1
			velocity.y = -jump_speed
			on_ground = false
		else:
			velocity.x = 0
			$AnimatedSprite.play("idle")
			
	#	if !is_on_floor() and is_flying:
	#		second_jump = true
		if is_on_floor():
			on_ground = true
			jump_count = 0
		else:
			on_ground = false
		velocity.y += gravity
		velocity = move_and_slide(velocity, FLOOR)
		if not on_ground:
			if velocity.y < 0:
				$AnimatedSprite.play("jump")
			else: 
				$AnimatedSprite.play("fall")
		
		if Global.show_final_player_msg:
			$Message.show()
			$Message.play("marry_accept")
			yield(get_tree().create_timer(1.5), "timeout")
			emit_signal("game_finish")
	#	_check_game_over()
	#	position.x = clamp(position.x, 0, screen_size.x)

func _check_game_over():
	print("I'm going")
	if position.y > get_viewport().size.y:
		emit_signal("game_over")


func _on_Visibility_screen_exited():
	emit_signal("game_over")
	pass # Replace with function body.
	
func dead():
	is_dead = true
	velocity = Vector2(0, 0)
#	$AnimatedSprite.play("death")
	hide()
	yield(get_tree().create_timer(0.3), "timeout")
	emit_signal("game_over")
	pass

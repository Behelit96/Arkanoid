extends RigidBody2D

onready var break_s :AudioStreamPlayer = get_node("break")
onready var hit_s :AudioStreamPlayer = get_node("hit")
onready var lose_s :AudioStreamPlayer = get_node("lose")
onready var start_s :AudioStreamPlayer = get_node("start")
onready var you_win_s :AudioStreamPlayer = get_node("you_win")

const SPEED_X = 70
const SPEDD_Y = -400

var game_started : bool = false

func _input(event):
		if (event.is_action_pressed("mover_derecha") or event.is_action_pressed("mover_izquierda")) and not game_started:
			linear_velocity = Vector2(SPEED_X,SPEDD_Y)
			game_started  = true
			start_s.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.is_in_group("gr_block"):
			body.queue_free()
			break_s.play()
			if body.get_parent().get_child_count() == 1:
				print("GANA")
				you_win_s.play()
				get_tree().paused = true
				yield(you_win_s,"finished")
				you_win_s.play()
				queue_free()
				var replay_scn = load("res://Title/replay.tscn")
				get_parent().add_child(replay_scn.instance())
		elif body.get_name() == "border_bot":
				print("PIERDE")
				get_tree().paused = true
				lose_s.play()
				yield(lose_s,"finished") 
				queue_free()
				var replay_scn = load("res://Title/replay.tscn")
				get_parent().add_child(replay_scn.instance())
				
		else:
			hit_s.play()


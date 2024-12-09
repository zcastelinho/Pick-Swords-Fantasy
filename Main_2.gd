extends Node

@export var coin_2 : PackedScene = preload("res://Coin2.tscn")
@export var confetti : PackedScene = preload("res://ConfettiParticles.tscn")

var min_positions : Vector2 = Vector2(20, 176)
var max_positions : Vector2 = Vector2(520, 756)
var level : int = 1
var game_over : bool
var health : float = 10000
var decrease_health_speed : float = 750

func _process(delta):
	if health > 0:
		health -= delta * decrease_health_speed
		$UI/HealthBar.value = health
	else:
		$GameOver.show()
		game_over = true

func _ready():
	instantiate_coins_2()

func level_passed() -> void:
	health = 10000
	level += 1
	$UI/LevelLabel.text = "Level: " + str(level)
	instantiate_coins_2()
	instantiate_confetti()
	
func instantiate_coins_2() -> void:
	for i in range(level):
		var coin_2_instance : Area2D = coin_2.instantiate()
		var random_x : float = randf_range(min_positions.x, max_positions.x)
		var random_y : float = randf_range(min_positions.y, max_positions.y)
		coin_2_instance.position = Vector2(random_x, random_y)
		call_deferred("add_child", coin_2_instance)

func instantiate_confetti() -> void:
	var confetti_instance : CPUParticles2D = confetti.instantiate()
	add_child(confetti_instance)
	confetti_instance.emitting = true;

func _on_timer_timeout() -> void:
	var final_score = ScoreMananger.total_score
	$fial_tale/ScoreLabel.text = "Score Final: " + str(final_score)
	$fial_tale.show()

func reset_game():
	ScoreMananger.total_score = 0
	

extends Node

var score = 0
var is_game_over = false

func reset_valeus():
	score = 0
	is_game_over = false

func increase_score(increase_amount: int):
	score += increase_amount

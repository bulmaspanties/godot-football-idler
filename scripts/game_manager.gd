extends Node
## Central game manager handling core systems and game state

# Autoload singleton - add to Project Settings > Autoload as "GameManager"

signal resource_updated
signal battle_completed

var player_resources: Dictionary = {
	"currency": 0,
	"points": 0,
}

var team_data: Dictionary = {
	"players": [],
	"level": 1,
	"wins": 0,
	"losses": 0,
}

func _ready() -> void:
	print("GameManager initialized")
	# Initialize default resources
	player_resources["currency"] = 100

func add_currency(amount: int) -> void:
	player_resources["currency"] += amount
	print("Currency: %d" % player_resources["currency"])
	resource_updated.emit()

func add_points(amount: int) -> void:
	player_resources["points"] += amount
	resource_updated.emit()

func get_currency() -> int:
	return player_resources["currency"]

func record_win() -> void:
	team_data["wins"] += 1
	add_currency(10)
	battle_completed.emit()

func record_loss() -> void:
	team_data["losses"] += 1
	battle_completed.emit()

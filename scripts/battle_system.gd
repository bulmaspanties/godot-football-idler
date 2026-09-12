extends Node
## Handles auto-battler combat logic and turn progression

class_name BattleSystem

signal battle_started
signal turn_executed
signal battle_ended(winner: String)

var player_team: Array[Player] = []
var enemy_team: Array[Player] = []
var current_turn: int = 0
var is_battle_active: bool = false
var battle_speed: float = 1.0  # Can be upgraded

func _ready() -> void:
	set_process(false)

func start_battle(player_fighters: Array[Player], enemy_fighters: Array[Player]) -> void:
	player_team = player_fighters
	enemy_team = enemy_fighters
	current_turn = 0
	is_battle_active = true
	set_process(true)
	battle_started.emit()
	print("Battle started!")

func _process(delta: float) -> void:
	if is_battle_active:
		execute_turn()

func execute_turn() -> void:
	if not is_battle_active:
		return
	
	# Get alive players from both teams
	var alive_players = player_team.filter(func(p): return p.is_alive)
	var alive_enemies = enemy_team.filter(func(e): return e.is_alive)
	
	# Check win conditions
	if alive_enemies.is_empty():
		end_battle("player")
		return
	
	if alive_players.is_empty():
		end_battle("enemy")
		return
	
	# Simple turn logic: random player attacks random enemy
	var attacker = alive_players[randi() % alive_players.size()]
	var defender = alive_enemies[randi() % alive_enemies.size()]
	
	var damage = attacker.calculate_damage()
	defender.take_damage(damage)
	
	print("%s attacks %s for %d damage" % [attacker.name, defender.name, damage])
	
	current_turn += 1
	turn_executed.emit()
	
	await get_tree().create_timer(1.0 / battle_speed).timeout

func end_battle(winner: String) -> void:
	is_battle_active = false
	set_process(false)
	battle_ended.emit(winner)
	
	if winner == "player":
		GameManager.record_win()
		print("Player wins!")
	else:
		GameManager.record_loss()
		print("Enemy wins!")

extends Node
## Idle/Incremental system - auto-generates currency over time

class_name IdleSystem

var idle_rate: float = 1.0  # Currency per second
var total_idle_earnings: int = 0

func _ready() -> void:
	set_process(true)
	print("Idle system started - earning %.1f currency/sec" % idle_rate)

func _process(delta: float) -> void:
	# Generate currency based on idle rate
	var earnings = idle_rate * delta
	total_idle_earnings += earnings
	
	# Add to GameManager when we've earned at least 1 full unit
	if total_idle_earnings >= 1.0:
		var amount_to_add = int(total_idle_earnings)
		GameManager.add_currency(amount_to_add)
		total_idle_earnings -= amount_to_add

func set_idle_rate(new_rate: float) -> void:
	idle_rate = new_rate
	print("Idle rate updated to %.1f currency/sec" % idle_rate)

func get_idle_rate() -> float:
	return idle_rate

func upgrade_idle_rate(multiplier: float) -> void:
	idle_rate *= multiplier
	print("Idle rate upgraded to %.1f currency/sec" % idle_rate)

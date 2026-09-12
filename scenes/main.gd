extends Control
## Main scene controller for the game

@onready var ui_manager = $UIManager

func _ready() -> void:
	print("Football Idler loaded!")
	# UIManager will handle all the display

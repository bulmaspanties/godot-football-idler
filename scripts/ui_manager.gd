extends Control
## Main UI Controller - Displays game state and handles player interactions

@onready var currency_label = Label.new()
@onready var points_label = Label.new()
@onready var team_level_label = Label.new()
@onready var win_loss_label = Label.new()
@onready var start_battle_button = Button.new()
@onready var shop_button = Button.new()

func _ready() -> void:
	setup_ui()
	connect_signals()
	update_display()

func setup_ui() -> void:
	# Set background color
	modulate = Color.WHITE
	
	# Currency Display (Top Left)
	currency_label.text = "Currency: $%d" % GameManager.get_currency()
	currency_label.add_theme_font_size_override("font_size", 24)
	currency_label.position = Vector2(20, 20)
	add_child(currency_label)
	
	# Points Display (Top Center)
	points_label.text = "Points: %d" % GameManager.player_resources["points"]
	points_label.add_theme_font_size_override("font_size", 24)
	points_label.position = Vector2(400, 20)
	add_child(points_label)
	
	# Team Level Display (Top Right)
	team_level_label.text = "Team Level: %d" % GameManager.team_data["level"]
	team_level_label.add_theme_font_size_override("font_size", 24)
	team_level_label.position = Vector2(900, 20)
	add_child(team_level_label)
	
	# Win/Loss Record (Center Left)
	update_win_loss_display()
	win_loss_label.add_theme_font_size_override("font_size", 32)
	win_loss_label.position = Vector2(100, 250)
	add_child(win_loss_label)
	
	# Start Battle Button (Center)
	start_battle_button.text = "START BATTLE"
	start_battle_button.size = Vector2(300, 100)
	start_battle_button.position = Vector2(490, 300)
	start_battle_button.pressed.connect(_on_start_battle_pressed)
	add_child(start_battle_button)
	
	# Shop Button (Bottom Right)
	shop_button.text = "SHOP"
	shop_button.size = Vector2(150, 60)
	shop_button.position = Vector2(1050, 600)
	shop_button.pressed.connect(_on_shop_pressed)
	add_child(shop_button)

func connect_signals() -> void:
	GameManager.connect("resource_updated", Callable(self, "_on_resource_updated"))

func update_display() -> void:
	currency_label.text = "Currency: $%d" % GameManager.get_currency()
	points_label.text = "Points: %d" % GameManager.player_resources["points"]
	team_level_label.text = "Team Level: %d" % GameManager.team_data["level"]
	update_win_loss_display()

func update_win_loss_display() -> void:
	var wins = GameManager.team_data["wins"]
	var losses = GameManager.team_data["losses"]
	win_loss_label.text = "Record: %d - %d" % [wins, losses]

func _on_resource_updated() -> void:
	update_display()

func _on_start_battle_pressed() -> void:
	print("Battle start requested!")
	# TODO: Transition to battle scene
	start_battle_button.disabled = true
	await get_tree().create_timer(2.0).timeout
	start_battle_button.disabled = false

func _on_shop_pressed() -> void:
	print("Shop opened!")
	# TODO: Open shop UI

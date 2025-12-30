extends Node2D

@export var current_layout: int
@onready var layoutManager:= $LayoutManager
@onready var player:= $player
var left_world: Vector2
var right_world: Vector2 
@onready var exitRight = $ExitRight
@onready var exitLeft = $ExitLeft

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewportCenter = get_viewport().get_camera_2d().global_position
	var screen_size = get_viewport().get_visible_rect().size
	left_world = viewportCenter - screen_size/2
	right_world = viewportCenter + screen_size/2
	layoutManager.handleTransition(current_layout, "special")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onExitTriggered(eventName: String) -> void:
	layoutManager.handleTransition(current_layout, eventName) # Replace with function body.
	repositionPlayer(eventName)

func repositionPlayer(eventName: String):
	if eventName == "right":
		player.position = Vector2(left_world.x, player.position.y)
		exitRight.reset()
	elif eventName == "left":
		player.position = Vector2(right_world.x, player.position.y)
		exitLeft.reset()

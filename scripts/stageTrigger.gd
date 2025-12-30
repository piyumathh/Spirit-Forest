extends Area2D
class_name stageTrigger

@export var eventName: String #left, right, special
@export var oneShot := true

signal triggered(eventName: String)
var used := false
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if used and oneShot:
		return 
	if body.is_in_group("player"):
		used = true	
		emit_signal("triggered", eventName)# Replace with function body.
		
func reset():
	used = false

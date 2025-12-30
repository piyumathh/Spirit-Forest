extends Node2D

@export var slideTime := 0.01
@export var stagger := 0.5
var propsParent: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	propsParent = Node2D.new()
	add_child(propsParent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func populate(layout: StageLayout):
	propsParent.queue_free()
	propsParent = Node2D.new()
	add_child(propsParent)
	
	for i in layout.placements.size():
		spawnProp(layout.placements[i], i)
		
func spawnProp(p: PropPlacement, index: int):
	var prop: Node2D = p.scene.instantiate()
	prop.position = getOffscreenPosition(p.position)
	prop.rotation = p.rotation
	prop.scale = p.scale
	if prop is CanvasItem:
		prop.z_index = p.depth
	
	propsParent.add_child(prop)
	
	var tween = create_tween()
	tween.tween_property(prop, "position", p.position, slideTime*abs(position.x - p.position.x))\
	.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_delay(index * stagger)
	print(abs(position.x - p.position.x))
	
	
func getOffscreenPosition(targetPos: Vector2) -> Vector2:
	var cam := get_viewport().get_camera_2d()
	if cam == null:
		return targetPos
		
	var viewportCenter = cam.global_position
	var screen_size = get_viewport().get_visible_rect().size
	var rect_position = viewportCenter - screen_size / 2
	var rect_end = viewportCenter + screen_size / 2
	var margin := 128 
	
	if targetPos.x < viewportCenter.x:
		return Vector2(rect_position.x - margin, targetPos.y)
	else:
		return Vector2(rect_end.x + margin, targetPos.y)		

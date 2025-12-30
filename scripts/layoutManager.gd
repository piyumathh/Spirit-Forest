extends Node

@export var layouts: Array[StageLayout] = []
@onready var propSpawner := $PropSpawner
var transitions: Dictionary = {
	[0, "special"]: 0,
	[0, "right"]: 1,
	[1, "left"]: 0,
	[1, "right"]: 2,
	[2, "left"]: 1,
	[2, "right"]: 3,
	[3, "left"]: 2,
	[3, "right"]: 4,
	[3, "special"]: 0,
	[4, "left"]: 3
}
func handleTransition(currentLayout: int, transition: String):
	var currentTransition = [currentLayout, transition]
	var nextLayout = transitions[currentTransition]
	propSpawner.populate(layouts[nextLayout])
	get_parent().current_layout = nextLayout
	
	
	

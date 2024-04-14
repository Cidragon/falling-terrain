extends HBoxContainer
@onready var range: Label = %range

var mouse_range : int = 1
var min_range : int = 1
var max_range : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	range.text = str(mouse_range)
	Signals.set_mouse_range.emit(mouse_range)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_decrease_button_up() -> void:
	if mouse_range > min_range:
		mouse_range -= 1
		range.text = str(mouse_range)
		Signals.set_mouse_range.emit(mouse_range)


func _on_increase_button_up() -> void:
	if mouse_range < max_range:
		mouse_range += 1
		range.text = str(mouse_range)
		Signals.set_mouse_range.emit(mouse_range)

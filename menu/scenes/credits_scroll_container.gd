extends ScrollContainer

var scroll_stop = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_vertical_custom_step = 0.001


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	await get_tree().create_timer(1.5).timeout
	if !scroll_stop:
		scroll_vertical+=1
	if scroll_vertical == 142:
		scroll_stop = true
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes//main_menu.tscn")
	

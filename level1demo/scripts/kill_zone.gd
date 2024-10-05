extends Area2D
@onready var timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("YOU DIED")
		timer.start()
		print("timer started")

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	print("Timer finished, reloading scene")

# DetectionArea.gd
extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(get_parent(), "_on_detection_area_body_entered"))
	connect("body_exited", Callable(get_parent(), "_on_detection_area_body_exited"))

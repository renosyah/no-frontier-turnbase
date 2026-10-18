extends Node

const dekstops =  ["Server", "Windows", "WinRT", "X11"]

func _ready():
	setup_transition()
	
##########################################  transisiion  ############################################
var transition :CanvasLayer

func setup_transition():
	transition = preload("res://assets/user_interface/transision_screen/transision_screen.tscn").instance()
	add_child(transition)
	
func change_scene(scene :String, use :bool = false, bg_idx :int = 0):
	transition.change_scene(scene, use, bg_idx)
	
func hide_transition():
	transition.hide_transition()
	

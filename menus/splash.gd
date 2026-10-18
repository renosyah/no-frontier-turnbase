extends Control

func _ready():
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	
	yield(get_tree().create_timer(1),"timeout")
	Global.change_scene("res://menus/main_menu/main_menu.tscn", true)

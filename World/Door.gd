extends Area2D

@export_file("*.tscn") var target_level_path = ""
#export(String, FILE, "*.tscn") var target_level_path = ""

func _on_body_entered(body):
	print("entered door")
	if not body is Player: return   #if not player then return
	if target_level_path.is_empty(): return  #if no path then return
	get_tree().change_scene_to_file(target_level_path)

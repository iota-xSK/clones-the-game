extends GridContainer

export (PackedScene) var LevelButton
var level_folder = "res://Levels/"


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(path + file)
			
	dir.list_dir_end()
	#files.sort()
	
	return files

func _ready():
	var levels = list_files_in_directory(level_folder)
	var level_dict = {}
	
	for level in levels:
		var level_name = ""
		var digits = "1234567890"
		for c in level:
			if c in digits:
				level_name += c
#		level_names.append(level_name)
		level_dict[int(level_name)] = level

	print(levels, level_dict)
	
	for i in range(len(level_dict)):
		var button_instance = LevelButton.instance()
		add_child(button_instance)
		button_instance.text = str(i)
		print(level_dict[i])
		button_instance.level_path = level_dict[i]
#		button_instance.test_thing = "test"
		
	
	

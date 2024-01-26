class_name RemapButton extends Button

var user_prefs : UserPreferences
@export var action: String

# Called when the node enters the scene tree for the first time.
func _ready():
	if(user_prefs == null):
		user_prefs = UserPreferences.load_or_create_prefs()
	
	text = InputMap.action_get_events(action)[0].as_text()

func intiialize():
	pass

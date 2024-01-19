class_name UserPreferences extends Resource

@export_range(0, 1, 0.5) var music_audio_level: float = 0.8
@export_range(0, 1, 0.5) var sfx_audio_levelS: float = 0.8
#@export var input_type: Game.INPUT_SCHEMES = Game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE
@export var action_events: Dictionary = {}

func save() -> void :
    ResourceSaver.save(self, "user://user_prefs.tres")

static func load_or_create_prefs() -> UserPreferences :
    var res : UserPreferences = load("user://user_prefs.tres") as UserPreferences
    if !res:
        res = UserPreferences.new()
    return res
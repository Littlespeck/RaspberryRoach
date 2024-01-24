class_name UserPreferences extends Resource

@export_range(0, 1, 0.5) var master_audio_level: float = 0.8
@export_range(0, 1, 0.5) var music_audio_level: float = 0.8
@export_range(0, 1, 0.5) var sfx_audio_level: float = 0.8
#@export var resolution: Vector2i = Vector2i(720,1280)
@export var screen_option :int = 0
@export var max_framerate: int = 0
@export var v_sync: bool = true

#@export var input_type: Game.INPUT_SCHEMES = Game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE
@export var action_events: Dictionary = {}

func save() -> void :
    ResourceSaver.save(self, "user://user_prefs.tres")

static func load_or_create_prefs() -> UserPreferences :
    var res : UserPreferences
    #print(ResourceLoader.exists("user://user_prefs.tres"))
    if (ResourceLoader.exists("user://user_prefs.tres")):
        res = load("user://user_prefs.tres") as UserPreferences
    else :
        res = UserPreferences.new()
  
    return res

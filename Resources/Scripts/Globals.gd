extends Node

signal _toggle_options_menu(value:bool)
signal _toggle_menu(value:bool)
signal _reset_user_prefs()
signal _intialize_user_prefs()

var high_score_table = {
	"Score1": 0,
	"Score2": 0,
	"Score3": 0
}

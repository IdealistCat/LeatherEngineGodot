extends Node

# self explanatory
signal player_note_hit(note, dir, type, character)
signal enemy_note_hit(note, dir, type, character)
# must_hit is basically asking if it's a player side note or not btw
signal note_hit(note, dir, type, character, must_hit)

# called when the player misses a note
signal note_miss(note, dir, type, character)

# called every time an event is setup (not sure if this is useful, but better be safe than sorry)
signal event_setup(event)

# called every time an event is triggered
signal event_processed(event)

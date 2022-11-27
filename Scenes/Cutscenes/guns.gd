extends Cutscene

onready var music: AudioStreamPlayer = $Music
onready var guns: AudioStreamPlayer = $"Guns Cutscene"

onready var tank_1: AnimatedSprite = $"Tankman 1"

onready var hud: CanvasLayer = $"../UI"
var move_hud: bool = true

var good_cam_zoom: Vector2 = Vector2(1,1)
onready var default_cam_zoom: float = $"../".defaultCameraZoom

onready var mod: CanvasModulate = $"../UI/Modulate"

func _ready() -> void:
	mod.color.a = 0
	
	music.play()
	
	camera.position = dad.position + dad.camOffset + Vector2(-175, -25)
	guns.play()
	
	dad.visible = false
	
	tank_1.visible = true
	tank_1.frame = 0
	tank_1.position = dad.position
	tank_1.play("cutscene")
	
	var tween: Tween = Tween.new()
	tween.interpolate_property(self, "good_cam_zoom", Vector2(1,1), Vector2(0.9,0.9), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 0.2)
	add_child(tween)
	tween.start()
	
	yield(get_tree().create_timer(4), "timeout")
	
	gf.play_animation("sad")
	gf.dances = false
	
	tween.interpolate_property(self, "good_cam_zoom", Vector2(0.9,0.9), Vector2(0.8,0.8), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(get_tree().create_timer(guns.stream.get_length() - 4), "timeout")
	
	camera.position = bf.position + Vector2(-1 * bf.camOffset.x, bf.camOffset.y)
	
	game.cam_locked = true
	
	gf.dances = true
	
	emit_signal("finished")
	
	camera.position = dad.position + dad.camOffset
	
	move_hud = false
	
	tank_1.visible = false
	dad.visible = true
	
	mod.color.a = 1
	
	tween.interpolate_property(self, "good_cam_zoom", Vector2(0.8, 0.8), Vector2(default_cam_zoom, default_cam_zoom), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	game.cam_locked = false
	
	queue_free()

func _physics_process(delta: float) -> void:
	if move_hud:
		hud.offset.y = -720

func _process(delta: float) -> void:
	camera.zoom = good_cam_zoom
	
	if gf.last_anim == "sad":
		if gf.anim_player:
			if gf.anim_player.current_animation == "":
				gf.play_animation("sad", true)

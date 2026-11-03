extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F1:
		get_parent().get_node("Player").release_controls()
		var dialog := AcceptDialog.new()
		dialog.title = "Credits and licenses"
		add_child(dialog)
		var text := TextEdit.new()
		text.editable = false
		text.custom_minimum_size = Vector2(720, 450)
		text.text = "Apartment FPP\nModels, materials and code authored for this repository.\nGodot Engine 4.7.2 — https://godotengine.org/license/\n\n" + Engine.get_license_text() + "\n\nThird-party notices:\n" + JSON.stringify(Engine.get_copyright_info(), "  ")
		dialog.add_child(text)
		dialog.confirmed.connect(dialog.queue_free)
		dialog.canceled.connect(dialog.queue_free)
		dialog.popup_centered()

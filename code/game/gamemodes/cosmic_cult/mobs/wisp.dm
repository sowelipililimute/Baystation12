/mob/living/cosmic_cult/wisp
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"

/mob/living/cosmic_cult/wisp/Initialize()
	. = ..()
	update_icon()
	set_light(4, 2, "#42a4ae")

	add_language(LANGUAGE_MALIGN_LOCAL)
	set_default_language(all_languages[LANGUAGE_MALIGN_LOCAL])

/mob/living/cosmic_cult/wisp/on_update_icon()
	ClearOverlays()

	underlays = list()
	underlays += image('icons/coscult/cosmic-wisp.dmi', "shadow-medium", pixel_z = -8)

	var/image/overlay = overlay_image('icons/coscult/cosmic-wisp.dmi', "wisp")
	overlay.pixel_z = 8
	var/image/emissive = emissive_appearance('icons/coscult/cosmic-wisp.dmi', "wisp")
	emissive.pixel_z = 8

	AddOverlays(list(overlay, emissive))

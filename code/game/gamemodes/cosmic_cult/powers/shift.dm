/datum/power/cosmic_cult/shift
	name = "Astral Shift"
	desc = "Slip out of phase with realspace in order to temporarily access the cosmic dark. You'll automatically return to where you left from after a period of time."
	ability_icon_state = "shift"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/shift

/datum/cosmic_cultist/proc/shift(list/params)
	set category = "Cosmic Cult"
	set name = "Siphon Entropy"

	var/mob/living/carbon/human/target = get_target(params)
	if (do_after(usr, 0.9 SECONDS, target))
		cosmic_cult_siphon_vfx(target, usr.client)

/datum/power/cosmic_cult/shunt
	name = "Shunt Subjectivity"
	desc = "Shunt your target's mind out of their body and unto the cosmic dark, temporarily rendering their body mindless."
	ability_icon_state = "shunt"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/shunt

/datum/power/cosmic_cult/shunt/can_target(atom/A)
	return !is_cosmic_cultist(A) && ishuman(A)

/datum/cosmic_cultist/proc/shunt(list/params)
	set category = "Cosmic Cult"
	set name = "Shunt Subjectivity"

	var/mob/living/carbon/human/target = get_target(params)
	if (!istype(target))
		return

	if (do_after(usr, 0.6 SECONDS, target))
		cosmic_cult_shunt_vfx(target, usr.client)

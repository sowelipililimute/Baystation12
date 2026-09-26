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
	var/datum/mind/mind = target.mind
	if (!istype(target) || !istype(mind))
		return

	if (!do_after(usr, 0.6 SECONDS, target))
		return

	cosmic_cult_shunt_vfx(target)

	var/turf/entry = pick(GLOB.cosmic_dark_entries)
	var/mob/wisp = new /mob/living/cosmic_cult/wisp(entry)
	mind.transfer_to(wisp)
	cosmic_cult_shunt_vfx(wisp)

	sleep(22 SECONDS)

	var/datum/action/action = new /datum/action/cosmic_cult/astral_return(target)
	action.Grant(wisp)

/datum/action/cosmic_cult/astral_return
	name = "Astral Return"
	desc = "Return back to your body."
	button_icon = 'icons/coscult/cosmic-actions.dmi'
	button_icon_state = "return"
	background_icon_state = "default"
	action_type = AB_INNATE

/datum/action/cosmic_cult/astral_return/Activate()
	owner.mind?.transfer_to(target)

	cosmic_cult_shunt_vfx(owner)
	qdel(owner)
	qdel(src)

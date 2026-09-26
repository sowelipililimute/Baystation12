/datum/power/cosmic_cult/shift
	name = "Astral Shift"
	desc = "Slip out of phase with realspace in order to access the cosmic dark."
	ability_icon_state = "shift"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/shift

/datum/cosmic_cultist
	var/turf/return_to

/datum/cosmic_cultist/proc/shift(list/params)
	set category = "Cosmic Cult"
	set name = "Astral Shift"

	return_to = owning_mind.current.loc
	var/turf/entry = pick(GLOB.cosmic_dark_entries)
	var/mob/target = owning_mind.current

	if (istype(get_area(target), /area/cosmic_dark))
		return

	cosmic_cult_shift_vfx(target)
	cosmic_cult_sink_out(target)
	sleep(2 SECONDS)

	target.forceMove(entry)
	cosmic_cult_shift_vfx(target)
	sleep(1 SECONDS)
	cosmic_cult_sink_in(target)

	grant_power(/datum/power/cosmic_cult/astral_return)

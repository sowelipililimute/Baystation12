/datum/power/cosmic_cult/astral_return
	name = "Astral Return"
	desc = "Slip back into phase with realspace to return to where you came from."
	ability_icon_state = "return"
	innate_power = FALSE
	verbpath = /datum/cosmic_cultist/proc/astral_return

/datum/cosmic_cultist/proc/astral_return(list/params)
	set category = "Cosmic Cult"
	set name = "Astral Return"

	cosmic_cult_shift_vfx(owning_mind.current)
	cosmic_cult_sink_out(owning_mind.current)
	sleep(2 SECONDS)

	owning_mind.current.forceMove(return_to)
	cosmic_cult_shift_vfx(owning_mind.current)
	sleep(1 SECONDS)
	cosmic_cult_sink_in(owning_mind.current)

	return_to = null

	revoke_power(/datum/power/cosmic_cult/astral_return)

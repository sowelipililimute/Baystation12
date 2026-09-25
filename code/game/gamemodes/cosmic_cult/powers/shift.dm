/datum/power/cosmic_cult/shift
	name = "Astral Shift"
	desc = "Slip out of phase with realspace in order to temporarily access the cosmic dark. You'll automatically return to where you left from after a period of time."
	ability_icon_state = "shift"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/shift

/datum/cosmic_cultist/proc/shift(list/params)
	set category = "Cosmic Cult"
	set name = "Astral Shift"

	var/turf/exit = owning_mind.current.loc
	var/turf/entry = pick(GLOB.cosmic_dark_entries)
	var/mob/target = owning_mind.current

	cosmic_cult_shift_vfx(target)
	var/entry_filter = cosmic_cult_sink_out(target)
	sleep(2 SECONDS)

	target.forceMove(entry)
	cosmic_cult_shift_vfx(target)
	sleep(1 SECONDS)
	cosmic_cult_sink_in(target, entry_filter)

	do_after(usr, 35 SECONDS, usr, DO_BOTH_CAN_MOVE | DO_SHOW_PROGRESS | DO_BOTH_CAN_TURN | DO_USER_INTERRUPT, INCAPACITATION_NONE)

	cosmic_cult_shift_vfx(owning_mind.current)
	var/exit_filter = cosmic_cult_sink_out(target)
	sleep(2 SECONDS)

	target.forceMove(exit)
	cosmic_cult_shift_vfx(owning_mind.current)
	sleep(1 SECONDS)
	cosmic_cult_sink_in(target, exit_filter)

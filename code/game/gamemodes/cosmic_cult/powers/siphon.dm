/datum/power/cosmic_cult/siphon
	name = "Siphon Entropy"
	desc = "Stealthily siphon entropy from your target. Siphoning large amounts of entropy will increase your power."
	ability_icon_state = "siphon"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/siphon

/datum/power/cosmic_cult/siphon/can_target(atom/A)
	return !is_cosmic_cultist(A) && ishuman(A)

/datum/cosmic_cultist/proc/siphon(list/params)
	set category = "Cosmic Cult"
	set name = "Siphon Entropy"

	var/turf/exit = owning_mind.current.loc
	var/turf/entry = pick(GLOB.cosmic_dark_entries)
	owning_mind.current.forceMove(entry)

	do_after(usr, 35 SECONDS, usr, DO_BOTH_CAN_MOVE | DO_SHOW_PROGRESS | DO_BOTH_CAN_TURN | DO_USER_INTERRUPT, INCAPACITATION_NONE)

	owning_mind.current.forceMove(exit)

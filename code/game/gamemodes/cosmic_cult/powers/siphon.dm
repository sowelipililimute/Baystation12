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

	var/mob/living/carbon/human/target = get_target(params)
	log_and_message_admins("[usr] targeted [target] using [params]")
